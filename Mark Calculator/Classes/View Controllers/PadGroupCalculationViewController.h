//
//  PadGroupCalculationViewController.h
//  Mark Calculator
//
//  Created by Ryan Wilson on 2013-02-08.
//
//

#import "GroupCalculationViewController.h"
#import "NumberKeyboard.h"

@interface PadGroupCalculationViewController : GroupCalculationViewController <CustomKeyboardDelegate>
{
    NumberKeyboard *_numKeyboard;
}
@end
