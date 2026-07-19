#include <iostream>
#include <cmath>
using namespace std;

int main() {
    double principal, rate, time;
    cout << "Enter principal, rate and time: ";
    cin >> principal >> rate >> time;
    double ci = principal * (pow((1 + rate / 100), time)) - principal;
    cout << "Compound Interest = " << ci << endl;
    return 0;
}
