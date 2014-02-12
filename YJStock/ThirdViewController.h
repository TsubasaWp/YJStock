//
//  ThirdViewController.h
//  YJStock
//
//  Created by Wang Pei on 12-5-24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TSUChartView;
@interface ThirdViewController : UIViewController {
    IBOutlet UISegmentedControl *seg1;
    IBOutlet UISegmentedControl *seg2;
    IBOutlet UITextField *tx1;
    IBOutlet UITextField *tx2;
    IBOutlet UITextField *tx3;
    IBOutlet UITextField *tx4;
    IBOutlet UITextField *tx5;
    IBOutlet UIView *resaultView;
    IBOutlet UILabel *res1;
    IBOutlet UILabel *res2;
    IBOutlet UILabel *res3;
    IBOutlet UILabel *res4;
    IBOutlet UILabel *res5;
    IBOutlet UILabel *res6;
    TSUChartView *chartView;
}
- (IBAction)submit:(id)sender;
- (IBAction)back:(id)sender;
@end
