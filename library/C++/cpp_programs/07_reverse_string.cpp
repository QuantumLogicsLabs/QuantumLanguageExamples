#include <iostream>
#include <algorithm>
using namespace std;

int main() {
    string s;
    cout << "Enter a string: ";
    getline(cin, s);
    reverse(s.begin(), s.end());
    cout << "Reversed: " << s << endl;
    return 0;
}
