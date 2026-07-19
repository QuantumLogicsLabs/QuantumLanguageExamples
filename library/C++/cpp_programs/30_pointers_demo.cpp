#include <iostream>
using namespace std;

int main() {
    int a = 10;
    int* p = &a;
    cout << "Value of a: " << a << endl;
    cout << "Address of a: " << p << endl;
    cout << "Value via pointer: " << *p << endl;
    *p = 20;
    cout << "New value of a: " << a << endl;
    return 0;
}
