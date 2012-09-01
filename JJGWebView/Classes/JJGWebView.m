//
//  JJGWebView.m
//
//  Created by Jeff Geerling on 2/11/11.
//  Copyright 2011 Midwestern Mac, LLC. All rights reserved.
//

#import "JJGWebView.h"


@implementation JJGWebView

@synthesize webViewToolbar, webView, webViewURL, actionButton, refreshButton, backButton, forwardButton;


#pragma mark Regular controller methods

- (void)viewDidLoad {
    [super viewDidLoad];
	
	// Kick off the activity indicator on first load.
	[activityIndicator startAnimating];
	
	// For testing:
	//	NSString *urlAddress = @"http://archstl.org/";
	//	NSURL *url = [NSURL URLWithString:urlAddress];
	//	NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
	
	if (webViewURL != nil) {
		// webViewURL gets passed in from other views - form URL request with it
		NSURLRequest *requestObj = [NSURLRequest requestWithURL:webViewURL];
		// Load URL in UIWebView
		[webView loadRequest:requestObj];
	} else {
		NSLog(@"What to do? We don't have a URL...");
	}
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
	// We allow rotation.
    return YES;
}


#pragma mark Web View methods

- (void)webViewDidStartLoad:(UIWebView *)wv {
	[activityIndicator startAnimating]; // @todo - NOT HAPPENING...
	
	// Disable Action bar button item...
	self.actionButton.enabled = NO;
	self.refreshButton.enabled = NO;
}

- (void)webViewDidFinishLoad:(UIWebView *)wv {
	[activityIndicator stopAnimating]; // @todo - NOT HAPPENING...
	
	// Enable Action bar button item...
	self.actionButton.enabled = YES;
	self.refreshButton.enabled = YES;
	
	[backButton setEnabled:[webView canGoBack]]; // Enable or disable back
	[forwardButton setEnabled:[webView canGoForward]]; // Enable or disable forward
	
	// Set the title of the new page.
	self.title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
}

- (void)webView:(UIWebView *)wv didFailLoadWithError:(NSError *)error {
	[activityIndicator stopAnimating];
	
	// Make sure there's an actual error, and the error is not -999 (JS-induced, or WebKit bug)
    if (error != NULL && ([error code] != NSURLErrorCancelled)) {
		// NSLog(@"Error: %@", error);
		
		if ([error code] != NSURLErrorCancelled) {
			//show error alert, etc.
		}
        UIAlertView *errorAlert = [[UIAlertView alloc]
								   initWithTitle:@"Error Loading Page"
								   message: [error localizedFailureReason]
								   delegate:nil
								   cancelButtonTitle:@"OK"
								   otherButtonTitles:nil];
        [errorAlert show];
        [errorAlert release];
    }
}


#pragma mark IBAction outlets

- (IBAction)actionButtonSelected:(id)sender {
    if (actionButtonActionSheet != nil) {
        return;
    }

    // Get the url and title from webView.
    NSURL *url = [[webView request] URL];

    // Create an action sheet.
    actionButtonActionSheet = [[UIActionSheet alloc] initWithTitle:[url absoluteString]
                                                          delegate:self
                                                 cancelButtonTitle:@"Cancel"
                                            destructiveButtonTitle:nil
                                                 otherButtonTitles:@"Email Link", @"Open in Browser", @"Post to Twitter", nil];

    // Check if we're using an iPad or iPhone
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        // For iPad: Display the action sheet over the bar button item.
        // @todo - If a user repeatedly taps the action button, multiple popups appear, overlaying one another.
        [actionButtonActionSheet showFromBarButtonItem:actionButton animated:NO];
    } else {
        // For iPhone/iPod Touch: Display the action sheet over the entire window - otherwise cancel button is jinxed.
        [actionButtonActionSheet showInView:self.navigationController.view];
    }
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSURL *url = [[webView request] URL];
    NSString *currentTitle = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];

    switch (buttonIndex) {
        case 0: { // Email URL.
            MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
            picker.mailComposeDelegate = self;
            [picker setSubject:@"Emailed Link"];
            [picker setMessageBody:[NSString stringWithFormat:@"<a href=\"%@\">%@</a>", url, currentTitle] isHTML:YES];
            [self presentModalViewController:picker animated:YES];
            [picker release];
            break;
        }
        case 1: { // Open URL in browser.
            [[UIApplication sharedApplication] openURL:url];
            break;
        }
        case 2: { // Share link on Twitter.
            if ([TWTweetComposeViewController canSendTweet]) {
                TWTweetComposeViewController *tweetSheet = [[TWTweetComposeViewController alloc] init];
                [tweetSheet setInitialText:currentTitle];
                [self presentModalViewController:tweetSheet animated:YES];
            }
            else {
                UIAlertView *errorAlert = [[UIAlertView alloc]
                                           initWithTitle:@"Can't Send Tweet"
                                           message:@"Please make sure your Twitter account are configured correctly in your device settings."
                                           delegate:nil
                                           cancelButtonTitle:@"OK"
                                           otherButtonTitles:nil];
                [errorAlert show];
                [errorAlert release];
            }
            break;
        }
        default:
            break;
        }

    // Reset action button sheet.
    actionButtonActionSheet = nil;
}


#pragma mark MFMailComposeViewController delegate methods

-(void)mailComposeController:(MFMailComposeViewController *)controller
         didFinishWithResult:(MFMailComposeResult)result
                       error:(NSError *)error {
    [self dismissModalViewControllerAnimated:YES];
}


#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[webView release];
	[webViewURL release];
	[actionButton release];
    [super dealloc];
}


@end
