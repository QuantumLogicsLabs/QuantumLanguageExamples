#include <iostream>
#include <cmath>
using namespace std;

int main() {
    int n, original, remainder, result = 0;
    cout << "Enter a number: ";
    cin >> n;
    original = n;
    int digits = to_string(n).length();
    while (n != 0) {
        remainder = n % 10;
        result += pow(remainder, digits);
        n /= 10;
    }
    cout << (result == original ? "Armstrong Number" : "Not an Armstrong Number") << endl;
    return 0;
}
