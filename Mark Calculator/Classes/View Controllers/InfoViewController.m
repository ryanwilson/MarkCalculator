//
//  InfoViewController.m
//  Mark Calculator
//
//  Created by Ryan Wilson on 12-04-20.
//  Copyright (c) 2012 After Hours Interactive. All rights reserved.
//

#import "InfoViewController.h"

@interface InfoViewController ()

@end

@implementation InfoViewController
@synthesize delegate;

#pragma mark - Buttons hit

- (IBAction)websiteButtonHit:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.markcalculator.com"]];
}

- (IBAction)emailButtonHit:(id)sender {
    [delegate infoViewControllerHitEmail:self];
}

- (IBAction)twitterButtonHit:(id)sender {
    BOOL didOpenTwitterApp = [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"twitter:///user?screen_name=ryanwils"]];
    if (!didOpenTwitterApp){
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://twitter.com/#!/ryanwils"]];
    }
}

- (IBAction)rateButtonHit:(id)sender {
    NSString *appid = [NSString stringWithFormat:@"434291749"];
    NSString* url = [NSString stringWithFormat:  @"http://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?id=%@&pageNumber=0&sortOrdering=1&type=Purple+Software&mt=8", appid];
    [[UIApplication sharedApplication] openURL: [NSURL URLWithString: url ]];
}


#pragma mark - View Controller Methods

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


@end
