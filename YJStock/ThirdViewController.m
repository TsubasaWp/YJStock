//
//  ThirdViewController.m
//  YJStock
//
//  Created by Wang Pei on 12-5-24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ThirdViewController.h"
#import "Algorithm.h"
#import "TSUChartView.h"
#include "time.h"

@interface ThirdViewController ()

@end

@implementation ThirdViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Greek", @"Greek");
        self.tabBarItem.image = [UIImage imageNamed:@"second"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    chartView = [[TSUChartView alloc] initWithFrame:CGRectMake(20, 60, 280, 150)];
    [resaultView addSubview:chartView];
}

- (void)viewDidUnload
{
    [seg1 release];
    [seg2 release];
    [tx1 release];
    [tx2 release];
    [tx3 release];
    [tx4 release];
    [tx5 release];
    [res1 release];
    [res2 release];
    [res3 release];
    [res4 release];
    [res5 release];
    [res6 release];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)submit:(id)sender {
    //  time begin
    float startTime = clock();
    
    //  generate  random points
    NSMutableArray *callPoints = [[NSMutableArray alloc] init];
    double S[100], aaa[100];
    srand((unsigned) time(0));
    double S0 = [tx1.text doubleValue];
    double R = [tx2.text doubleValue]/100;
    double T = [tx3.text doubleValue];
    double segma = [tx4.text doubleValue]/100;
    double K = [tx5.text doubleValue];
    for ( int i = 1; i <= 100; i++ ) {
        S[i - 1] = (double)i / 5 + K - 10;
        // aaa[i - 1] = E_Call(S[i - 1], 0.03, 90, 0.3, K);
        // ----------------switch---------------------
        switch ( seg1.selectedSegmentIndex ) {
            case 0: // Asia
                if ( i <= 15 ) {
                    switch (seg2.selectedSegmentIndex) {
                        case 0:  // call
                            aaa[i - 1] = A_Call(S[i - 1], R , T, segma, K);
                            break;
                        case 1:  // put
                            aaa[i - 1] = A_Put(S[i - 1], R , T, segma, K);
                            break;
                        default:
                            break;
                    }
                }
                break;
            case 1:  // European
                switch (seg2.selectedSegmentIndex) {
                    case 0:  // call
                        aaa[i - 1] = E_Call(S[i - 1], R , T, segma, K);
                        break;
                    case 1:  // put
                        aaa[i - 1] = E_Put(S[i - 1], R , T, segma, K);
                        break;
                    default:
                        break;
                }
                break;
            default:
                break;
        }
        // ----------------/switch---------------------
        [callPoints addObject:[NSNumber numberWithDouble:aaa[i-1]]];
    }

    // ----------------Resault---------------------
    switch ( seg1.selectedSegmentIndex ) {
        case 0: // Asia
            switch (seg2.selectedSegmentIndex) {
                case 0:  // call
                    res1.text = [NSString  stringWithFormat:@"%lf", A_Call_Delta(S0, R , T, segma, K)];
                    res2.text = [NSString  stringWithFormat:@"%lf", A_Call_Rho(S0, R , T, segma, K)];
                    res3.text = [NSString  stringWithFormat:@"%lf", A_Call_Gamma(S0, R , T, segma, K)];
                    res4.text = [NSString  stringWithFormat:@"%lf", A_Call_Vega(S0, R , T, segma, K)];
                    res5.text = [NSString  stringWithFormat:@"%lf", A_Call_Theta(S0, R , T, segma, K)];    
                    break;
                case 1:  // put
                    res1.text = [NSString  stringWithFormat:@"%lf", A_Put_Delta(S0, R , T, segma, K)];
                    res2.text = [NSString  stringWithFormat:@"%lf", A_Put_Rho(S0, R , T, segma, K)];
                    res3.text = [NSString  stringWithFormat:@"%lf", A_Call_Gamma(S0, R , T, segma, K)];
                    res4.text = [NSString  stringWithFormat:@"%lf", A_Call_Vega(S0, R , T, segma, K)];
                    res5.text = [NSString  stringWithFormat:@"%lf", A_Put_Theta(S0, R , T, segma, K)];    
                    break;
                default:
                    break;
            }
            break;
        case 1:  // European
            switch (seg2.selectedSegmentIndex) {
                case 0:  // call
                    res1.text = [NSString  stringWithFormat:@"%lf", E_Call_Delta(S0, R , T, segma, K)];
                    res2.text = [NSString  stringWithFormat:@"%lf", E_Call_Rho(S0, R , T, segma, K)];
                    res3.text = [NSString  stringWithFormat:@"%lf", E_Call_Gamma(S0, R , T, segma, K)];
                    res4.text = [NSString  stringWithFormat:@"%lf", E_Call_Vega(S0, R , T, segma, K)];
                    res5.text = [NSString  stringWithFormat:@"%lf", E_Call_Theta(S0, R , T, segma, K)]; 
                    break;
                case 1:  // put
                    res1.text = [NSString  stringWithFormat:@"%lf", E_Put_Delta(S0, R , T, segma, K)];
                    res2.text = [NSString  stringWithFormat:@"%lf", E_Put_Rho(S0, R , T, segma, K)];
                    res3.text = [NSString  stringWithFormat:@"%lf", E_Call_Gamma(S0, R , T, segma, K)];
                    res4.text = [NSString  stringWithFormat:@"%lf", E_Call_Vega(S0, R , T, segma, K)];
                    res5.text = [NSString  stringWithFormat:@"%lf", E_Put_Theta(S0, R , T, segma, K)];  
                    break;
                default:
                    break;
            }
            break;
        default:
            break;
    }
    
    //  time end
    res6.text = [NSString  stringWithFormat:@"%f  ms", (clock() - startTime)/1000 ];  

    //  draw chart view
    [chartView updateWithPoints:callPoints];
    [chartView setK:K];
    //  load resault view
    [self.view addSubview:resaultView];
    [UIView beginAnimations:nil context:nil];
    resaultView.alpha = 0;
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    resaultView.alpha = 1.0;
    [UIView commitAnimations];
}

- (IBAction)back:(id)sender {
    [resaultView removeFromSuperview];
}

#pragma mark UITextField Delegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    self.view.center = CGPointMake(self.view.center.x, self.view.frame.size.height/2);
    if ( textField.frame.origin.y > 200 ) {
        self.view.center = CGPointMake(self.view.center.x, self.view.center.y
                                       - (textField.frame.origin.y - 200));
    }
	return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	[textField resignFirstResponder];
	//	[self removeCityPicker];
    self.view.center = CGPointMake(self.view.center.x, self.view.frame.size.height/2);
	return YES;
}


@end
