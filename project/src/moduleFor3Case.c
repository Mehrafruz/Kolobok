#include <string.h>


#include "moduleFor3Case.h"

int custom_prime(int num) {
    int count = 0;
    for (int i = 1; i <= num; i++) {
        if (num % i == 0)
            count++;
    }
    if ((count <= 2) && (num > 1))
        return 1;
    else
        return 0;
}
