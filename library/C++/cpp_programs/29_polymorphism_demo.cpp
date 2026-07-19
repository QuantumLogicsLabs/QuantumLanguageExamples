#include <iostream>
using namespace std;

class Shape {
public:
    virtual void draw() { cout << "Drawing a shape" << endl; }
};

class Circle : public Shape {
public:
    void draw() override { cout << "Drawing a circle" << endl; }
};

class Square : public Shape {
public:
    void draw() override { cout << "Drawing a square" << endl; }
};

int main() {
    Shape* shapes[2];
    Circle c;
    Square s;
    shapes[0] = &c;
    shapes[1] = &s;
    for (int i = 0; i < 2; i++) shapes[i]->draw();
    return 0;
}
