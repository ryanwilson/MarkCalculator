//
//  CellBackgroundView.m
//  Mark Calculator
//
//  Created by Ryan Wilson on 2013-01-24.
//
//

#import "CellBackgroundView.h"
#import "UIColor+MCColors.h"

@implementation CellBackgroundView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor( context , [UIColor lightColor].CGColor );
    CGRect alteredRect = rect;
    alteredRect.origin.x += 10;
    alteredRect.size.width -= 20;
    
    CGContextFillRect( context , alteredRect );
    
    CGPoint startPoint = CGPointMake( alteredRect.origin.x + 0.5,  alteredRect.origin.y + alteredRect.size.height - 0.5 );
    CGPoint endPoint = CGPointMake( alteredRect.origin.x + alteredRect.size.width - 0.5, alteredRect.origin.y + alteredRect.size.height - 0.5 );
    CGContextSetLineCap( context, kCGLineCapSquare );
    CGContextSetStrokeColorWithColor( context, [UIColor darkColor].CGColor );
    CGContextSetLineWidth( context, 1.0 );
    CGContextMoveToPoint( context, startPoint.x, startPoint.y);
    CGContextAddLineToPoint(context, endPoint.x, endPoint.y );
    CGContextStrokePath(context);
}


@end
