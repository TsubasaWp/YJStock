//
//  Algorithm.m
//  YJStock
//
//  Created by Wang Pei on 12-5-28.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "Algorithm.h"


//using namespace std;

double max(double x, double y) {
    if (x >= y) {
        return x;
    } else {
        return y;
    }
}

double carmen_gaussian_random() {
    
    const double norm = 1.0 / (RAND_MAX + 1.0);
    double u = 1.0 - rand() * norm; /**//* can't let u == 0 */
    double v = rand() * norm;
    double z = sqrt(-2.0 * log(u)) * cos(2.0 * M_PI * v);
    return z;
}

double E_Call(double S0, double r, int T, double segma, double K) {
    double x, result, sum, z1;
    int j;
    for (j = 1; j <= 10000; j++) {
        z1 = carmen_gaussian_random();
        sum = S0 * exp((r - 0.5 * segma * segma) * (double)T / 365 + segma * sqrt((double)T / 365) * z1);
        x = exp(-r * (double)T / 365) * max(sum - K, 0);
        result = x + result;
    }
    result = result / 10000;
    return result;
}

double E_Put(double S0, double r, int T, double segma, double K) {
    double x, result, sum, z1;
    int j;
    for (j = 1; j <= 10000; j++) {
        z1 = carmen_gaussian_random();
        sum = S0 * exp((r - 0.5 * segma * segma) * (double)T / 365 + segma * sqrt((double)T / 365) * z1);
        x = exp(-r * (double)T / 365) * max(K - sum, 0);
        result = x + result;
    }
    result = result / 10000;
    return result;
}

double E_Call_Delta(double S0, double r, int T, double segma, double K) {
    double x, result, sum, z1;
    int j;
    for (j = 1; j <= 10000; j++) {
        z1 = carmen_gaussian_random();
        sum = S0 * exp((r - 0.5 * segma * segma) * (double)T / 365 + segma * sqrt((double)T / 365) * z1);
        if (sum >= K) {
            x = exp(-r * (double)T / 365) * sum / S0;
        } else {
            x = 0;
        }
        result = x + result;
    }
    result = result / 10000;
    return result;
}

double E_Put_Delta(double S0, double r, int T, double segma, double K) {
    double x, result, sum, z1;
    int j;
    for (j = 1; j <= 10000; j++) {
        z1 = carmen_gaussian_random();
        sum = S0 * exp((r - 0.5 * segma * segma) * (double)T / 365 + segma * sqrt((double)T / 365) * z1);
        if (sum <= K) {
            x = -exp(-r * (double)T / 365) * sum / S0;
        } else {
            x = 0;
        }
        result = x + result;
    }
    result = result / 10000;
    return result;
}

double E_Call_Theta(double S0, double r, int T, double segma, double K) {
    double x, result, sum, z1, factor;
    int j;
    for (j = 1; j <= 10000; j++) {
        z1 = carmen_gaussian_random();
        sum = S0 * exp((r - 0.5 * segma * segma) * (double)T / 365 + segma * sqrt((double)T / 365) * z1);
        factor = (r - 0.5 * segma * segma) / 365 + z1 * segma / (2 * sqrt((double)T * 365));
        if (sum >= K) {
            x = -r * exp(-r * (double)T / 365) * max(sum - K, 0) / 365 + exp(-r * (double)T / 365) * factor*sum;
        } else {
            x = -r * exp(-r * (double)T / 365) * max(sum - K, 0) / 365;
        }
        result = x + result;
    }
    result = result / 10000;
    return result;
}

double E_Put_Theta(double S0, double r, int T, double segma, double K) {
    double x, result, sum, z1, factor;
    int j;
    for (j = 1; j <= 10000; j++) {
        z1 = carmen_gaussian_random();
        sum = S0 * exp((r - 0.5 * segma * segma) * (double)T / 365 + segma * sqrt((double)T / 365) * z1);
        factor = (r - 0.5 * segma * segma) / 365 + z1 * segma / (2 * sqrt((double)T * 365));
        if (sum <= K) {
            x = -r * exp(-r * (double)T / 365) * max(K - sum, 0) / 365 - exp(-r * (double)T / 365) * factor*sum;
        } else {
            x = -r * exp(-r * (double)T / 365) * max(K - sum, 0) / 365;
        }
        result = x + result;
    }
    result = result / 10000;
    return result;
}

