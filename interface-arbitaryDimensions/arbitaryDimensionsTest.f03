module functioncall
  ! General module which includes several routines depending on dimension of array
  implicit none

  private

  ! generalized function call
  interface general_func
    module procedure func_dim1
    module procedure func_dim2
  end interface

  public :: general_func

contains

  subroutine func_dim1( arr )
    integer, dimension( 1:2 )        :: arr

    write( * , * ) "insdie func_dim1"
    write( * , * ) shape(arr)
    write( * , * ) arr

  end subroutine func_dim1

  subroutine func_dim2( arr )
    integer, dimension( 1:2, 1:2 )   :: arr

    write( * , * ) "insdie func_dim2"
    write( * , * ) shape(arr)
    write( * , * ) arr

  end subroutine func_dim2

end module functioncall

program arbitarydimensionstest

  use functioncall

  implicit none

  ! variables of same type but different dimension size
  integer, dimension( 1:2 )         :: dim1
  integer, dimension( 1:2, 1:2 )    :: dim2

  ! initialize arrays
  dim1 = (/ 1, 2 /)
  dim2 = reshape((/ 1, 2, 3, 4 /), shape(dim2))

  ! call function on dim1 array
  write( * , * ) ">> output of func_dim1 - array:"
  call general_func( dim1 )

  ! call function on dim2 array
  write( * , * ) ">> output of func_dim2 - array:"
  call general_func( dim2 )


end program arbitarydimensionstest
