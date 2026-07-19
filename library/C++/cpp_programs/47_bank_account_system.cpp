#include <iostream>
using namespace std;

class BankAccount {
    double balance;
public:
    BankAccount(double initial = 0) : balance(initial) {}
    void deposit(double amount) { balance += amount; }
    void withdraw(double amount) {
        if (amount > balance) cout << "Insufficient balance!" << endl;
        else balance -= amount;
    }
    void showBalance() { cout << "Balance: " << balance << endl; }
};

int main() {
    BankAccount acc(1000);
    acc.deposit(500);
    acc.withdraw(200);
    acc.showBalance();
    return 0;
}
