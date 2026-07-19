#include <iostream>
using namespace std;

int main() {
    int n, key;
    cout << "Enter number of elements: ";
    cin >> n;
    int arr[100];
    for (int i = 0; i < n; i++) cin >> arr[i];
    cout << "Enter number to search: ";
    cin >> key;

    int index = -1;
    for (int i = 0; i < n; i++) {
        if (arr[i] == key) { index = i; break; }
    }

    if (index != -1) cout << "Found at index " << index << endl;
    else cout << "Not found" << endl;
    return 0;
}
