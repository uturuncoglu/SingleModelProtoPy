from esmf_wrapper import esmf_initialize_py
from esmf_wrapper import ESMF_CalKind_Flag

ckf = ESMF_CalKind_Flag(i=2)
print(ckf)
print(ckf.i)

esmf_initialize_py(defaultConfigFileName=b"config.rc", 
  defaultLogFileName=b"log.txt", 
  logappendflag=True, 
  mpiCommunicator=1, 
  ioUnitLBound=5, 
  ioUnitUBound=10)
