#include <iostream>
using namespace std;

template <typename T>
T maxOf(T a, T b) {
    return (a > b) ? a : b;
}

int main() {
    cout << "Max of 3, 7: " << maxOf(3, 7) << endl;
    cout << "Max of 3.5, 2.1: " << maxOf(3.5, 2.1) << endl;
    return 0;
}
