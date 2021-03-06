#include <iostream>

typedef unsigned int uint;

int main() {
    uint a1, a2, a3, a4;
    uint n;

    if (n < 4) return 0;

    std::cin >> a1 >> a2 >> a3 >> a4 >> n;

    do {
        int an = (a1 + a2 + a3 + a4);
        a1 = a2;
        a2 = a3;
        a3 = a4;
        a4 = an;
    } while (--n > 4);

    std::cout << a4;

    return 0;
}
