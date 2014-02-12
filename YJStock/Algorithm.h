//
//  Algorithm.h
//  YJStock
//
//  Created by Wang Pei on 12-5-28.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#include   <math.h>  
#include   <stdio.h>  
#include   <stdlib.h>  
#include   <time.h>  

double max(double x, double y);
 double carmen_gaussian_random() ;
 double E_Call(double S0, double r, int T, double segma, double K);
 double E_Put(double S0, double r, int T, double segma, double K) ;
 double E_Call_Delta(double S0, double r, int T, double segma, double K);
 double E_Put_Delta(double S0, double r, int T, double segma, double K);
 double E_Call_Theta(double S0, double r, int T, double segma, double K);
 double E_Put_Theta(double S0, double r, int T, double segma, double K);
 double E_Call_Vega(double S0, double r, int T, double segma, double K);
 double E_Call_Gamma(double S0, double r, int T, double segma, double K) ;
 double E_Call_Rho(double S0, double r, int T, double segma, double K);
 double E_Put_Rho(double S0, double r, int T, double segma, double K) ;
 double A_Call(double S0, double r, int T, double segma, double K);
 double A_Put(double S0, double r, int T, double segma, double K);
 double A_Call_Delta(double S0, double r, int T, double segma, double K) ;
 double A_Put_Delta(double S0, double r, int T, double segma, double K);
 double A_Call_Theta(double S0, double r, int T, double segma, double K);
 double A_Put_Theta(double S0, double r, int T, double segma, double K);
 double A_Call_Vega(double S0, double r, int T, double segma, double K) ;
 double A_Call_Gamma(double S0, double r, int T, double segma, double K) ;
 double A_Call_Rho(double S0, double r, int T, double segma, double K);
 double A_Put_Rho(double S0, double r, int T, double segma, double K) ;
 int CompareMax(double x[100]);
 double Amercian_Put_MSR(double S0, double r, int T, double segma, double K);

