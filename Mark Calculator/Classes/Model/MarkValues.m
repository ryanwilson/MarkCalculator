//
//  MarkValues.m
//  Mark Calculator
//
//  Created by Ryan Wilson on 12-04-21.
//  Copyright (c) 2012 After Hours Interactive. All rights reserved.
//

#import "MarkValues.h"

@implementation MarkValues

@synthesize mark = _mark;
@synthesize outOf = _outOf;
@synthesize weight = _weight;
@synthesize grouped = _grouped;

#pragma mark - Initialization

-(id) initWithMark:(float)m outOf:(float) o andWeight:(float)w{
    self = [super init];
    if (self) {
        
        self.mark = m;
        self.weight = w;

        if ( o == 0)
            self.outOf = 100;
        else
            self.outOf = o;

    }
    return self;
}

-(NSString *) description{
    return [NSString stringWithFormat:@"%f / %f worth %f", _mark, _outOf, _weight];
}


@end
