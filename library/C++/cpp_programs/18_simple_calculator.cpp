#include <iostream>
using namespace std;

int main() {
    char op;
    double a, b;
    cout << "Enter operator (+, -, *, /): ";
    cin >> op;
    cout << "Enter two operands: ";
    cin >> a >> b;

    switch (op) {
        case '+': cout << a + b << endl; break;
        case '-': cout << a - b << endl; break;
        case '*': cout << a * b << endl; break;
        case '/':
            if (b != 0) cout << a / b << endl;
            else cout << "Division by zero error" << endl;
            break;
        default: cout << "Invalid operator" << endl;
    }
    return 0;
}
