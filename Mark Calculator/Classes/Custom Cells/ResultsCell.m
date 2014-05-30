//
//  ResultsCell.m
//  Mark Calculator
//
//  Created by Ryan Wilson on 2013-01-24.
//
//

#import "ResultsCell.h"
#import "UIColor+MCColors.h"
#import "UIFont+MCFonts.h"

#define kLabelWidth     82
#define kLabelHeight    22
#define kOffset         20

#define kModdedWidth    500

@implementation ResultsCell

#pragma mark - Actions

-(void) setResults:(ResultantMark *) res{
    self.examMark.text = res.examString;
    self.finalMark.text = res.finalString;
}

#pragma mark - Initialization

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        CGFloat thirdOfWidth = kModdedWidth / 3;
        CGFloat x = (thirdOfWidth) - (kLabelWidth / 2) + kOffset;
        CGFloat y = (self.frame.size.height - kLabelHeight) / 2;
        
        UILabel *examMark = [[UILabel alloc] initWithFrame: CGRectMake( x, y, kLabelWidth, kLabelHeight)];
        examMark.textAlignment = UITextAlignmentCenter;
        examMark.backgroundColor = [UIColor lightColor];
        examMark.font = [UIFont mcFontWithSize: 17];
        examMark.textColor = [UIColor darkColor];
        
        [self addSubview: examMark];
        _examMark = examMark;
        
        x += thirdOfWidth;
        UILabel *finalMark = [[UILabel alloc] initWithFrame: CGRectMake( x, y, kLabelWidth, kLabelHeight)];
        finalMark.textAlignment = UITextAlignmentCenter;
        finalMark.backgroundColor = [UIColor lightColor];
        finalMark.font = [UIFont mcFontWithSize: 17];
        finalMark.textColor = [UIColor darkColor];
        [self addSubview: finalMark];
        _finalMark = finalMark;
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
