//
//  TSUChartView.h
//  YJStock
//
//  Created by Wang Pei on 12-5-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TSUChartView : UIView {
    NSMutableArray *pointsArray;
    double K_;
}
- (id)initWithFrame:(CGRect)frame points:(NSArray *)points;
- (void)updateWithPoints:(NSArray *)points;
- (void)setK:(double)k;
@end
