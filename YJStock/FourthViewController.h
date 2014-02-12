//
//  FourthViewController.h
//  YJStock
//
//  Created by Wang Pei on 12-5-24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FourthViewController : UIViewController<UIPickerViewDelegate> {
    NSMutableArray *stocks; // 经过过滤的股票数据
    NSMutableArray *originStocks; // 所有原始数据
    NSMutableArray *matrix;  // 300*300 matrix
    NSMutableArray *randomIndex; // all 5 socks groups
    double maxMiu;
    double minOmega;
    NSArray* bestGroup;
    
    IBOutlet UITextField * tx1;
    IBOutlet UITextField * tx2;
    IBOutlet UITextField * tx3;
    IBOutlet UITextField * tx4;
    IBOutlet UITextField * tx5;
    IBOutlet UITextField * tx6;
    IBOutlet UISlider *slider;
    IBOutlet UILabel *sliderLabel;
    IBOutlet UIView *resaultView;
    IBOutlet UIPickerView *resaultPicker;
    IBOutlet UITextView *textView;
    IBOutlet UILabel *labelTime;
} 

- (IBAction)submit:(id)sender;
- (IBAction)closeResault:(id)sender;
- (IBAction)sliderValueChanged;
@end