double E_Call_Vega(double S0, double r, int T, double segma, double K) {
    double x, result, sum, z1, factor;
    int j;
    for (j = 1; j <= 10000; j++) {
        z1 = carmen_gaussian_random();
        sum = S0 * exp((r - 0.5 * segma * segma) * (double)T / 36500 + segma * sqrt((double)T / 365) * z1);
        factor = sqrt((double)T / 365) * z1 - segma * (double)T / 365;
        if (sum >= K) {
            x = exp(-r * (double)T / 365) * sum * factor;
        } else {
            x = 0;
        }
        result = x + result;
    }
    result = result / 10000;
    return result;
}

double E_Call_Gamma(double S0, double r, int T, double segma, double K) {
    double x, result, sum, z1;
    int j;
    for (j = 1; j <= 10000; j++) {
        z1 = carmen_gaussian_random();
        sum = S0 * exp((r - 0.5 * segma * segma) * (double)T / 365 + segma * sqrt((double)T / 365) * z1);
        if (sum >= K) {
            x = exp(-r * (double)T / 365) * z1 * K / (S0 * S0 * segma * sqrt((double)T / 365));
        } else {
            x = 0;
        }
        result = x + result;
    }
    result = result / 10000;
    return result;
}

double E_Call_Rho(double S0, double r, int T, double segma, double K) {
    double x, result, sum, z1;
    int j;
    for (j = 1; j <= 10000; j++) {
        z1 = carmen_gaussian_random();
        sum = S0 * exp((r - 0.5 * segma * segma) * (double)T / 365 + segma * sqrt((double)T / 365) * z1);
        if (sum >= K) {
            x = -T * exp(-r * (double)T / 365) * max(sum - K, 0) / 365 + exp(-r * (double)T / 365) * T * sum / 365;
        } else {
            x = -T * exp(-r * (double)T / 365) * max(sum - K, 0) / 365;
        }
        result = x + result;
    }
    result = result / 10000;
    return result;
}

double E_Put_Rho(double S0, double r, int T, double segma, double K) {
    double x, result, sum, z1;
    int j;
    for (j = 1; j <= 10000; j++) {
        z1 = carmen_gaussian_random();
        sum = S0 * exp((r - 0.5 * segma * segma) * (double)T / 365 + segma * sqrt((double)T / 365) * z1);
        if (sum <= K) {
            x = -T * exp(-r * (double)T / 365) * max(K - sum, 0) / 365 - exp(-r * (double)T / 365) * T * sum / 365;
        } else {
            x = -T * exp(-r * (double)T / 365) * max(K - sum, 0) / 365;
        }
        result = x + result;
    }
    result = result / 10000;
    return result;
}

double A_Call(double S0, double r, int T, double segma, double K) {
    double x, result, sum, z1;
    int i, j;
    for (j = 1; j <= 100; j++) {
        for (i = 1, sum = 0; i <= 100 * (double)T; i++) {
            z1 = carmen_gaussian_random();
            sum = sum + S0 * exp((r - 0.5 * segma * segma) * (double)i / 36500 + segma * sqrt((double)i / 36500) * z1);
        }
        sum = sum / (100 * (double)T);
        x = exp(-r * (double)T / 365) * max(sum - K, 0);
        result = x + result;
    }
    result = result / 1000;
    return result;
}

double A_Put(double S0, double r, int T, double segma, double K) {
    double x, result, sum, z1;
    int i, j;
    for (j = 1; j <= 1000; j++) {
        for (i = 1, sum = 0; i <= 100 * (double)T; i++) {
            z1 = carmen_gaussian_random();
            sum = sum + S0 * exp((r - 0.5 * segma * segma) * (double)i / 36500 + segma * sqrt((double)i / 36500) * z1);
        }
        sum = sum / (100 * (double)T);
        x = exp(-r * (double)T / 365) * max(K - sum, 0);
        result = x + result;
    }
    result = result / 1000;
    return result;
}

