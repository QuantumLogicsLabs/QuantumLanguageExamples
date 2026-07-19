#include <iostream>
using namespace std;

int main() {
    int choice;
    cout << "1. Circle 2. Rectangle 3. Triangle\nEnter choice: ";
    cin >> choice;

    if (choice == 1) {
        double r;
        cout << "Enter radius: ";
        cin >> r;
        cout << "Area = " << 3.14159 * r * r << endl;
    } else if (choice == 2) {
        double l, w;
        cout << "Enter length and width: ";
        cin >> l >> w;
        cout << "Area = " << l * w << endl;
    } else if (choice == 3) {
        double b, h;
        cout << "Enter base and height: ";
        cin >> b >> h;
        cout << "Area = " << 0.5 * b * h << endl;
    } else {
        cout << "Invalid choice" << endl;
    }
    return 0;
}
