//
//  CommonCalcViewController.m
//  Mark Calculator
//
//  Created by Ryan Wilson on 2013-01-24.
//
//

#import "CommonCalcViewController.h"
#import "DataCell.h"
#import "MarkValues.h"
#import <QuartzCore/QuartzCore.h>
#import "UIColor+MCColors.h"
#import "CellBackgroundView.h"
#import "UIFont+MCFonts.h"

@interface CommonCalcViewController ()

@end

@implementation CommonCalcViewController


#pragma mark - TableView Stuff

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}

-(UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (IS_IPAD){
        UIView *container = [[UIView alloc] initWithFrame: CGRectMake( 0, 0, CGRectGetWidth( self.view.frame ), 30)];
        container.backgroundColor = [UIColor darkColor];
        
        CGFloat oneThird = self.view.frame.size.width / 3;
        
        UILabel *mark = [[UILabel alloc] initWithFrame: CGRectMake(oneThird - 100, 0, 200, 30)];
        mark.backgroundColor = [UIColor darkColor];
        mark.textColor = [UIColor whiteColor];
        mark.font = [UIFont mcFontWithSize: 14];
        mark.textAlignment = UITextAlignmentCenter;
        mark.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
        mark.text = NSLocalizedString(@"Mark", nil);
        [container addSubview: mark];
        
        UILabel *weight = [[UILabel alloc] initWithFrame: CGRectMake(oneThird * 2 - 100, 0, 200, 30)];
        weight.backgroundColor = [UIColor darkColor];
        weight.textColor = [UIColor whiteColor];
        weight.font = [UIFont mcFontWithSize: 14];
        weight.textAlignment = UITextAlignmentCenter;
        weight.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
        weight.text = NSLocalizedString(@"Weight", nil);
        [container addSubview: weight];
        
        return container;
    }
    else {
        // Don't have to worry about rotations or anything, so easy way out is one label with spaces. Change for localizations though
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame),  30)];
        title.font = [UIFont mcFontWithSize: 14];
        title.backgroundColor = [UIColor clearColor];
        title.textColor = [UIColor whiteColor];
        title.textAlignment = UITextAlignmentCenter;
        title.text = @"  Mark                    Weight";
        return title;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.data.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Create the cell and set it up
    DataCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (cell == nil){
        cell = [[DataCell alloc] initWithStyle: UITableViewCellStyleDefault
                               reuseIdentifier: @"cell"];
    }
    
    // Get the proper information
    MarkValues *item = [self.data objectAtIndex:indexPath.row];
    [cell setMarkValue: item];
    
    cell.backgroundView = [[CellBackgroundView alloc] initWithFrame: cell.frame];
    cell.selectedBackgroundView = [[CellBackgroundView alloc] initWithFrame: cell.frame];
    
    return cell;
}

#pragma mark - Shake gestures

-(void) motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event{
    
    if (motion == UIEventSubtypeMotionShake && self.data.count){
        [self actionDismiss:nil];
        [self promptToEraseData];
    }
}

#pragma mark - Alert view delegate

-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    // If okay is hit, clear that list
    if (buttonIndex == 1)
        [self eraseAllDataInList];
}

-(void) promptToEraseData{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Attention!"
                                                    message:@"Would you like to clear your current list?"
                                                   delegate:self
                                          cancelButtonTitle:@"No"
                                          otherButtonTitles:@"Yes", nil];
    [alert show];
}
#pragma mark - Actions from Buttons

- (IBAction)actionDismiss:(id)sender {
    [self.view endEditing: YES];
}

- (IBAction) actionAddToListHit:(id)sender{
    // Each one handles it differently
    NSAssert( NO, @"Must override. Don't be a rookie...'");
}


-(void) alertWithTitle:(NSString *) title andMessage:(NSString *) message{
    
    // Dismiss keyboard first
    [self actionDismiss:self];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle: title
                                                    message: message
                                                   delegate: nil
                                          cancelButtonTitle: @"Okay"
                                          otherButtonTitles: nil];
    [alert show];
}


-(void) eraseAllDataInList{

    _markTotal = 0;

    [self.data removeAllObjects];
    [self.table reloadData];
    [self clearInputsAndNext];
}

#pragma mark - Navigation and UI

-(void) clearInputsAndNext{
    
    self.markField.text = @"";
    self.markDenominator.text = @"";
	[self.markField becomeFirstResponder];
    
    [self updateLabels];
}

-(void) updateLabels{
    
    // We MUST Override this considering the labels are different, so assert that this crashes
    NSAssert( NO, @"Override this. Common. You know better.");
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
    
    if (!self.data)
        self.data = [[NSMutableArray alloc] init];
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone){
        [self.markField setKeyboardType:UIKeyboardTypeDecimalPad];
        [self.weightField setKeyboardType:UIKeyboardTypeDecimalPad];
        [self.markDenominator setKeyboardType:UIKeyboardTypeDecimalPad];
    }
    else {
        [self.markField becomeFirstResponder];
    }
    
    _markTotal = 0;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL) canBecomeFirstResponder{
    return YES;
}

@end
