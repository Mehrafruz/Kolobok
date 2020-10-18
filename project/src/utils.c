#include <string.h>

#include "utils.h"

size_t custom_strlen(const char* str) {
    size_t size = 0;
    for (size_t i = 0; str[i]; i++) {
        size += sizeof(str[i]);
    }
    return size;
}

// TODO(Igor Khaributov): Implement `power of` function

int custom_pow(int base, int power) {
    int result = 1;
    for (int i = 1; i <= power; i++) {
        result *= base;
    }
    return result;
}


