#include <iostream>
#include <cstring>
using namespace std;

int main() {
    char str1[100], str2[100];
    cout << "Enter a string: ";
    cin.getline(str1, 100);
    strcpy(str2, str1);
    cout << "Copied string: " << str2 << endl;
    cout << "Length: " << strlen(str1) << endl;
    strcat(str1, " appended");
    cout << "Concatenated: " << str1 << endl;
    return 0;
}
