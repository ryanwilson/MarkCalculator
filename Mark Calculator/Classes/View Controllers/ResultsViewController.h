//
//  ResultsViewController.h
//  Mark Calculator
//
//  Created by Ryan Wilson on 2013-01-24.
//
//

#import <UIKit/UIKit.h>

@class ResultsViewController;

@protocol ResultsVCDelegate <NSObject>

-(void) resultsVCDidClose:(ResultsViewController *)controller;

@end


@interface ResultsViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
{
    NSMutableArray *_data;
    NSUInteger _tableDataType;
    BOOL _hasScrolled;
}

@property (nonatomic, strong) NSMutableArray *data;
@property (nonatomic, weak) IBOutlet UITableView *table;
@property (weak, nonatomic) IBOutlet UIButton *doneButton;
@property (weak, nonatomic) IBOutlet UIButton *toggleTableDataButton;

@property (weak, nonatomic) IBOutlet UITextView *instructionsTextView;

@property (nonatomic, weak) id <ResultsVCDelegate> delegate;

- (IBAction)doneButtonHit:(id)sender;
- (IBAction)toggleTableDataHit:(id)sender;

@end
