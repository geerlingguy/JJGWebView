//
//  JJGWebViewAppDelegate.m
//  JJGWebView
//
//  Created by Jeff Geerling on 3/10/11.
//  Copyright 2011 Midwestern Mac, LLC. All rights reserved.
//

#import "JJGWebViewAppDelegate.h"
#import "JJGWebViewViewController.h"

@implementation JJGWebViewAppDelegate

@synthesize window;
@synthesize navController;

#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Add the view controller's view to the window and display.
    [self.window addSubview:navController.view];
    [self.window makeKeyAndVisible];

    return YES;
}

#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}

@end
