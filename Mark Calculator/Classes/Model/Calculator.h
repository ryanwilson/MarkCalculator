//
//  Calculator.h
//  Mark Calculator
//
//  Created by Ryan Wilson on 2013-01-24.
//
//

#import <Foundation/Foundation.h>

@interface Calculator : NSObject

+(id) sharedCalc;

-(NSArray *) possibleGradesWithMarks:(NSArray *) marks;

@end
