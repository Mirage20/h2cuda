#include <stdio.h>
#include "org_h2_command_dml_gpu_GMath.h"


extern float cudaSum(float *array, int lenth);

extern void cudaMemAlloc(long size);

extern void cudaMemFree();

/*
 * Class:     org_h2_command_dml_gpu_GMath
 * Method:    cudaSum
 * Signature: ([FI)F
 */
JNIEXPORT jfloat JNICALL Java_org_h2_command_dml_gpu_GMath_cudaSum
        (JNIEnv *env, jclass class, jfloatArray array, jint size) {
    printf("h2cuda sum function call (%d).\n", size);

    float result;

    jfloat *floatArrayPtr = (*env)->GetFloatArrayElements(env, array, 0);

    result = cudaSum(floatArrayPtr, size);

    return result;
}

/*
 * Class:     org_h2_command_dml_gpu_GMath
 * Method:    cudaMemAlloc
 * Signature: (J)V
 */
JNIEXPORT void JNICALL Java_org_h2_command_dml_gpu_GMath_cudaMemAlloc
        (JNIEnv *env, jclass class, jlong size) {
    printf("h2cuda Memory Allocated (%ld).\n", size);
    cudaMemAlloc(size);
}

/*
 * Class:     org_h2_command_dml_gpu_GMath
 * Method:    cudaMemFree
 * Signature: ()V
 */
JNIEXPORT void JNICALL Java_org_h2_command_dml_gpu_GMath_cudaMemFree
        (JNIEnv *env, jclass class) {
    printf("h2cuda Memory Released.\n");
    cudaMemFree();
}

