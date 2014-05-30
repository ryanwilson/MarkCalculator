//
//  DataCell.h
//  Mark Calculator
//
//  Created by Ryan Wilson on 2012-03-02.
//  Copyright (c) 2012 Ryan Wilson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MarkValues.h"

@interface DataCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *mark;
@property (nonatomic, weak) IBOutlet UILabel *weight;
@property (nonatomic, weak) IBOutlet UILabel *group;

-(void) setMarkValue:(MarkValues *) val;

@end
