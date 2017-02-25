
#include <stdio.h>
#include <stdlib.h>

#ifdef __cplusplus
extern "C" {
#endif

#define THREAD_COUNT 10

__global__ void sum_array(float *arrayIn, float *arrayOut, int N) {
    int idx = threadIdx.x;
    int local_n = N / THREAD_COUNT;
    arrayOut[idx] = 0;
    for (int i = local_n * idx; i < local_n * (idx + 1); ++i) {
        arrayOut[idx] += arrayIn[i];
    }
}


void cudaMemAlloc(long size) {
//TODO check separate mem allocation performance gain
}

void cudaMemFree() {
//TODO check separate mem allocation performance gain
}

float cudaSum(float *array, int length) {

    float *arrayIn_d, *arrayOut_d;

    cudaMalloc((void **) &arrayIn_d, length * sizeof(float));
    cudaMalloc((void **) &arrayOut_d, THREAD_COUNT * sizeof(float));

    cudaMemcpy(arrayIn_d, array, (length * sizeof(float)), cudaMemcpyHostToDevice);

    sum_array << < 1, THREAD_COUNT >> > (arrayIn_d, arrayOut_d, length);

    float sum = 0.0f;

    float *arrayOut_h = (float *) malloc(sizeof(float) * THREAD_COUNT);
    cudaMemcpy(arrayOut_h, arrayOut_d, (THREAD_COUNT * sizeof(float)), cudaMemcpyDeviceToHost);

    for (int i = 0; i < THREAD_COUNT; ++i) {
        sum += arrayOut_h[i];
    }

    cudaFree(arrayOut_d);
    cudaFree(arrayIn_d);
    free(arrayOut_h);
    return sum;
}

#ifdef __cplusplus
}
#endif