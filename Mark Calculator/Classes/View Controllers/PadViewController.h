//
//  PadViewController.h
//  Mark Calculator
//
//  Created by Ryan Wilson on 2013-02-07.
//
//

#import "ViewController.h"
#import "NumberKeyboard.h"
#import "PadGroupCalculationViewController.h"

@interface PadViewController : ViewController <CustomKeyboardDelegate>
{
    NumberKeyboard *_numKeyboard;
    PadGroupCalculationViewController *_grVC;
    InfoViewController *_infoVC;
}

@property (weak, nonatomic) IBOutlet UIButton *clearMarksButton;

- (IBAction)clearMarksHit:(id)sender;
- (IBAction)addGroupHit:(id)sender;


@end