double A_Call_Delta(double S0, double r, int T, double segma, double K) {
    double x, result, sum, z1;
    int i, j;
    for (j = 1; j <= 1000; j++) {
        for (i = 1, sum = 0; i <= 100 * (double)T; i++) {
            z1 = carmen_gaussian_random();
            sum = sum + S0 * exp((r - 0.5 * segma * segma) * (double)i / 36500 + segma * sqrt((double)i / 36500) * z1);
        }
        sum = sum / (100 * (double)T);
        if (sum >= K) {
            x = exp(-r * (double)T / 365) * sum / S0;
        } else {
            x = 0;
        }
        result = x + result;
    }
    result = result / 1000;
    return result;
}

double A_Put_Delta(double S0, double r, int T, double segma, double K) {
    double x, result, sum, z1;
    int i, j;
    for (j = 1; j <= 1000; j++) {
        for (i = 1, sum = 0; i <= 100 * (double)T; i++) {
            z1 = carmen_gaussian_random();
            sum = sum + S0 * exp((r - 0.5 * segma * segma) * (double)i / 36500 + segma * sqrt((double)i / 36500) * z1);
        }
        sum = sum / (100 * (double)T);
        if (sum <= K) {
            x = -exp(-r * (double)T / 365) * sum / S0;
        } else {
            x = 0;
        }
        result = x + result;
    }
    result = result / 1000;
    return result;
}

double A_Call_Theta(double S0, double r, int T, double segma, double K) {
    double x, result, sum, z1, factor, temp1, st;
    int i, j;
    for (j = 1; j <= 1000; j++) {
        for (i = 1, st = 0, temp1 = 0; i <= 100 * (double)T; i++) {
            z1 = carmen_gaussian_random();
            sum = S0 * exp((r - 0.5 * segma * segma) * (double)i / 36500 + segma * sqrt((double)i / 36500) * z1);
            temp1 = sum;
            st = st + sum;
        }
        st = st / (100 * (double)T);
        if (st >= K) {
            x = -r * exp(-r * (double)T / 365) * max(st - K, 0) / 365 + exp(-r * (double)T / 365) * temp1;
        } else {
            x = -r * exp(-r * (double)T / 365) * max(st - K, 0) / 365;
        }
        result = x + result;
    }
    result = result / 1000;
    return result;
}

double A_Put_Theta(double S0, double r, int T, double segma, double K) {
    double x, result, sum, z1, factor, temp1, st;
    int i, j;
    for (j = 1; j <= 1000; j++) {
        for (i = 1, st = 0, temp1 = 0; i <= 100 * (double)T; i++) {
            z1 = carmen_gaussian_random();
            sum = S0 * exp((r - 0.5 * segma * segma) * (double)i / 36500 + segma * sqrt((double)i / 36500) * z1);
            temp1 = sum;
            st = st + sum;
        }
        st = st / (100 * (double)T);
        if (st <= K) {
            x = -r * exp(-r * (double)T / 365) * max(K - st, 0) / 365 - exp(-r * (double)T / 365) * temp1;
        } else {
            x = -r * exp(-r * (double)T / 365) * max(K - st, 0) / 365;
        }
        result = x + result;
    }
    result = result / 1000;
    return result;
}

double A_Call_Vega(double S0, double r, int T, double segma, double K) {
    double x, result, sum, z1, factor, product, st;
    int i, j;
    for (j = 1; j <= 1000; j++) {
        for (i = 1, sum = 0, product = 0, st = 0; i <= 100 * (double)T; i++) {
            z1 = carmen_gaussian_random();
            sum = S0 * exp((r - 0.5 * segma * segma) * (double)i / 36500 + segma * sqrt((double)i / 36500) * z1);
            factor = sqrt((double)i / 36500) * z1 - segma * (double)i / 36500;
            product = sum * factor + product;
            st = st + sum;
        }
        product = product / (100 * (double)T);
        st = st / (100 * (double)T);
        if (st >= K) {
            x = exp(-r * (double)T / 365) * product;
        } else {
            x = 0;
        }
        result = x + result;
    }
    result = result / 1000;
    return result;
}

double A_Call_Gamma(double S0, double r, int T, double segma, double K) {
    double x, result, sum, z1, temp;
    int i, j;
    for (j = 1; j <= 1000; j++) {
        for (i = 1, sum = 0; i <= 100 * (double)T; i++) {
            z1 = carmen_gaussian_random();
            sum = sum + S0 * exp((r - 0.5 * segma * segma) * (double)i / 36500 + segma * sqrt((double)i / 36500) * z1);
            if (i == 1) {
                temp = z1;
            } else {
                temp = temp;
            }
        }
        sum = sum / (100 * (double)T);
        if (sum >= K) {
            x = exp(-r * (double)T / 365) * temp * K / (S0 * S0 * segma * sqrt(1.0 / 36500));
        } else {
            x = 0;
        }
        result = x + result;
    }
    result = result / 1000;
    return result;
}

