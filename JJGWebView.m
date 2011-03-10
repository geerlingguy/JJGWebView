//
//  JJGWebView.m
//
//  Created by Jeff Geerling on 2/11/11.
//  Copyright 2011 Midwestern Mac, LLC. All rights reserved.
//

#import "JJGWebView.h"
#import "SHK.h"


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
	
	// webViewURL gets passed in from other views - form URL request with it
	NSURLRequest *requestObj = [NSURLRequest requestWithURL:webViewURL];

	// Load URL in UIWebView
	[webView loadRequest:requestObj];
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
	
	// Create the item to share (url from webView)
	NSURL *url = [[webView request] URL];
	NSString *currentTitle = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
	SHKItem *item = [SHKItem URL:url title:currentTitle];
	
	// Get the ShareKit action sheet
	SHKActionSheet *actionSheet = [SHKActionSheet actionSheetForItem:item];
	
	// Display the action sheet over the entire window - otherwise cancel button is jinxed.
	[actionSheet showInView:self.navigationController.view];

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
