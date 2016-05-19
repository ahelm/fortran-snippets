program whoami
  ! small program sharing geneal information about MPI process and thread informations
  !
  ! TODO: check if threads and process are spread apart on different CPUS

  implicit none

  include 'mpif.h'

#ifdef _OPENMP
  include 'omp_lib.h'
#endif

  ! MPI
  integer             :: i, rank, nprocs, ierror, resultlen
  character (len=128) :: proc_name

  ! openMP
  integer             :: th_num, th_max, cpu
  integer, external   :: findmycpu


  call mpi_init(ierror)

  call mpi_comm_size(mpi_comm_world, nprocs, ierror)
  call mpi_comm_rank(mpi_comm_world, rank, ierror)
  call mpi_get_processor_name(proc_name, resultlen, ierror)

#ifdef _OPENMP

  !$omp parallel private(th_num, th_max, cpu)

  th_num = omp_get_thread_num()
  th_max = omp_get_num_threads()
  cpu = findmycpu()

  write(*,'(a,i2,a,i2,a,i2,a,a,a,i4,a,i4)') &
    "openMP/MPI : ", th_num, " @ ", cpu, " / ", th_max, " :: on ", &
    proc_name(:resultlen), " = ", rank, " / ", nprocs

  call sleep(1)

  !$omp end parallel

#else

  write(*,'(a,i0.4,a,i0.4,a,a)') &
      "MPI : ", rank, " / ", nprocs, " / ", proc_name(:resultlen)

#endif

  call MPI_FINALIZE(ierror)

end program whoami
