//
//  ResultantMark.h
//  Mark Calculator
//
//  Created by Ryan Wilson on 2013-01-24.
//
//

#import <Foundation/Foundation.h>

@interface ResultantMark : NSObject
{
    NSUInteger _examMark;
    float _finalMark;
}

@property (nonatomic, readwrite) NSUInteger examMark;
@property (nonatomic, readwrite) float finalMark;

-(id) initWithExamMark:(NSUInteger) exam andFinalMark:(float) final;

// Easier getters for the string so it deals with formatting internally
-(NSString *) examString;
-(NSString *) finalString;

@end
