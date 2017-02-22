program shared_boundaries

  use omp_lib

  implicit none

  integer, parameter        :: lb = -2, ub = 5
  integer, dimension(lb:ub), target :: arr
  integer, pointer          :: ptr(:)
  integer :: thread_id

  integer :: i

  ptr => arr

  ptr = 0

  !$omp parallel shared(ptr) private(thread_id)

  thread_id = OMP_GET_THREAD_NUM()

  print '(a,i5,i5,i5)', ">> thread_id = ", thread_id, lbound(ptr), ubound(ptr)

  !$omp do
  do i = lb, ub
    ptr(i) = 1
  enddo
  !$omp end do
  !$omp end parallel

  print '(a,8i4)', "(arr) = ", arr

end program shared_boundaries
