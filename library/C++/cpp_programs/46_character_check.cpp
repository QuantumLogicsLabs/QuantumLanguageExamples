#include <iostream>
#include <cctype>
using namespace std;

int main() {
    char ch;
    cout << "Enter a character: ";
    cin >> ch;

    if (isalpha(ch)) cout << "Alphabet" << endl;
    else if (isdigit(ch)) cout << "Digit" << endl;
    else cout << "Special character" << endl;

    if (isupper(ch)) cout << "Uppercase" << endl;
    else if (islower(ch)) cout << "Lowercase" << endl;
    return 0;
}
