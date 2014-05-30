//
//  MarkValues.h
//  Mark Calculator
//
//  Created by Ryan Wilson on 12-04-21.
//  Copyright (c) 2012 After Hours Interactive. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MarkValues : NSObject
{
    float _mark;
    float _outOf;
    float _weight;
    NSMutableArray *_grouped;
}
@property (nonatomic, readwrite) float mark;
@property (nonatomic, readwrite) float outOf;
@property (nonatomic, readwrite) float weight;
@property (nonatomic, strong) NSMutableArray *grouped;

-(id) initWithMark:(float)m outOf:(float) o andWeight:(float)w;


@end
