//
//  ViewController.m
//  Mark Calculator
//
//  Created by Ryan Wilson on 2012-03-02.
//  Copyright (c) 2012 Ryan Wilson. All rights reserved.
//

#import "ViewController.h"
#import "Calculator.h"
#import "ResultsViewController.h"
#import "UIColor+MCColors.h"

@interface ViewController ()

@end

@implementation ViewController

#pragma mark - Segue

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"info"]){
        InfoViewController *inf = [segue destinationViewController];
        [inf setDelegate:self];
    }
    else if ([segue.identifier isEqualToString:@"group"]){
        GroupCalculationViewController *grVC = [segue destinationViewController];
        [grVC setDelegate:self];
        [grVC setCurrentWeight: _currentWeight];

        if (_markToEdit){
            grVC.data = _markToEdit.grouped;
            grVC.totalWeightOfGroup = _markToEdit.weight;
            _markToEdit = nil;
        }
    }
    else if ([segue.identifier isEqualToString:@"results"]){
        ResultsViewController *rtVC = [segue destinationViewController];
        rtVC.data = _resultsData.mutableCopy;
        rtVC.delegate = self;
        _resultsData = nil;
    }
}

#pragma mark - GroupCalculation VC Delegate

-(void) groupCalcVC:(GroupCalculationViewController *)controller didSaveWithData:(NSMutableArray *)d{

    // Save all that data, bro
    double average = 0;
    double totalWeight = 0;

    for (MarkValues *item in d){
        average += item.mark;
        totalWeight += item.weight;
    }
    
    average = average / d.count;
    
    MarkValues *newMark = [[MarkValues alloc] initWithMark: average
                                                     outOf: 100
                                                 andWeight: totalWeight];
    newMark.grouped = d;
    
    //  Update info for the other labels
    _currentWeight += totalWeight;
    _markTotal += average * totalWeight;
    
    [self.data addObject: newMark];
    [self.table reloadData];
    
    [self updateLabels];
    [self dismissViewControllerAnimated: YES
                             completion: nil];
}

-(void) groupCalcVCHitCancel:(GroupCalculationViewController *)controller{
    [self dismissViewControllerAnimated: YES
                             completion: nil];
}

#pragma mark - Results VC Delegate

-(void) resultsVCDidClose:(ResultsViewController *)controller{
    [self dismissViewControllerAnimated: YES
                             completion: ^{
                                 [self promptToEraseData];
                             }];
}

#pragma mark - Info View Controller Delegate

-(void) infoViewControllerHitEmail:(InfoViewController *)controller{
    [self dismissViewControllerAnimated: YES
                             completion: ^(void){
                                 [self launchMail];
                             }];
}

-(void) launchMail {
    MFMailComposeViewController* mailVC = [[MFMailComposeViewController alloc] init];
    mailVC.mailComposeDelegate = self;
    [mailVC setSubject:@"Inquiry from Mark Calculator App"];
//    [mailVC setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
    [mailVC setToRecipients:@[@"ryanwils+markcalc@gmail.com"]];
    if (mailVC)
        [self presentModalViewController:mailVC animated:YES];
}

#pragma mark - Mail Compose View Controller Delegate

-(void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error{
    
    [self dismissViewControllerAnimated: YES
                             completion: nil];
}

#pragma mark - Table Stuff

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MarkValues *item = [self.data objectAtIndex: indexPath.row];
    
    // Check to see if it's a group or not
    if (item.grouped.count != 0){
        // SET UP A GROUPED VC HERE!
        _markToEdit = item;
        [self performSegueWithIdentifier:@"group"
                                  sender: nil];
    }
    else {
        // Set up the UI
        self.markField.text = [NSString stringWithFormat:@"%g", item.mark];
        self.weightField.text = [NSString stringWithFormat:@"%g", item.weight];
        self.markDenominator.text = (item.outOf == 100) ? @"" : [NSString stringWithFormat: @"%g", item.outOf];
        
        [self.markField becomeFirstResponder];
    }
    
    //  Remove that from the table, and reload table data, set current editing field
    _currentWeight -= item.weight;
    _markTotal -= (item.mark / item.outOf * 100 * item.weight);
    [self.data removeObjectAtIndex: indexPath.row];
    [self.table reloadData];

    [self updateLabels];
}