double A_Call_Rho(double S0, double r, int T, double segma, double K) {
    double x, result, sum, z1, temp, st;
    int i, j;
    for (j = 1; j <= 1000; j++) {
        for (i = 1, sum = 0, st = 0, temp = 0; i <= 100 * (double)T; i++) {
            z1 = carmen_gaussian_random();
            sum = S0 * exp((r - 0.5 * segma * segma) * (double)i / 36500 + segma * sqrt((double)i / 36500) * z1);
            temp = sum * (double)i / 36500 + temp;
            st = sum + st;
        }
        st = st / (100 * (double)T);
        temp = temp / (100 * (double)T);
        if (st >= K) {
            x = -T * exp(-r * (double)T / 365) * max(st - K, 0) / 365 + exp(-r * (double)T / 365) * temp;
        } else {
            x = -T * exp(-r * (double)T / 365) * max(st - K, 0) / 365;
        }
        result = x + result;
    }
    result = result / 1000;
    return result;
}

double A_Put_Rho(double S0, double r, int T, double segma, double K) {
    double x, result, sum, z1, temp, st;
    int i, j;
    for (j = 1; j <= 1000; j++) {
        for (i = 1, sum = 0, st = 0, temp = 0; i <= 100 * (double)T; i++) {
            z1 = carmen_gaussian_random();
            sum = S0 * exp((r - 0.5 * segma * segma) * (double)i / 36500 + segma * sqrt((double)i / 36500) * z1);
            temp = sum * (double)i / 36500 + temp;
            st = sum + st;
        }
        st = st / (100 * (double)T);
        temp = temp / (100 * (double)T);
        if (st <= K) {
            x = -T * exp(-r * (double)T / 365) * max(K - st, 0) / 365 - exp(-r * (double)T / 365) * temp;
        } else {
            x = -T * exp(-r * (double)T / 365) * max(K - st, 0) / 365;
        }
        result = x + result;
    }
    result = result / 1000;
    return result;
}

int CompareMax(double x[100]) {
    int i, temp;
    for (i = 0, temp = 0; i <= 99; i++) {
        if (x[i + 1] >= x[i]) {
            temp = i + 1;
        } else {
            temp = temp;
        }
    }
    return temp;
}


double E_Put_Adapted(double S0, double r, int T, double segma, double K,double y) {
    double x, result, sum, z1;
    int j;
    for (j = 1; j <= 100000; j++) {
        z1 = carmen_gaussian_random();
        sum = S0 * exp((r - 0.5 * segma * segma) * (double)T / 365 + segma * sqrt((double)T/ 365) * z1);
        x = exp(-r * (double)T / 365) * max(K-sum, y);
        result = x + result;
    }
    result = result / 100000;
    return result;
}

double Amercian_Put_MSR(double S0, double r, int T, double segma, double K) {
    double h[100][T + 1], hbest[T + 1], st[100][T + 1], z1, x[T + 1], result, hb, m;
    int i, j, k, l, tbest, temp;
    for (j = 0, temp = 0, m = 0; j <= 99; j++) {
        for (i = 1; i <= T; i++) {
            z1 = carmen_gaussian_random();
            st[j][0] = S0;
            st[j][i] = st[j][i - 1] * exp((r - 0.5 * segma * segma) * 1.0 / 365 + segma * sqrt(1.0 / 365) * z1);
            h[j][i] = exp(-r*(double)i/365)*max(K - st[j][i], 0);
        }
    }
    for (l = 1, x[l] = 0, hbest[l] = 0; l <= T; l++) {
        for (k = 0; k <= 99; k++) {
            x[l] = h[k][l];
        }
        hbest[l] = x[l] / 100;
    }
    for (i = 1, temp = 0, m = 0; i <= T; i++) {
        if (hbest[i] >= m) {
            temp = i;
            m = hbest[i];
        }
    }
    tbest = temp;
    hb = m * exp(r * ((double)T) / 365);
    result = E_Put_Adapted(S0, r, T, segma, K,hb);
    return result;
}
