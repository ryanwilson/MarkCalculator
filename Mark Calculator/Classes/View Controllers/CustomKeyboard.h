//
//  CustomKeyboard.h
//  Mark Calculator
//
//  Created by Ryan Wilson on 2013-02-07.
//
//

#import <UIKit/UIKit.h>

@class CustomKeyboard;

@protocol CustomKeyboardDelegate <NSObject>

-(id) customKeyboardWantsFirstResponder;

@end


@interface CustomKeyboard : UIViewController

-(BOOL) sendTextToFirstResponder:(NSString *) text;
-(BOOL) sendBackspace;

@property (nonatomic, weak) id <CustomKeyboardDelegate> delegate;

@end
