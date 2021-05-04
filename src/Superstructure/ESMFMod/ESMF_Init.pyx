# cython: language_level=3

# required for c++ support
from libcpp cimport bool

cdef extern from "ESMF_Init.h":
    void esmf_initialize(char* defaultConfigFileName, char* defaultLogFileName, bool* logappendflag, int* mpiCommunicator, int* ioUnitLBound, int* ioUnitUBound, int* rc)

def esmf_initialize_py(char* defaultConfigFileName, char* defaultLogFileName, bool logappendflag, int mpiCommunicator, int ioUnitLBound, int ioUnitUBound):
       cdef:
              int rc
       esmf_initialize(<char*> defaultConfigFileName, <char*> defaultLogFileName, &logappendflag, &mpiCommunicator, &ioUnitLBound, &ioUnitUBound, &rc) 
