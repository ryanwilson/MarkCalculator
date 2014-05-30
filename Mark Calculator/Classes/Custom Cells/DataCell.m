//
//  DataCell.m
//  Mark Calculator
//
//  Created by Ryan Wilson on 2012-03-02.
//  Copyright (c) 2012 Ryan Wilson. All rights reserved.
//

#import "DataCell.h"
#import "UIColor+MCColors.h"
#import "UIFont+MCFonts.h"

@implementation DataCell

@synthesize mark;
@synthesize weight;
@synthesize group;

#pragma mark - Setting data

-(void) setMarkValue:(MarkValues *) val{
    
    self.weight.text = [NSString stringWithFormat:@"%0.2f", val.weight];
    self.mark.text = [NSString stringWithFormat:@"%0.2f", val.mark / val.outOf * 100];
    self.group.hidden = (val.grouped.count == 0);
}

#pragma mark - Initialization

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code for iPad since we have to use a NIB instead... shucks.
        CGFloat oneThird = 540 / 3; // We want this rounded, yes.
    
        // We don't have to create the group "G" icon, it'll never be used with this method
        
        UILabel *markLabel = [[UILabel alloc] initWithFrame: CGRectMake(oneThird - 45, 11, 90, 21)];
        markLabel.textColor = [UIColor darkColor];
        markLabel.font = [UIFont mcFontWithSize: 17];
        markLabel.backgroundColor = [UIColor clearColor];
        markLabel.textAlignment = UITextAlignmentCenter;
        [self addSubview: markLabel];
        self.mark = markLabel;
        
        UILabel *weightLabel = [[UILabel alloc] initWithFrame: CGRectMake(oneThird * 2 - 45, 11, 90, 21)];
        weightLabel.textColor = [UIColor darkColor];
        weightLabel.font = [UIFont mcFontWithSize: 17];
        weightLabel.backgroundColor = [UIColor clearColor];
        weightLabel.textAlignment = UITextAlignmentCenter;
        [self addSubview: weightLabel];
        self.weight = weightLabel;
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
