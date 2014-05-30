//
//  ResultantMark.m
//  Mark Calculator
//
//  Created by Ryan Wilson on 2013-01-24.
//
//

#import "ResultantMark.h"

@implementation ResultantMark

#pragma mark - Initialization

-(id) initWithExamMark:(NSUInteger) exam andFinalMark:(float) final{
    self = [self init];
    if (self != nil)
    {
        _examMark = exam;
        _finalMark = final;
    }
    return self;
}

#pragma mark - Getters

-(NSString *) examString{
    return [NSString stringWithFormat:@"%d", _examMark];
}

-(NSString *) finalString{
    return [NSString stringWithFormat:@"%1.1f", _finalMark];
}

-(NSString *) description{
    return [NSString stringWithFormat:@"%@ --  %@", self.examString, self.finalString];
}

@end
