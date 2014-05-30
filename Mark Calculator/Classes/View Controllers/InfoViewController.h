//
//  InfoViewController.h
//  Mark Calculator
//
//  Created by Ryan Wilson on 12-04-20.
//  Copyright (c) 2012 After Hours Interactive. All rights reserved.
//

#import <UIKit/UIKit.h>

@class InfoViewController;

@protocol InfoViewControllerDelegate <NSObject>

-(void) infoViewControllerHitEmail:(InfoViewController *)controller;

@end


@interface InfoViewController : UIViewController

@property (nonatomic, weak) id <InfoViewControllerDelegate> delegate;

- (IBAction)websiteButtonHit:(id)sender;
- (IBAction)emailButtonHit:(id)sender;
- (IBAction)twitterButtonHit:(id)sender;
- (IBAction)rateButtonHit:(id)sender;

@end
