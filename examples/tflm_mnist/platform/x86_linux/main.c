#include <time.h>

extern int tflmicro_mnist(void);

unsigned int tflm_get_usec(void) {
    struct timespec times = {0, 0};
    long time;

    clock_gettime(CLOCK_MONOTONIC, &times);

    time = times.tv_sec * 1000000 + times.tv_nsec / 1000;

    return time;
}

int main(int argc, char* argv[]) {
    return tflmicro_mnist();
} 
