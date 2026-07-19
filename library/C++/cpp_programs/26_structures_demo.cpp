#include <iostream>
using namespace std;

struct Point {
    int x, y;
};

int main() {
    Point p1;
    p1.x = 5;
    p1.y = 10;
    cout << "Point: (" << p1.x << ", " << p1.y << ")" << endl;
    return 0;
}
