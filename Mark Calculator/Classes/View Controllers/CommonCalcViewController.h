//
//  CommonCalcViewController.h
//  Mark Calculator
//
//  Created by Ryan Wilson on 2013-01-24.
//
//

#import <UIKit/UIKit.h>

@interface CommonCalcViewController : UIViewController <UITableViewDelegate,UITableViewDataSource, UIAlertViewDelegate>
{
    // Storing marks
    NSMutableArray *_data;
    
    // Other variables needed
    double _markTotal;
    double _currentWeight;

}

// Data
@property (nonatomic, strong) NSMutableArray *data;


// Interface
@property (weak, nonatomic) IBOutlet UITextField *markField;
@property (weak, nonatomic) IBOutlet UITextField *markDenominator;
@property (weak, nonatomic) IBOutlet UITextField *weightField;

@property (nonatomic, strong) IBOutlet UITableView *table;

@property (nonatomic, readwrite) double currentWeight;

// Methods
-(void) updateLabels;
-(void) clearInputsAndNext;
-(void) alertWithTitle:(NSString *) title andMessage:(NSString *) message;
-(void) promptToEraseData;
-(void) eraseAllDataInList;

// Buttons
- (IBAction) actionDismiss:(id)sender;
- (IBAction) actionAddToListHit:(id)sender;

@end
