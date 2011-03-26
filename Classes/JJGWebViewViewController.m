//
//  JJGWebViewViewController.m
//  JJGWebView
//
//  Created by Jeff Geerling on 3/10/11.
//  Copyright 2011 Archdiocese of Saint Louis. All rights reserved.
//

#import "JJGWebViewViewController.h"
#import "JJGWebView.h"

@implementation JJGWebViewViewController



/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	sampleArray = [[NSArray alloc] initWithObjects:@"Midwestern Mac, LLC",@"Life is a Prayer",@"Apple",@"xkcd",nil];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
// We allow rotation.
return YES;
}


#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return 4;
}

// Customize section headers.
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	return @"Tap a website to open:";
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	static NSString *CellIdentifier = @"Cell";
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil) {
		cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
	}
	
	cell.textLabel.text = [sampleArray objectAtIndex:indexPath.row];
	
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	// Deselect row.
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	
	// Open link in Safari.
	// [[UIApplication sharedApplication] openURL:[NSURL URLWithString:storyLink]];
	
	// Open link in JJGWebView.
	JJGWebView *jjgWebView = [[JJGWebView alloc] initWithNibName:@"JJGWebView" bundle:nil];
	jjgWebView.title = @"Loading...";
	
	switch (indexPath.row) {
		case 0:
			jjgWebView.webViewURL = [NSURL URLWithString:@"http://www.midwesternmac.com/"];
			break;
		case 1:
			jjgWebView.webViewURL = [NSURL URLWithString:@"http://www.lifeisaprayer.com/"];
			break;
		case 2:
			jjgWebView.webViewURL = [NSURL URLWithString:@"http://www.apple.com/"];
			break;
		case 3:
			jjgWebView.webViewURL = [NSURL URLWithString:@"http://xkcd.com/"];
			break;
		default:
			jjgWebView.webViewURL = [NSURL URLWithString:@"http://www.midwesternmac.com/"];
			break;
	}
	
	// Push to the web view.
	[self.navigationController pushViewController:jjgWebView animated:YES];
	[jjgWebView release];
}


#pragma mark Memory cleanup

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}

@end
