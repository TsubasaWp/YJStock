//
//  SecondViewController.h
//  YJStock
//
//  Created by Wang Pei on 12-5-20.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SecondViewController : UIViewController {
    IBOutlet UITextField *tx1;
    IBOutlet UITextField *tx2;
    IBOutlet UITextField *tx3;
    IBOutlet UITextField *tx4;
    IBOutlet UISegmentedControl *seg1;
    IBOutlet UISegmentedControl *seg2;
    IBOutlet UISlider *slider;
    IBOutlet UILabel *sliderLabel;
    IBOutlet UILabel *resault;
    IBOutlet UILabel *labelTime;
}
- (IBAction)submit:(id)sender;
- (IBAction)sliderValueChanged;
@end
