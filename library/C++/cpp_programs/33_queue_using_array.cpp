#include <iostream>
using namespace std;

#define MAX 100

class Queue {
    int arr[MAX], front, rear;
public:
    Queue() { front = -1; rear = -1; }
    void enqueue(int x) {
        if (rear == MAX - 1) { cout << "Queue Full" << endl; return; }
        if (front == -1) front = 0;
        arr[++rear] = x;
    }
    void dequeue() {
        if (front == -1 || front > rear) { cout << "Queue Empty" << endl; return; }
        front++;
    }
    int peek() { return arr[front]; }
};

int main() {
    Queue q;
    q.enqueue(10);
    q.enqueue(20);
    q.enqueue(30);
    cout << "Front element: " << q.peek() << endl;
    q.dequeue();
    cout << "Front element after dequeue: " << q.peek() << endl;
    return 0;
}
