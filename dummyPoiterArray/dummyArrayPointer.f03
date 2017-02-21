!===============================================================================
module helper_module

  implicit none

  interface check_value
    module procedure check_values_int
    module procedure check_values_real
  end interface check_value

contains

  subroutine construct_fakeCopy( ptr, arr, lb, ub )
    ! input parameters
    integer, intent(in) :: lb(2), ub(2)
    real, dimension(:,:), intent(inout), pointer :: ptr
    real, dimension( lb(1):ub(1), lb(2):ub(2) ), intent(in), target  :: arr

    ptr( lb(1):ub(1), lb(2):ub(2) ) => arr

  end subroutine construct_fakeCopy

  function check_values_int( val1, val2 )
    integer :: val1, val2
    logical :: check_values_int

    if( val1 == val2 ) then
      check_values_int = .true.
    else
      check_values_int = .false.
    endif
  end function check_values_int

  function check_values_real( val1, val2 )
    real :: val1, val2
    logical :: check_values_real

    if( val1 == val2 ) then
      check_values_real = .true.
    else
      check_values_real = .false.
    endif
  end function check_values_real

end module helper_module
!===============================================================================
!===============================================================================
program dummy_array_pointer

  use helper_module

  implicit none

  ! boundaries for the real array
  integer, parameter, dimension(2) :: lb = (/ -1, 2 /)
  integer, parameter, dimension(2) :: ub = (/  4, 10 /)

  ! test value - to check correctness
  real, parameter :: test_val = 5

  ! real array - will be filled with values to check correctness of pointer
  real, dimension( lb(1):ub(1), lb(2):ub(2) ) :: test_arr

  ! pointer for connecting to array
  real, pointer :: ptr_arr(:,:)

  ! loop variables
  integer :: i, j

  ! set values in array
  do j = lb(2), ub(2)
    do i = lb(1), ub(1)
      test_arr(i,j) = test_val
    enddo
  enddo

  ! create an association of test_arr
  call construct_fakeCopy( ptr_arr, test_arr, lb, ub )

  print *, "checking lb(1) = ", check_value( lbound(ptr_arr, dim=1), lb(1) )
  print *, "checking lb(2) = ", check_value( lbound(ptr_arr, dim=2), lb(2) )

  print *, "checking ub(1) = ", check_value( ubound(ptr_arr, dim=1), ub(1) )
  print *, "checking ub(2) = ", check_value( ubound(ptr_arr, dim=2), ub(2) )

  do j = lb(2), ub(2)
    do i = lb(1), ub(1)
      if ( .not. check_value( ptr_arr(i, j), test_val ) ) then
        print *, "wrong value at ", i, j
        stop
      endif
    enddo
  enddo

  nullify(ptr_arr)

end program dummy_array_pointer
