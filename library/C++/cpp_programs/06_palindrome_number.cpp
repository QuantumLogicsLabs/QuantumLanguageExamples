#include <iostream>
using namespace std;

int main() {
    int n, original, reversed = 0;
    cout << "Enter a number: ";
    cin >> n;
    original = n;
    while (n != 0) {
        reversed = reversed * 10 + n % 10;
        n /= 10;
    }
    cout << (original == reversed ? "Palindrome" : "Not Palindrome") << endl;
    return 0;
}
