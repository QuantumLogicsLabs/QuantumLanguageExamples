#include <iostream>
#include <map>
using namespace std;

int main() {
    map<string, int> ages;
    ages["Alice"] = 30;
    ages["Bob"] = 25;
    ages["Charlie"] = 35;

    for (auto& pair : ages) {
        cout << pair.first << ": " << pair.second << endl;
    }
    return 0;
}
