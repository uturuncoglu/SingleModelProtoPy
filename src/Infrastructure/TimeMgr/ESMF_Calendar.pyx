cdef extern int create(void *handle, int *i);
cdef extern int get_i(void *handle, int *i);
cdef extern int set_i(void *handle, int *i);
cdef extern int destroy(void *handle);

cdef class ESMF_CalKind_Flag:
    cdef void *ptr
    def __init__(self, int i):
        create(&self.ptr,&i)
    property i:
        def __get__(self):
            cdef int i
            get_i(&self.ptr, &i)
            return i
        def __set__(self, int value):
            set_i(&self.ptr, &value)
    def __dealloc__(self):
        """make sure memory is deallocated when object goes out of scope"""
        destroy(&self.ptr)
