//
//  FourthViewController.m
//  YJStock
//
//  Created by Wang Pei on 12-5-24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "FourthViewController.h"
#define DATA_LENGTH 300
#define RESAULT_LENGTH 5
@interface FourthViewController ()
// 判断数字数组是否是无重复的， 如果是， 返回YES
- (BOOL)allDifferent:(NSArray *)array;  
// 产生所有的随机组合
- (void)generateAllStockGroups;
// 产生一条随机股票
- (NSDictionary *)portifolioGroup:(NSArray *)array;
// 过滤符合用户条件的股票
- (void)filtData;
//  计算最优股
- (void)portifolioAll;
//  按照关键字排列
- (NSArray *)selectSocktWithPercent:(double)percent key:(NSString *)key;
@end

@implementation FourthViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Optimal", @"Optimal");
        self.tabBarItem.image = [UIImage imageNamed:@"second"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    originStocks = [[NSMutableArray alloc] init];
    stocks = [[NSMutableArray alloc] init];
    matrix = [[NSMutableArray alloc] init];
    randomIndex = [[NSMutableArray alloc] init ];
    
    // simu datas
//    for ( int i = 0; i < DATA_LENGTH; i++ )  {
//        NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
//        [data setObject:[NSString stringWithFormat:@"%d", i] forKey:@"id"];
//        [data setObject:[NSString stringWithFormat:@"600000"]  forKey:@"code"];
//        [data setObject:[NSString stringWithFormat:@"name%d", i]  forKey:@"name"];
//        [data setObject:[NSString stringWithFormat:@"%f", (float)(rand()%31)/100]  
//                                   forKey:@"return"];
//        [data setObject:[NSString stringWithFormat:@"%f", (float)(rand()%31)/100]  
//                                   forKey:@"volatility"];
//        [data setObject:[NSString stringWithFormat:@"金属业"]  forKey:@"industry"];
//        [originStocks addObject:data];
//        [data release];
//    }
    

    NSError *error;

    // read matrix 
    NSString *path = [[NSBundle mainBundle] pathForResource:@"correlationMatrix.rtf" ofType:nil];
    NSString *filedata = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error];
    NSArray *array = [filedata componentsSeparatedByString:@"\n"];
    for ( int i = 7; i <[array count]; i++ ) {
        //  remove the headers ( 0-6)
        [matrix addObject:[NSNumber numberWithFloat:[[array objectAtIndex:i] floatValue]]];
    }
    
    // read stocks
    path = [[NSBundle mainBundle] pathForResource:@"StockNum.txt" ofType:nil];
    filedata = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error];
    array = [filedata componentsSeparatedByString:@"\n"];
    for ( int i = 0; i < [ array count ]; i++ ) {
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        [dic setObject:[array objectAtIndex:i] forKey:@"StockNum"];
        [originStocks addObject:dic];
        [dic release];
    }
        
    path = [[NSBundle mainBundle] pathForResource:@"Industry.txt" ofType:nil];
    filedata = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error];
    array = [filedata componentsSeparatedByString:@"\n"];
    for ( int i = 0; i <DATA_LENGTH; i++ ) {
        [[originStocks objectAtIndex:i] setObject:[array objectAtIndex:i] forKey:@"Industry"];
    }
    
    path = [[NSBundle mainBundle] pathForResource:@"volatiliy.txt" ofType:nil];
    filedata = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error];
    array = [filedata componentsSeparatedByString:@"\n"];
    for ( int i = 0; i <DATA_LENGTH; i++ ) {
        [[originStocks objectAtIndex:i] setObject:[array objectAtIndex:i] forKey:@"volatiliy"];
    }
    
    path = [[NSBundle mainBundle] pathForResource:@"PE.txt" ofType:nil];
    filedata = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error];
    array = [filedata componentsSeparatedByString:@"\n"];
    for ( int i = 0; i <DATA_LENGTH; i++ ) {
        [[originStocks objectAtIndex:i] setObject:[array objectAtIndex:i] forKey:@"PE"];
    }
    
    path = [[NSBundle mainBundle] pathForResource:@"PB.txt" ofType:nil];
    filedata = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error];
    array = [filedata componentsSeparatedByString:@"\n"];
    for ( int i = 0; i <DATA_LENGTH; i++ ) {
        [[originStocks objectAtIndex:i] setObject:[array objectAtIndex:i] forKey:@"PB"];
    }
    
    path = [[NSBundle mainBundle] pathForResource:@"ROE.txt" ofType:nil];
    filedata = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error];
    array = [filedata componentsSeparatedByString:@"\n"];
    for ( int i = 0; i <DATA_LENGTH; i++ ) {
        [[originStocks objectAtIndex:i] setObject:[array objectAtIndex:i] forKey:@"ROE"];
    }
    
    path = [[NSBundle mainBundle] pathForResource:@"Miu.txt" ofType:nil];
    filedata = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error];
    array = [filedata componentsSeparatedByString:@"\n"];
    for ( int i = 0; i <DATA_LENGTH; i++ ) {
        [[originStocks objectAtIndex:i] setObject:[array objectAtIndex:i] forKey:@"Miu"];
    }
    
}

