module ESMF_InitMod

use iso_c_binding
!use ESMF, only : ESMF_Initialize

implicit none

contains

subroutine esmf_initialize(defaultConfigFileName, &
                             defaultLogFileName, &
                             logappendflag, &
                             mpiCommunicator, &
                             ioUnitLBound, &
                             ioUnitUBound, &
                             rc) bind(c)

      !character(kind=c_char,len=*),     intent(in),  optional :: defaultConfigFileName
      !character(kind=c_char,len=*),     intent(in),  optional :: defaultLogFileName
      !character(kind=c_char),     intent(in),  optional :: defaultConfigFileName
      !character(kind=c_char),     intent(in),  optional :: defaultLogFileName
      type(c_ptr), value, intent(in)    :: defaultConfigFileName ! it is not possible to provide optional with value under Fortran 2018
      type(c_ptr), value, intent(in)    :: defaultLogFileName
      logical(c_bool),       intent(in),  optional :: logappendflag
      integer(c_int),        intent(in),  optional :: mpiCommunicator
      integer(c_int),        intent(in),  optional :: ioUnitLBound
      integer(c_int),        intent(in),  optional :: ioUnitUBound
      integer(c_int),        intent(out), optional :: rc
    
      ! locals 
      character(len=256) :: dummy1
      character(len=256) :: dummy2


      call C_string_ptr_to_F_string(defaultConfigFileName, dummy1)
      call C_string_ptr_to_F_string(defaultLogFileName, dummy2)
      !print*, defaultConfigFileName
      !print*, defaultLogFileName
      print*, trim(dummy1)
      print*, trim(dummy2)
      print*, logappendflag
      print*, mpiCommunicator
      print*, ioUnitLBound 
      print*, ioUnitUBound
      !call ESMF_Initialize(keywordEnforcer, defaultConfigFileName, defaultCalKind, &
      !  defaultLogFileName, logappendflag, logkindflag, mpiCommunicator,  &
      !  ioUnitLBound, ioUnitUBound, vm, rc)

end subroutine esmf_initialize

subroutine C_string_ptr_to_F_string(C_string, F_string)
    use ISO_C_BINDING
    type(C_PTR), intent(in) :: C_string
    character(len=*), intent(out) :: F_string
    character(len=1, kind=C_CHAR), dimension(:), pointer :: p_chars
    integer :: i
    if (.not. C_associated(C_string)) then
      F_string = ' '
    else
      call C_F_pointer(C_string, p_chars, [huge(0)])
      do i = 1, len(F_string)
        if (p_chars(i) == C_NULL_CHAR) exit
        F_string(i:i) = p_chars(i)
      end do
      if (i <= len(F_string)) F_string(i:) = ' '
    end if
end subroutine

end module ESMF_InitMod 
