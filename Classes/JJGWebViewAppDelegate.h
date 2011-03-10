//
//  JJGWebViewAppDelegate.h
//  JJGWebView
//
//  Created by Jeff Geerling on 3/10/11.
//  Copyright 2011 Archdiocese of Saint Louis. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JJGWebViewViewController;

@interface JJGWebViewAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    UINavigationController *navController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navController;

@end

