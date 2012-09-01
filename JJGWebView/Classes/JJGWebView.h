//
//  JJGWebView.h
//
//  Created by Jeff Geerling on 2/11/11.
//  Copyright 2011 Midwestern Mac, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>
#import <Twitter/Twitter.h>
#import <Twitter/TWTweetComposeViewController.h>

@interface JJGWebView : UIViewController <UITextFieldDelegate, UIWebViewDelegate, UIActionSheetDelegate, MFMailComposeViewControllerDelegate> {

	IBOutlet UIToolbar *webViewToolbar;
	IBOutlet UIWebView *webView;
	IBOutlet UIActivityIndicatorView *activityIndicator;
	IBOutlet UIBarButtonItem *actionButton;
	IBOutlet UIBarButtonItem *refreshButton;
	IBOutlet UIBarButtonItem *backButton;
	IBOutlet UIBarButtonItem *forwardButton;

	UIActionSheet *actionButtonActionSheet;
	NSURL *webViewURL;

}

@property (nonatomic,retain) UIToolbar *webViewToolbar;
@property (nonatomic,retain) UIWebView *webView;
@property (nonatomic,retain) NSURL *webViewURL;
@property (nonatomic,retain) UIBarButtonItem *actionButton;
@property (nonatomic,retain) UIBarButtonItem *refreshButton;
@property (nonatomic,retain) UIBarButtonItem *backButton;
@property (nonatomic,retain) UIBarButtonItem *forwardButton;

- (IBAction)actionButtonSelected:(id)sender;

@end
