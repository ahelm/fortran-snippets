program openmp_oneliner
  ! program to test how openmp behaves on matrix expressions
  ! - setting arrays to specific values
  ! - perform array calculations

  use omp_lib

  implicit none

  integer :: nthreads
  real, dimension(1:1000000) :: test_array
  real, dimension(1:1000000) :: x = 1.0, y = 2.0
  real(8) :: t_start, t_end

  ! general output
  nthreads = omp_get_max_threads()
  print *, "nthreads             = ", nthreads

  ! -----------------------------------
  ! setting a value
  ! -----------------------------------
  t_start = omp_get_wtime()
  !$omp parallel
  test_array = 0.0
  !$omp end parallel
  t_end = omp_get_wtime()

  print *, "set value            = ", (t_end - t_start)

  ! -----------------------------------
  ! perform calculations
  ! -----------------------------------
  t_start = omp_get_wtime()
  !$omp parallel shared(x, y)
  test_array = x + y
  !$omp end parallel
  t_end = omp_get_wtime()

  print *, "perform calculations = ", (t_end - t_start)

end program openmp_oneliner