-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete){
        /*  Get the weight, to remove it from the current weight */
        MarkValues *item = [self.data objectAtIndex:indexPath.row];

        _currentWeight -= item.weight;
        _markTotal -= (item.mark / item.outOf * 100 * item.weight);
        
        /*  And remove, and reload it */
        [self.data removeObjectAtIndex:indexPath.row];
        [self.table reloadData];
        
        [self updateLabels];
    }
}


#pragma mark - Buttons and Actions

- (IBAction)actionFinishedButtonHit:(id)sender {
    [self actionDismiss:self];
    
    _resultsData = [[Calculator sharedCalc] possibleGradesWithMarks: _data];
    
    if (IS_IPAD){
        ResultsViewController *rtVC = [[ResultsViewController alloc] initWithNibName: @"ResultsVC"
                                                                               bundle: nil];

        rtVC.data = _resultsData.mutableCopy;

        rtVC.modalPresentationStyle = UIModalPresentationFormSheet;
        rtVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;

        rtVC.delegate = self;
        _resultsData = nil;
        
        [self presentViewController: rtVC
                           animated: YES
                         completion: nil];
    }
    else {
        [self performSegueWithIdentifier:@"results"
                                  sender:nil];
    }
}


- (IBAction)actionAddToListHit:(id)sender {
    
    //put into array
	//Check to see if the weight is over 100
	double tempMark = self.markField.text.doubleValue;
	double tempWeight = self.weightField.text.doubleValue;
    
    if ([self.markDenominator.text length] != 0){
        /*  Means a denominator was entered, change the tempMark to a percent*/
        double denom = self.markDenominator.text.floatValue;
        tempMark = tempMark / denom * 100;
    }
    
    // Number validation time, check weights and marks
    if (tempWeight < 1){
        [self alertWithTitle: @"Oops!"
                  andMessage: @"Sorry, please enter a valid weight (above 1, below 100)."];
		return;
	}
    
    _currentWeight += tempWeight;
    
    // Otherwise if it's too much
	if ( _currentWeight>= 100){
        [self alertWithTitle: @"Oops!"
                  andMessage: @"Sorry, the total weight is equal to or over 100%%, please try a different weight!"];
        _currentWeight -= tempWeight;
		return;
	}
	else if (tempMark < 0 || tempMark > 150){
        [self alertWithTitle:@"Oops!"
                  andMessage: @"Sorry, please enter a valid mark (above 0%%, below 150%%)."];
        _currentWeight-= tempWeight;
		return;
	}
    
    _markTotal += tempMark * tempWeight;

    // Create the object and add it
    MarkValues *item = [[MarkValues alloc] initWithMark: self.markField.text.doubleValue
                                                  outOf: self.markDenominator.text.doubleValue
                                              andWeight: tempWeight];
    [self.data addObject:item];
    [self.table reloadData];
    
    [self clearInputsAndNext];
}

#pragma mark - Erasing Data

-(void) eraseAllDataInList {
    _currentWeight = 0;
    [super eraseAllDataInList];
}

#pragma mark - Interface Updates and Controls

-(void) updateLabels{
    
    self.currentMarks.text = [NSString stringWithFormat:@"%d", self.data.count];
    
    if (self.data.count) {
        self.finishedButton.enabled = YES;
        self.finishedButton.alpha = 1.0f;
        self.currentGrade.text = [NSString stringWithFormat:@"%0.1f",(_markTotal / _currentWeight)];
    }
    else {
        self.finishedButton.enabled = NO;
        self.finishedButton.alpha = 0.4f;
        self.currentGrade.text = [NSString stringWithFormat:@"???"];
    }
}

-(void) clearInputsAndNext{
    [super clearInputsAndNext];
    
    // Also clear the weight field
    self.weightField.text = @"";
}

#pragma mark - View Controller

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    _currentWeight = 0;
}

@end
