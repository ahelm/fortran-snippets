program testworkshare
  ! program to test if loop unrolling is better compared to workshare constructs
  implicit none

#ifdef _OPENMP
  include 'omp_lib.h'  ! needed to get OpenMP functions
#endif
#define LENGTH 100000

  real,  dimension(LENGTH)    :: a, b, sol, omp_sol
  real                        :: start, finish
  integer                     :: i, imin, imax

  ! initalize a and b as random vectors
  call random_number(a)
  call random_number(b)

  imin = lbound(a, dim=1)
  imax = ubound(a, dim=1)

  ! === REGULAR ===
  call cpu_time(start)
  sol = a + b
  call cpu_time(finish)
  print '("regular = ",f6.3," seconds.")', finish-start

  ! === WORKSHARE ===
  call cpu_time(start)
  !$omp parallel shared(a, b)
  !$omp workshare
  omp_sol = a + b
  !$omp end workshare
  !$omp end parallel
  call cpu_time(finish)
  call check_validity(omp_sol, sol)
  print '("workshare = ",f6.3," seconds.")', finish-start

  ! === UNROLLED LOOP ===
  call cpu_time(start)
  !$omp parallel shared(a, b)
  !$omp do
  do i = imin, imax
    omp_sol(i) = a(i) + b(i)
  enddo
  !$omp end do
  !$omp end parallel
  call cpu_time(finish)
  call check_validity(omp_sol, sol)
  print '("unrolled = ",f6.3," seconds.")', finish-start

end program testworkshare

subroutine check_validity( calc_sol, real_sol )

  implicit none

  real,   dimension(LENGTH),  intent(in)  :: calc_sol, real_sol
  real                                    :: diff
  real,   parameter                       :: tol = 1e-6
  integer                                 :: i, imin, imax

  imin = lbound(calc_sol, dim=1)
  imax = ubound(calc_sol, dim=1)

  do i = imin, imax
    diff = abs(calc_sol(i) - real_sol(i))
    if ( diff > tol ) then
      print '("difference is to high. diff = ",f6.3)', diff
    endif
  enddo

end subroutine check_validity
