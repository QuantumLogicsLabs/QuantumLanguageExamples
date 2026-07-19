#include <iostream>
#include <set>
using namespace std;

int main() {
    set<int> s = {5, 3, 8, 1, 3, 5};
    cout << "Set elements: ";
    for (int x : s) cout << x << " ";
    cout << endl;
    return 0;
}