- (void)viewDidUnload
{
    [tx1 release];
    [tx2 release];
    [tx3 release];
    [tx4 release];
    [tx5 release];
    [tx6 release];
    [slider release];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (BOOL)allDifferent:(NSArray *)array {
    for ( int i = 0; i < [array count]; i++ ) {
        for (int j = 0; j < [array count]; j++ ) {
            if ( i != j ) {
                if ( [[array objectAtIndex:i] intValue] == [[array objectAtIndex:j] intValue] ) 
                    return NO;
            }
        }
    }
   return YES;
}

- (NSArray *)selectSocktWithPercent:(double)percent key:(NSString *)key {
    NSMutableArray *array1 = [[NSMutableArray alloc] initWithArray:originStocks];
    NSMutableArray *array2 = [[[NSMutableArray alloc] init] autorelease];
    for ( int i = 0; i < percent*[originStocks count]; i++ ) {
        double max = [[[array1 objectAtIndex:0] objectForKey:key] doubleValue];
        int maxIndex = 0;
        for ( int j = 0; j < [array1 count]; j++ ) {
            double val = [[[array1 objectAtIndex:j] objectForKey:key] doubleValue];
            if (  val > max ) {
                max = val;
                maxIndex = j;
            }
        }
        [array2 addObject:[array1 objectAtIndex:maxIndex]];
        [array1 removeObjectAtIndex:maxIndex];
    }
    [array1 release];
    return array2;
}

-(void)filtData {
    [stocks removeAllObjects];
//    for (int i = 0; i < 30; i++ ) {
//        [stocks addObject:[originStocks objectAtIndex:i]];
//    }
   // [stocks addObjectsFromArray:originStocks];
    // Initial Principal:
    if ( ![tx1.text isEqualToString:@""] ) {
        
    }
    // Industry: 
//    if ( ![tx2.text isEqualToString:@""] ) {
//        
//    }
    // Required Stocks
    if ( ![tx3.text isEqualToString:@""] ) {
        
    }
    // ROE Ratio
    NSArray* roeArray;
    if ( ![tx4.text isEqualToString:@""] ) {
        double myRoe = [tx4.text doubleValue]/100;
        roeArray = [self selectSocktWithPercent:myRoe key:@"ROE"];
    }
    
    // PE Ratio
    NSArray* peArray;
    if ( ![tx5.text isEqualToString:@""] ) {
        double myPE = [tx5.text doubleValue]/100;
        peArray = [self selectSocktWithPercent:myPE key:@"PE"];
    }
    
    // PB Ratio
    NSArray* pbArray;
    if ( ![tx6.text isEqualToString:@""] ) {
        double myPB = [tx6.text doubleValue]/100;
        pbArray = [self selectSocktWithPercent:myPB key:@"PB"];
    }
    
    // Volatility
    NSArray* volArray;
    if ( (double)slider.value > 0 ) {
        double volatility = (double)slider.value/100;
        volArray = [self selectSocktWithPercent:volatility key:@"volatiliy"];
    }
    
    // 取它们的交集作为筛选结果
    for ( int i = 0; i < [roeArray count]; i++ ) {
        id obj = [roeArray objectAtIndex:i];
        if (( [ peArray containsObject:obj] ) &&
             ( [ pbArray containsObject:obj] ) &&
             ( [ volArray containsObject:obj] ) ) {
            [stocks addObject:obj];
        }
    }
    NSLog(@"过滤后剩余股票数：%d", [stocks count]);
} 



- (void)generateAllStockGroups {
    [randomIndex removeAllObjects];
    int length = [stocks count];
    for ( int r1 = 0; r1 < length-5; r1+=5 ) {
        for ( int r2 = 1; r2 < length-5; r2+=5 ) {
            for ( int r3 = 2; r3 < length-5; r3+=5 ) {
                for ( int r4 = 3; r4 < length-5; r4+=5 ) {
                    for ( int r5 = 4; r5 < length-5; r5+=5 ) {
                        NSMutableArray *group = [[NSMutableArray alloc] init];
                        [group addObject:[NSNumber numberWithInt:r1]];
                        [group addObject:[NSNumber numberWithInt:r2]];
                        [group addObject:[NSNumber numberWithInt:r3]];
                        [group addObject:[NSNumber numberWithInt:r4]];
                        [group addObject:[NSNumber numberWithInt:r5]];
                        if ( [self allDifferent:group] == YES ) {
                             [randomIndex addObject:group];
                        }
                        [group release];
                    }
                }
            }
        }
    }
}

- (NSDictionary *)portifolioGroup:(NSArray *)array {
    int length = [array count];
    float allWeight = 0;
    float currentMiu = 0;
    float currentOmega = 0;
    NSMutableArray *weights = [[NSMutableArray alloc] init];
    NSMutableDictionary * dic = [[NSMutableDictionary alloc] init];
    
    //  w1, w2, w3, w4, w5
    for ( int i = 0; i < length; i++ ) {
        double rowWeight = 0;
        for ( int j = 0; j < length; j++ ) {
            int index = [[array objectAtIndex:i] intValue] * DATA_LENGTH + [[array objectAtIndex:j] intValue];
            rowWeight += [[matrix objectAtIndex:index] floatValue];
        }
        allWeight += rowWeight;
        [weights addObject:[NSNumber numberWithFloat:rowWeight]];
    }
    
    //  miu 
    for (  int i = 0; i < length; i++ )  {
        double val = [[weights objectAtIndex:i] floatValue];
        double miu = [[[stocks objectAtIndex:[[array objectAtIndex:i] intValue]] objectForKey:@"Miu"] floatValue];
        double weight = miu*val / allWeight;
        [weights replaceObjectAtIndex:i withObject:[NSNumber numberWithFloat:weight]];
        currentMiu += weight;
    }
    
    // omega
    for (  int i = 0; i < length; i++ )  {
        for ( int j = 0; j < length; j++ ) {
            currentOmega += [[weights objectAtIndex:i] doubleValue] * [[weights objectAtIndex:j] doubleValue];
        }
    }
    
     [dic setObject:[NSNumber numberWithDouble:currentMiu] forKey:@"Miu"];   
     [dic setObject:[NSNumber numberWithDouble:currentOmega] forKey:@"Omega"];
//    NSLog(@"%lf, %lf",currentMiu, currentOmega);
//    if (( currentOmega > 10 )||( currentMiu > 10)) {
//         NSLog(@"%@", weights);
//         NSLog(@" miu: %f, currentOmega: %f", currentMiu, currentOmega);
//    }
    return dic;
}

- (void)portifolioAll {
    maxMiu = 100;  // 实际值不可能达到-100
    minOmega = 100; //  实际值不可能达到100
    double maxDevid = -999999;
    for ( int i = 0; i < [randomIndex count]; i++ ) {
        NSDictionary *dic = [self portifolioGroup:[randomIndex objectAtIndex:i]];
        double miu = [[dic objectForKey:@"Miu"] doubleValue];
        double omega = [[dic objectForKey:@"Omega"] doubleValue]; 
        double devid = 0;
        if ( omega != 0 ) {
            devid = ( miu - 0.04 ) / omega;
        } else {
            
        }
        if ( devid > maxDevid ) {
            bestGroup = [randomIndex objectAtIndex:i];
            maxDevid = devid;
            maxMiu = miu;
            minOmega = omega;
        } 
    }
//        else if (miu == maxMiu) {
//            if ( omega < minOmega ) {
//                bestGroup = [randomIndex objectAtIndex:i];
//                minOmega = omega;
//            }
//        }
    
//    NSLog(@"%lf, %@", maxMiu, bestGroup);
}

- (IBAction)submit:(id)sender {
        
    //  time begin
    float startTime = clock();
    
    //  filter
    [self filtData];
    
    if ( [stocks count] > 5 ) {
        //  index group
        [self generateAllStockGroups];
        
        // portifolio
        [self portifolioAll];
    }
    
    //  time end
    labelTime.text = [NSString  stringWithFormat:@"%f  ms", (clock() - startTime)/1000 ];  
    
    // addResaultView
    [resaultPicker reloadAllComponents];
    textView.text = [NSString stringWithFormat:@"Our Proposal： According to your specific needs, we have constructed the optimal portfolio. The portfolio will provide you the expected return of  %lf with a variance of  %lf . The portfolio was recommended as it can provide the highest sharpe ratio", maxMiu, minOmega];
    [self.view addSubview:resaultView];
}

- (IBAction)closeResault:(id)sender {
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

- (IBAction)sliderValueChanged {
    sliderLabel.text = [NSString stringWithFormat:@"%d",(int)slider.value ];
}
#pragma mark UIPickerView DateSource & Delegate

//- (void)addTimePicker {
//	//  add a cover view, so the other textFields wouldn't response to the users.
////	coverView_.frame = CGRectMake(0, 0, 320, 480);
////	[self.view addSubview:coverView_];
////	timePickerView_.frame = CGRectMake(0, 224, 320, 260);
////	[self.view addSubview:timePickerView_];
//
//}
//
//- (void)removeTimePicker {
//	// put date picker on screen and resize the table view.
////	timePickerView_.frame = CGRectMake(0, 480, 320, 260);
////	[timePickerView_ removeFromSuperview];
////	[coverView_ removeFromSuperview];
//}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if ( [bestGroup count] == 5 ) {
        //  如果有选定股票，则直接替换掉第一支
        if (( row==0 )&&( ![tx3.text isEqualToString:@""] )) {
            for (int i = 0; i < [originStocks count]; i++) {
                NSString *s =[[originStocks objectAtIndex:i] objectForKey:@"StockNum"];
                if ( [[s substringToIndex:9] isEqualToString:tx3.text]  ) {
                    NSDictionary *d = [originStocks objectAtIndex:i];
                    NSString *res = [NSString stringWithFormat:@"%@, %@", [d objectForKey:@"StockNum"], [d objectForKey:@"Industry"]];
                    //NSLog(@"replaced the first stock!");
                    return res;
                }
            } 
        }
        NSDictionary *d  = [stocks objectAtIndex:[[bestGroup objectAtIndex:row] intValue]];
        NSString *res = [NSString stringWithFormat:@"%@, %@", [d objectForKey:@"StockNum"], [d objectForKey:@"Industry"]];
        return res;
    }
    return @"";
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return 5;
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
	return 1;
}

@end
