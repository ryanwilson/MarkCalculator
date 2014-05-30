//
//  GroupCalculationViewController.m
//  Mark Calculator
//
//  Created by Ryan Wilson on 12-04-21.
//  Copyright (c) 2012 After Hours Interactive. All rights reserved.
//

#import "GroupCalculationViewController.h"
#import "MarkValues.h"
#import "DataCell.h"
#import <QuartzCore/QuartzCore.h>
#import "UIColor+MCColors.h"
#import "CellBackgroundView.h"

#define kKeyTagDecimal  10
#define kKeyTagBack     11

@interface GroupCalculationViewController ()

@end

@implementation GroupCalculationViewController

#pragma mark - TableView Stuff

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Get that proper MarkValue object
    MarkValues *item = [self.data objectAtIndex:indexPath.row];

    self.markField.text = [NSString stringWithFormat:@"%0.2f", item.mark];
    
    //  Remove from table, and change datasource
    [self.data removeObjectAtIndex: indexPath.row];
    
    //  Change weight of all
    _individualWeight = _totalWeightOfGroup / self.data.count;
    for (MarkValues *item in self.data){
        item.weight = _individualWeight;
    }

    [self.table reloadData];

    [self updateLabels];
    [self.markField becomeFirstResponder];
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        [self.data removeObjectAtIndex:indexPath.row];
        
        _individualWeight = _totalWeightOfGroup / self.data.count;
        
        /*  Change weight of all */
        for (MarkValues *item in self.data){
            item.weight = _individualWeight;
        }

        [self.table reloadData];
        [self updateLabels];
    }
}

#pragma mark - AlertView Delegate

// OVERRIDE because we have another option
-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{

    if (buttonIndex == 1)
    {
        if ([[alertView buttonTitleAtIndex: buttonIndex] isEqualToString:@"Leave"])
            [self.delegate groupCalcVCHitCancel:self];
        else
            [self eraseAllDataInList];
    }
}

#pragma mark - Buttons hit

- (IBAction)actionCancelButtonHit:(id)sender {
    if (self.data.count > 0)
    {
        /*  There's still some data there, toss an alert up */
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Warning" 
                                                        message:@"There are still marks that haven't been saved, did you want to leave this screen?" 
                                                       delegate:self 
                                              cancelButtonTitle:@"Cancel" 
                                              otherButtonTitles:@"Leave", nil];
        [alert show];
    }
    else {
        /*  Call delegate to dismiss */
        [self.delegate groupCalcVCHitCancel:self];
    }
}

- (IBAction)actionSaveButtonHit:(id)sender {
    
    if (self.data.count > 0)
        [self.delegate groupCalcVC:self didSaveWithData:self.data];
    else {
        [self alertWithTitle:@"Error"
                  andMessage:@"No data has been saved yet"];
    }
}

- (IBAction)actionAddToListHit:(id)sender{

    //put into array
	double tempMark = [self.markField.text doubleValue];
    
    if ([self.markDenominator.text length] != 0)
    {
        /*  Means a denominator was entered, change the tempMark to a percent*/
        double denom = [self.markDenominator.text floatValue];
        tempMark = tempMark/denom * 100;
    }
    
    if (_totalWeightOfGroup == -1)
    {   
        /*  Hasn't been set yet */
        [self alertWithTitle: @"Oops!"
                  andMessage: @"The total weight is currently invalid. Please enter a proper value."];
		return;
    }
         
    /* Check the mark  */
	else if (tempMark < 0 || tempMark > 150)
	{
        [self alertWithTitle: @"Oops!"
                  andMessage: @"Sorry, please enter a valid mark (above 0%%, below 150%%"];
		return;
	}
    
    /*  Change weight of all (+1 because we haven't added the current one to the array*/
    _individualWeight = _totalWeightOfGroup / (self.data.count + 1);
    for (MarkValues *item in self.data)
    {
        item.weight = _individualWeight;
    }    
    
    /* Create the MarkValues and add it to the data source*/
    MarkValues *item = [[MarkValues alloc] initWithMark: self.markField.text.floatValue
                                                  outOf: self.markDenominator.text.floatValue
                                              andWeight: _individualWeight];
    [self.data addObject:item];

    [self clearInputsAndNext];
    [self.table reloadData];
}

#pragma mark - Text view Changes

- (void) textFieldChanged:(UITextField *) textField{
    double potentialValue = [self.weightField.text doubleValue];
    
    /*  Check to see if the value is too large */
    if (potentialValue + _currentWeight >= 100)
    {
        _individualWeight = -1;
        textField.backgroundColor = [UIColor redColor];
    }
    else {
        textField.backgroundColor = [UIColor whiteColor];
        [self totalWeightUpdatedWithValue: potentialValue];
    }
}

-(void) textFieldDidEndEditing:(UITextField *) textField{
    double potentialValue = [self.weightField.text doubleValue];
    
    /*  Check to see if the value is too large */
    if (potentialValue + _currentWeight >= 100){
        [self alertWithTitle: @"Error"
                  andMessage: [NSString stringWithFormat:@"Sorry, the value you entered is too large, please enter a weight lower than %0.1f", 100 - _currentWeight]];
        _individualWeight = -1;
    }
    else {
        textField.backgroundColor = [UIColor whiteColor];
        [self totalWeightUpdatedWithValue: potentialValue];
    }
}

#pragma mark - Updating information

- (void) totalWeightUpdatedWithValue:(double) val{
    _totalWeightOfGroup = val;
    
    /*  Change all the existing ones */
    if (self.data.count != 0)
        _individualWeight = _totalWeightOfGroup / self.data.count;
    
    for (MarkValues *item in self.data){
        item.weight = _individualWeight;
    }
    
    [self.table reloadData];
    [self updateLabels];
}

-(void) updateLabels{
    /*  Set the proper labels */
    self.enteredMarksLabel.text = [NSString stringWithFormat:@"%d", self.data.count];
  
    if (_individualWeight == -1 || self.data.count == 0)
        self.individualWeightLabel.text = @"???";
    else
        self.individualWeightLabel.text = [NSString stringWithFormat:@"%0.2f",_individualWeight];
}

-(void) eraseAllDataInList{
    _individualWeight = 0;
    [super eraseAllDataInList];
}

#pragma mark - View Controller Methods

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.weightField addTarget: self
                         action: @selector(textFieldChanged:)
               forControlEvents: UIControlEventEditingChanged];
    [self.weightField addTarget: self
                         action: @selector(textFieldDidEndEditing:)
               forControlEvents: UIControlEventEditingDidEnd];
    
    if (_totalWeightOfGroup <= 0 || _totalWeightOfGroup > (100 - _currentWeight)){
        _individualWeight = 0;
        _totalWeightOfGroup = 0;
    }
    else{
        self.weightField.text = [NSString stringWithFormat: @"%g", _totalWeightOfGroup];
        _individualWeight = _totalWeightOfGroup / self.data.count;
        [self updateLabels];
    }
    
    // Border around the cancel button
    self.cancelButton.layer.borderColor = [UIColor darkColor].CGColor;
    self.cancelButton.layer.borderWidth = 1.0f;
    
    self.table.backgroundColor = [UIColor darkColor];
    self.table.backgroundView.hidden = YES;
}

-(void) viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear: animated];
    
    [self.weightField removeTarget: self
                            action: @selector(textFieldChanged:)
                  forControlEvents: UIControlEventEditingChanged];
    [self.weightField removeTarget: self
                            action: @selector(textFieldDidEndEditing:)
                  forControlEvents: UIControlEventEditingDidEnd];
}

@end
