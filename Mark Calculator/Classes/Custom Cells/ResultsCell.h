//
//  ResultsCell.h
//  Mark Calculator
//
//  Created by Ryan Wilson on 2013-01-24.
//
//

#import <UIKit/UIKit.h>
#import "ResultantMark.h"

@interface ResultsCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *examMark;
@property (nonatomic, weak) IBOutlet UILabel *finalMark;

-(void) setResults:(ResultantMark *) res;

@end
