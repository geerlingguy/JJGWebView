# JJGWebView

![JJGWebView Example on iPhone](https://github.com/geerlingguy/JJGWebView/raw/master/jjgwebview-example-resized.png)

This is an iPhone, iPod Touch, and iPad UIWebView implementation for reuse in
iOS Apps, highlighting methods and design for a usable and intuitive in-app
browser.

## Usage

Look inside `JJGWebViewViewController.m` for implementation details. Basically,
if you're using a Table View inside a Navigation Controller, you can just
pop a JJGWebView on your navigation stack, and the class will take care of the
rest.

    // Import JJGWebView.h (at the top of your class).
    #import "JJGWebView.h"

    // Open a link in JJGWebView.
    JJGWebView *webViewToPush = [[JJGWebView alloc] initWithNibName:@"JJGWebView" bundle:nil];
    webViewToPush.title = @"Title Here";
    webViewToPush.webViewURL = [NSURL URLWithString:@"http://www.example.com/"];
    [self.navigationController pushViewController:jjgWebView animated:YES];

You would normally do this inside a `didSelectRowAtIndexPath:` (in table view)
or `calloutAccessoryTapped:` (in map view) method.

## Issues

Please file bug reports, feature requests, and patches on GitHub:
https://github.com/geerlingguy/JJGWebView/issues

## More Information

More information: http://www.midwesternmac.com/jjgwebview