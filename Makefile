
INCLUDE_DIR_JNI = "/opt/jdk/jdk1.8.0_102/include"
INCLUDE_DIR_JNI_LINUX = "/opt/jdk/jdk1.8.0_102/include/linux"
LIB_DIR_CUDA = "/usr/local/cuda-8.0/lib64"

INCLUDE_DIR_FLAG = -I$(INCLUDE_DIR_JNI) -I$(INCLUDE_DIR_JNI_LINUX)
LIB_DIR_FLAG = -L$(LIB_DIR_CUDA)

LINKER_CUDA = -lcudart

CFLAGS = -shared -fPIC $(INCLUDE_DIR_FLAG) $(LIB_DIR_FLAG)

OUTPUT_FILE = libh2cuda.so

NVCCFLAGS = -arch=sm_50 -Xcompiler -fPIC

all: program

program: cudacode.o
	gcc $(CFLAGS) *.c *.h h2cuda.o $(LINKER_CUDA) -lstdc++ -o $(OUTPUT_FILE)

cudacode.o:
	nvcc $(NVCCFLAGS) -c h2cuda.cu

clean: 
	rm -rf *o program