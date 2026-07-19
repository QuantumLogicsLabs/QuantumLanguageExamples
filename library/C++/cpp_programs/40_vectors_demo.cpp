#include <iostream>
#include <vector>
using namespace std;

int main() {
    vector<int> v = {5, 3, 8, 1, 9};
    v.push_back(20);
    cout << "Vector elements: ";
    for (int x : v) cout << x << " ";
    cout << endl;
    cout << "Size: " << v.size() << endl;
    return 0;
}
