#include <iostream>
using namespace std;

#define MAX 100

class Stack {
    int arr[MAX], top;
public:
    Stack() { top = -1; }
    void push(int x) {
        if (top == MAX - 1) { cout << "Stack Overflow" << endl; return; }
        arr[++top] = x;
    }
    void pop() {
        if (top == -1) { cout << "Stack Underflow" << endl; return; }
        top--;
    }
    int peek() { return arr[top]; }
    bool isEmpty() { return top == -1; }
};

int main() {
    Stack s;
    s.push(10);
    s.push(20);
    s.push(30);
    cout << "Top element: " << s.peek() << endl;
    s.pop();
    cout << "Top element after pop: " << s.peek() << endl;
    return 0;
}
