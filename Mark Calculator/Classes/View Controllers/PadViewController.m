//
//  PadViewController.m
//  Mark Calculator
//
//  Created by Ryan Wilson on 2013-02-07.
//
//

#import "PadViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "UIColor+MCColors.h"
#import "UIView+FindFirstResponder.h"

@interface PadViewController ()

@end

@implementation PadViewController

#pragma mark - Segue

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString: @"info"]){
        // Make sure it's nil
        _infoVC = nil;
        _infoVC = segue.destinationViewController;
        _infoVC.delegate = self;
    }
}

#pragma mark - Actions

- (IBAction)clearMarksHit:(id)sender{
    [self promptToEraseData];
}

- (IBAction)addGroupHit:(id)sender {

    _grVC = nil;
    _grVC = [[PadGroupCalculationViewController alloc] initWithNibName: @"GroupCalcVC"
                                                                                                 bundle: nil];
    [_grVC setDelegate:self];
    [_grVC setCurrentWeight: _currentWeight];
        
    _grVC.modalPresentationStyle = UIModalPresentationFormSheet;
    _grVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    
    [self presentViewController: _grVC
                       animated: YES
                     completion: nil];
}

#pragma mark - Info View Controller Delegate

-(void) infoViewControllerHitEmail:(InfoViewController *)controller{
    [self launchMail];
}

#pragma mark - Keyboard Delegate

-(id) customKeyboardWantsFirstResponder{
    return [self.view findFirstResponder];
}

#pragma mark - Table View Stuff


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MarkValues *item = [self.data objectAtIndex: indexPath.row];
    
    // Check to see if it's a group or not
    if (item.grouped.count != 0){
        // Show the group stuff and fill it!
        _grVC = nil;
        _grVC = [[PadGroupCalculationViewController alloc] initWithNibName: @"GroupCalcVC"
                                                                                                   bundle: nil];
        
        [_grVC setDelegate:self];
        [_grVC setCurrentWeight: _currentWeight];
        
        _grVC.data = item.grouped;
        _grVC.totalWeightOfGroup = item.weight;

        _grVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        _grVC.modalPresentationStyle = UIModalPresentationFormSheet;
        
        [self presentViewController: _grVC
                           animated: YES
                         completion: nil];
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

#pragma mark - View Controller Methods

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad{
    
    [super viewDidLoad];

    _numKeyboard = [[NumberKeyboard alloc] initWithNibName: @"NumberKeyboard"
                                                    bundle: nil];
    _numKeyboard.delegate = self;
    
    self.markField.inputView = _numKeyboard.view;
    self.markDenominator.inputView = _numKeyboard.view;
    self.weightField.inputView = _numKeyboard.view;
    
    self.clearMarksButton.layer.borderColor = [UIColor darkColor].CGColor;
    self.clearMarksButton.layer.borderWidth = 1.0f;
    
    self.table.backgroundView.hidden = YES;
    self.table.backgroundColor = [UIColor darkColor];
}

- (void)didReceiveMemoryWarning{
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
