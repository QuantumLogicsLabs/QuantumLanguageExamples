#include <iostream>
#include <string>
using namespace std;

class Employee {
    string name;
    int id;
    double salary;
public:
    Employee(string n, int i, double s) : name(n), id(i), salary(s) {}
    void display() {
        cout << "ID: " << id << ", Name: " << name << ", Salary: " << salary << endl;
    }
};

int main() {
    Employee e("John Doe", 101, 55000);
    e.display();
    return 0;
}
