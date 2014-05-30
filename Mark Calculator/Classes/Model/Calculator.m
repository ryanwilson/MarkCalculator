//
//  Calculator.m
//  Mark Calculator
//
//  Created by Ryan Wilson on 2013-01-24.
//
//

#import "Calculator.h"
#import "ResultantMark.h"
#import "MarkValues.h"

@implementation Calculator

+ (id)sharedCalc
{
    static dispatch_once_t pred;
    static Calculator *instance = nil;
    
    dispatch_once(&pred, ^{ instance = [[self alloc] init]; });
    return instance;
}

-(NSArray *) possibleGradesWithMarks:(NSArray *) marks{
    
    NSMutableArray *grades = @[].mutableCopy;
    
    // First calculate existing grade with all marks
    float total = 0;
    float weightLeft = 100;
    for (MarkValues *m in marks){
        total += m.mark / m.outOf * m.weight;
        weightLeft -= m.weight;
    }
    
    // Then, we go from 0 to 100, use that calculation, and add to our returning array!
    for (int i = 0; i <= 100; ++i){
        float result = total + ((weightLeft * i) / 100 );
        result = MIN( result, 100 );
        
        ResultantMark *resMark = [[ResultantMark alloc] initWithExamMark: i
                                                            andFinalMark: result];
        [grades addObject: resMark];
    }
    
    return grades;
}


@end
