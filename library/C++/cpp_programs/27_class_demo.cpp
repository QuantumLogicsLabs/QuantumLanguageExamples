#include <iostream>
using namespace std;

class Rectangle {
private:
    double length, width;
public:
    Rectangle(double l, double w) : length(l), width(w) {}
    double area() { return length * width; }
};

int main() {
    Rectangle r(5.0, 3.0);
    cout << "Area = " << r.area() << endl;
    return 0;
}
