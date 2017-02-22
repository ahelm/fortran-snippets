program associateShared

  implicit none

  integer, parameter         :: length = 100
  integer, dimension(length) :: really_ugly_long_name

  integer :: i

  associate( x => really_ugly_long_name )
  !$omp parallel do shared(x)
  do i = 1, length
    x(i) = 1
  enddo
  !$omp end parallel do
  end associate

end program associateShared
