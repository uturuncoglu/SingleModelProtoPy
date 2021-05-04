      module ESMF_CalendarMod

      use iso_c_binding, only: c_int, c_loc, c_ptr, c_f_pointer

      !TODO: import it from ESMF using use statement
      type ESMF_CalKind_Flag
      private
        integer :: calkindflag
      end type

      contains

      subroutine create(handle, i) bind(C)
        type(c_ptr), intent(out) :: handle
        integer(c_int), intent(in) :: i
        type(ESMF_CalKind_Flag), pointer :: ckf
        allocate(ckf)
        ckf%calkindflag = i
        handle = c_loc(ckf)
      end subroutine create

      subroutine set_i(handle, i) bind(C)
        type(c_ptr), intent(in) :: handle
        integer(c_int), intent(in) :: i
        type (ESMF_CalKind_Flag), pointer :: ckf 
        call c_f_pointer(handle, ckf)
        ckf%calkindflag = i
      end subroutine set_i

      subroutine get_i(handle,i) bind(C)
        type(c_ptr), intent(in) :: handle
        integer(c_int), intent(out) :: i
        type (ESMF_CalKind_Flag), pointer :: ckf
        call c_f_pointer(handle, ckf)
        i = ckf%calkindflag 
      end subroutine get_i

      subroutine destroy(handle) bind(C)
        type(c_ptr), intent(inout) :: handle
        type (ESMF_CalKind_Flag), pointer :: ckf
        call c_f_pointer(handle, ckf)
        deallocate(ckf)
      end subroutine destroy

      end module ESMF_CalendarMod
