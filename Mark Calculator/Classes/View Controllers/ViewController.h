//
//  ViewController.h
//  Mark Calculator
//
//  Created by Ryan Wilson on 2012-03-02.
//  Copyright (c) 2012 Ryan Wilson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InfoViewController.h"
#import <MessageUI/MessageUI.h>
#import "GroupCalculationViewController.h"
#import "CommonCalcViewController.h"
#import "MarkValues.h"
#import "ResultsViewController.h"

@interface ViewController : CommonCalcViewController < MFMailComposeViewControllerDelegate, InfoViewControllerDelegate, GroupCalculationViewControllerDelegate, ResultsVCDelegate, UITextFieldDelegate>
{
    int _editingIndex;
    MarkValues *_markToEdit;
    NSArray *_resultsData;
}

// Input Fields
@property (weak, nonatomic) IBOutlet UILabel *currentMarks;
@property (weak, nonatomic) IBOutlet UILabel *currentGrade;
@property (weak, nonatomic) IBOutlet UIButton *finishedButton;

- (IBAction)actionFinishedButtonHit:(id)sender;

-(void) launchMail;

@end