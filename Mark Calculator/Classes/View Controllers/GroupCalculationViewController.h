//
//  GroupCalculationViewController.h
//  Mark Calculator
//
//  Created by Ryan Wilson on 12-04-21.
//  Copyright (c) 2012 After Hours Interactive. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonCalcViewController.h"

@class GroupCalculationViewController;

@protocol GroupCalculationViewControllerDelegate <NSObject>

-(void) groupCalcVCHitCancel:(GroupCalculationViewController *)controller;
-(void) groupCalcVC:(GroupCalculationViewController *)controller didSaveWithData:(NSMutableArray *)d;

@end

@interface GroupCalculationViewController : CommonCalcViewController
{
    double _individualWeight;
    double _totalWeightOfGroup;
}

@property (weak, nonatomic) IBOutlet UILabel *enteredMarksLabel;
@property (weak, nonatomic) IBOutlet UILabel *individualWeightLabel;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;

@property (nonatomic, readwrite) double totalWeightOfGroup;

@property (nonatomic, weak) id <GroupCalculationViewControllerDelegate> delegate;


- (IBAction)actionCancelButtonHit:(id)sender;
- (IBAction)actionSaveButtonHit:(id)sender;

// Dealing with the total weight
- (void) textFieldChanged:(UITextField *) textField;
- (void) textFieldDidEndEditing:(UITextField *) textField;
- (void) totalWeightUpdatedWithValue:(double) val;

@end
