//
//  AppDelegate.m
//  Mark Calculator
//
//  Created by Ryan Wilson on 2012-03-02.
//  Copyright (c) 2012 Ryan Wilson. All rights reserved.
//

#import "AppDelegate.h"

#define kNumberOfLaunchesKey @"com.ryanwilson.numberOfLaunches"

@implementation AppDelegate

@synthesize window = _window;

#pragma mark - Alert view

-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex != alertView.cancelButtonIndex){
        NSString *appid = [NSString stringWithFormat:@"434291749"];
        NSString* url = [NSString stringWithFormat:  @"http://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?id=%@&pageNumber=0&sortOrdering=1&type=Purple+Software&mt=8", appid];
        [[UIApplication sharedApplication] openURL: [NSURL URLWithString: url ]];
    }
}

#pragma mark - Regular App Delegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{    
    // Check to see how many times they've launched the app
    NSUInteger launches = [[NSUserDefaults standardUserDefaults] integerForKey: kNumberOfLaunchesKey];
    launches++;

    if (launches == 8){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Rate Me"
                                                        message: @"Would you like to rate this application in the App Store? If you found it helpful, please do!"
                                                       delegate: self
                                              cancelButtonTitle: @"No, Thanks"
                                              otherButtonTitles: @"Rate it!", nil];
        [alert show];
    }
    
    // Resave the launches
    [[NSUserDefaults standardUserDefaults] setInteger: launches
                                               forKey: kNumberOfLaunchesKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
