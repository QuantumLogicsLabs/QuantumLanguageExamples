#include <iostream>
using namespace std;

int main() {
    int n, key;
    cout << "Enter number of elements (sorted): ";
    cin >> n;
    int arr[100];
    for (int i = 0; i < n; i++) cin >> arr[i];
    cout << "Enter number to search: ";
    cin >> key;

    int low = 0, high = n - 1, mid, index = -1;
    while (low <= high) {
        mid = (low + high) / 2;
        if (arr[mid] == key) { index = mid; break; }
        else if (arr[mid] < key) low = mid + 1;
        else high = mid - 1;
    }

    if (index != -1) cout << "Found at index " << index << endl;
    else cout << "Not found" << endl;
    return 0;
}
