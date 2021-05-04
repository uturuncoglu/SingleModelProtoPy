from esmf_wrapper import esmf_initialize_py

esmf_initialize_py(defaultConfigFileName=b"config.rc", 
  defaultLogFileName=b"log.txt", 
  logappendflag=True, 
  mpiCommunicator=1, 
  ioUnitLBound=5, 
  ioUnitUBound=10)
