program openmp_pi
  ! use simple pi calculation without random MonteCarlo like calculation
  ! distribute points equally in x-y plane and count the points inside/outside circle

  implicit none

  integer , parameter                     :: x_pts = 100
  integer , parameter                     :: y_pts = 100
  real    , dimension( 0:x_pts )          :: x = 0.0
  real    , dimension( 0:y_pts )          :: y = 0.0
  logical , dimension( 0:x_pts , 0:y_pts) :: inside = .false.
  real                                    :: dx , dy
  integer                                 :: i , j
  integer                                 :: num_inside = 0
  real                                    :: pi
  real                                    :: start , end

  ! spatial distance between points
  dx = 2.0 / x_pts
  dy = 2.0 / y_pts

  !!!!! OPENMP !!!!!
  call cpu_time( start )

  ! construct positions of darts - construct race condition
  !$omp parallel do private(i)
  do i = 0 , x_pts
    x(i) = x(i-1) - 1.0 + i * dx
  enddo
  !$omp end parallel do

  !$omp parallel do private(j)
  do j = 0 , y_pts
    y(j) = -1.0 + j * dy
  enddo
  !$omp end parallel do

  ! check if darts are inside
  !$omp parallel do private(j)
  do i = 0 , x_pts
    do j = 0 , y_pts
      if ( (x(i)**2.0+y(j)**2.0) <= 1.0 ) then
        inside( i , j ) = .true.
      endif
    enddo
  enddo
  !$omp end parallel do

  ! count how many darts inside
  !$omp parallel do private(j) reduction(+:num_inside)
  do i = 0 , x_pts
    do j = 0 , y_pts
      if ( inside( i , j ) ) then
        num_inside = num_inside + 1
      endif
    enddo
  enddo
  !$omp end parallel do

  call cpu_time( end )
  !!!!! OPENMP !!!!!

  pi = 4.0 * ( real(num_inside) / real(x_pts * y_pts))

  write( * , * ) "pi           = " , pi
  write( * , * ) "time elapsed = ", (end-start)

end program openmp_pi
