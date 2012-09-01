//
//  JJGWebViewAppDelegate.h
//  JJGWebView
//
//  Created by Jeff Geerling on 3/10/11.
//  Copyright 2011 Midwestern Mac, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JJGWebViewViewController;

@interface JJGWebViewAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    UINavigationController *navController;
}

@property (nonatomic, strong) IBOutlet UIWindow *window;
@property (nonatomic, strong) IBOutlet UINavigationController *navController;

@end

