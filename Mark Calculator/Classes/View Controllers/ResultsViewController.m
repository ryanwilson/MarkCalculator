//
//  ResultsViewController.m
//  Mark Calculator
//
//  Created by Ryan Wilson on 2013-01-24.
//
//

#import "ResultsViewController.h"
#import "ResultantMark.h"
#import "CellBackgroundView.h"
#import "ResultsCell.h"
#import <QuartzCore/QuartzCore.h>
#import "UIColor+MCColors.h"

#define kTableDataAll         1
#define kTableDataEvery10     10
#define kTableDataEvery5      5
#define kTableDataEvenNumbers 2

@interface ResultsViewController ()

@end

@implementation ResultsViewController

#pragma mark - Actions

- (IBAction)doneButtonHit:(id)sender {
    [self.delegate resultsVCDidClose: self];
}

- (IBAction)toggleTableDataHit:(id)sender {
    
    if (_tableDataType == kTableDataAll)
    {
        _tableDataType = kTableDataEvery10;
        [self.toggleTableDataButton setTitle:@"Showing: Every 10"
                                    forState:UIControlStateNormal];
    }
    else if (_tableDataType == kTableDataEvery10)
    {
        _tableDataType = kTableDataEvery5;
        [self.toggleTableDataButton setTitle:@"Showing: Every 5"
                                    forState:UIControlStateNormal];   
    }
    else if (_tableDataType == kTableDataEvery5)
    {
        _tableDataType = kTableDataEvenNumbers;
        [self.toggleTableDataButton setTitle:@"Showing: Every Other"
                                    forState:UIControlStateNormal];
    }
    else if (_tableDataType == kTableDataEvenNumbers)
    {
        _tableDataType = kTableDataAll;
        [self.toggleTableDataButton setTitle:@"Showing: All"
                                    forState:UIControlStateNormal];
    }

    [self.table reloadData];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if (_tableDataType == kTableDataAll)
        return self.data.count;
    else
        return (self.data.count / _tableDataType) + 1;
}

-(CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"results";
    ResultsCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil){
        // Will be nil for iPad, initialize
        cell = [[ResultsCell alloc] initWithStyle: UITableViewCellStyleDefault
                                  reuseIdentifier: @"results"];
    }
    
    // Configure the cell... _tableDataType is the right constant to allow us to get the right index
    NSUInteger index = indexPath.row * _tableDataType;
    DLog(@"New index = %d", index);
    
    ResultantMark *result = [self.data objectAtIndex: index];
    [cell setResults: result];

    cell.backgroundView = [[CellBackgroundView alloc] initWithFrame: cell.frame];
    cell.selectedBackgroundView = [[CellBackgroundView alloc] initWithFrame: cell.frame];
    
    return cell;
}

-(void) scrollViewDidScroll:(UIScrollView *)scrollView{
    if (_hasScrolled == NO && !IS_IPAD)
    {
        // Animate that shiz
        self.toggleTableDataButton.hidden = NO;
        [UIView animateWithDuration: 0.25f
                         animations: ^(void){
                             self.instructionsTextView.alpha = 0;
                         }
                         completion:^(BOOL finished){
                             
                             // Once that's done, animate it again to be visible!
                             self.instructionsTextView.hidden = YES;
                             [UIView animateWithDuration: 0.25f
                                              animations:^(void) {
                                                  self.toggleTableDataButton.alpha = 1;
                                              }];
                             
                         }];
    }
}


#pragma mark - View Controller Methods

- (void)viewDidLoad
{
    [super viewDidLoad];

	// Do any additional setup after loading the view.
    _tableDataType = kTableDataAll;
    _hasScrolled = NO;
    
    self.doneButton.layer.borderColor = [UIColor darkColor].CGColor;
    self.doneButton.layer.borderWidth = 1;
    
    if (!IS_IPAD){
        self.toggleTableDataButton.hidden = YES;
        self.toggleTableDataButton.alpha = 0;         // Alpha is 0 because we'll have to animate it active after
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
