program openmp_hello

  implicit none

#ifdef _OPENMP
  include 'omp_lib.h'  ! needed to get OpenMP functions

  integer ::  thr_num

  !$omp parallel
  thr_num = OMP_get_thread_num()
  write( *, * ) "thread ", thr_num, "says hi!"
  !$omp end parallel

#endif

end program openmp_hello
