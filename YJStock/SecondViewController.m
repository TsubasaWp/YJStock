//
//  SecondViewController.m
//  YJStock
//
//  Created by Wang Pei on 12-5-20.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "SecondViewController.h"
#import "Algorithm.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Pricing", @"Pricing");
        self.tabBarItem.image = [UIImage imageNamed:@"second"];
    }
    return self;
}
							
- (void)viewDidLoad
{
    [seg1 release];
    [seg2 release];
    [tx1 release];
    [tx2 release];
    [tx3 release];
    [tx4 release];
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}


- (IBAction)submit:(id)sender {
    //  time begin
    float startTime = clock();
    
    //  generate  random points
    double S0 = [tx1.text doubleValue];
    double R = [tx2.text doubleValue]/100;
    double T = [tx3.text doubleValue];
    double K = [tx4.text doubleValue];
    double segma = (double)slider.value/100;
    
    double res;
    switch ( seg1.selectedSegmentIndex ) {
        case 0: // Asia
            switch (seg2.selectedSegmentIndex) {
                case 0:  // call
                   res = A_Call(S0, R , T, segma, K);
                    break;
                case 1:  // put
                    res = A_Put(S0, R , T, segma, K);
                    break;
                default:
                    break;
            }
            break;
        case 1:  // European
            switch (seg2.selectedSegmentIndex) {
                case 0:  // call
                    res = E_Call(S0, R , T, segma, K);
                    break;
                case 1:  // put
                    res = E_Put(S0, R , T, segma, K);
                    break;
                default:
                    break;
            }
            break;
        case 2:  // American
            switch (seg2.selectedSegmentIndex) {
                case 0:  // call
                    //res = Amercian_Put_MSR(S0, R , T, segma, K);
                    res = Amercian_Put_MSR(S0, R , T, segma, K);
                    break;
                case 1:  // put
                    res = Amercian_Put_MSR(S0, R , T, segma, K);
                    break;
                default:
                    break;
            }
            break;

        default:
            break;
    }
    resault.text = [NSString stringWithFormat:@"%lf", res];
    //  time end
    labelTime.text = [NSString  stringWithFormat:@"%f  ms", (clock() - startTime)/1000 ];  
    
}


- (IBAction)sliderValueChanged {
    sliderLabel.text = [NSString stringWithFormat:@"%d",(int)slider.value ];
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
