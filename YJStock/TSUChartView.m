//
//  TSUChartView.m
//  YJStock
//
//  Created by Wang Pei on 12-5-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "TSUChartView.h"

@implementation TSUChartView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        pointsArray = [[NSMutableArray alloc] init];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame points:(NSArray *)points {
    if ( self = [self initWithFrame:frame] ) {
        pointsArray = [[NSMutableArray alloc] initWithArray:points];
    }
    return self;
}

- (void)dealloc {
    [pointsArray release];
    [super dealloc];
}

- (void)setK:(double)k {
    K_ = k;
}
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    int startX = 20; // 起始横坐标
    int startY = 20; // 起始纵坐标
    if ( [pointsArray count] > 0 ) {
        
        //  count points
        double max = 0, min = 0;
        for ( NSNumber* num in pointsArray ) {
            if ( [num doubleValue] > max ) max = [num doubleValue];
            if ( [num doubleValue] < min ) min = [num doubleValue];
        }
        double stepW = ( double )( self.frame.size.width-20 ) / [pointsArray count];  //  padding 10
        double stepH =  ( max == min ) ? self.frame.size.height-40  : ( double )( self.frame.size.height-20 ) / (max - min );
        
        //  代入K值
        if ( K_ != -1 ) {
    //        stepH = ( max == min ) ? 1 : 11/(max - min );
        }
        
        //  draw
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextClearRect ( context, CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) );
        CGContextTranslateCTM(context, 0.0, self.frame.size.height);
        CGContextScaleCTM(context, 1.0, -1.0);
        CGContextBeginPath(context);
        CGContextSetRGBStrokeColor(context, 255.0/255, 255.0/255, 255.0/255, 1);
        CGContextSetLineWidth(context, 2);
        
        //  step one
        double p = [[pointsArray objectAtIndex:0] doubleValue] - min;
        CGContextMoveToPoint(context, startX, startY + stepH * p);
        // step two --- step m
        for ( int i = 1; i < [pointsArray count]; i++ ) {
            double p = [[pointsArray objectAtIndex:i] doubleValue] - min;
            CGContextAddLineToPoint(context, startX + stepW * i, startY + stepH * p);
         }
        CGContextStrokePath(context);
    }
}

- (void)updateWithPoints:(NSArray *)points {
    K_ = -1;
    [pointsArray removeAllObjects];
    [pointsArray addObjectsFromArray:points];
    [self setNeedsDisplay];
}
@end
