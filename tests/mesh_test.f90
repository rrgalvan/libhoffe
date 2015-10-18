module mesh_test

  use fruit ! Fortran Unit Test Framework
  use nrtypes
  implicit none

contains

  !!,----------------------------------------------------------------
  !!| Simple test to show if 1D/2D meshes (mesh1d and mesh2d objects)
  !!| are working
  !!`----------------------------------------------------------------
  subroutine test_mesh_1d_2d
    call test_mesh1d_build
    call test_mesh1d_init
    call test_mesh2d_init_from_file
  end subroutine test_mesh_1d_2d

  !!,----------------------------------------------------------------------
  !!| Test of (1) manual building of mesh1d (2) functions nvertices, ncells
  !!`----------------------------------------------------------------------
  subroutine test_mesh1d_build
    use mesh

    ! Declaration of variables

    integer(long) i
    integer(long), parameter :: nc=3 ! Number of cells
    integer(long), parameter :: nv=4 ! Number of vertices
    real(dp), parameter :: a = 0.0, b = 1.0 ! Domain [a,b]
    real(dp), parameter :: h = (b-a)/nc

    type(mesh1d) :: Th ! Build new mesh

    ! Define vertices for each cell
    Th%ncells=nc
    allocate( Th%vertices(2,nc) )
    Th%vertices(:,1) = [1,2] ! Vertices in cell 1
    Th%vertices(:,2) = [2,3] ! Vertices in cell 2
    Th%vertices(:,3) = [3,4] ! Vertices in cell 3

    ! Define coordinates (1d) for each vertex
    Th%nvertices=nv
    allocate( Th%coordinates(1,nv) )
    Th%coordinates(1,:) = [ (a + (i-1)*h,  i=1, nv) ]

    call assert_equals(ncells(Th), nc)
    call assert_equals(nvertices(Th), nv)
  end subroutine test_mesh1d_build

  !!,---------------------------------------------------
  !!| Test functions init, get_vertices, get_coordinates
  !!`---------------------------------------------------
  subroutine test_mesh1d_init
    use mesh
    type(mesh1d) Th
    integer(long) :: i
    real(dp) :: expected_coordinates(1)

    call init(Th, x1=0.0_dp, x2=1.0_dp, ncells=10)

    ! Test access to vertices of each cell
    do i=1, 10
       associate ( v => get_vertices(Th,i),  w => [i, i+1] )
         call assert_equals(maxval(v-w), 0)
       end associate
    end do

    ! Test access to a single coordinate
    expected_coordinates = [0_dp]
    call assert_equals(get_coordinates(Th,1), expected_coordinates, n=1, delta=0.1_dp)

    ! Test access to all coordinates
    associate( x => Th%coordinates(1,:), &
         y => [(0.0_dp + i*1.0_dp/10, i=0,10)] )
      call assert_equals(x, y, n=11, delta=0.1e-14_dp)
    end associate
  end subroutine test_mesh1d_init

  !!,---------------------------------------------------------------
  !!| Test of building of triangle_mesh2d which is stored in a file.
  !!|
  !!| That file, which was created using FreeFem++ (in .msh format),
  !!| stores a squared mesh which is composed of 9 vertices and 8
  !!| triangles in the unit square.
  !!`---------------------------------------------------------------
  subroutine test_mesh2d_init_from_file
    use mesh, only : triangle_mesh2d, init, ncells, nvertices
    character (len=*), parameter :: file_name = "squared-mesh-2x2.msh"
    integer(long), parameter, dimension(24) :: expected_vertices &
         = [1, 2, 5, 1, 5, 4, 2, 3, 6, 2, 6, 5, 4, 5, 8, 4, 8, 7, 5, 6, 9, 5, 9, 8]
    real(dp), parameter, dimension(18) :: expected_coordinates &
         = [ 0.0_dp, 0.0_dp, 0.5_dp, 0.0_dp, 1.0_dp, 0.0_dp, &
         0.0_dp, 0.5_dp, 0.5_dp, 0.5_dp, 1.0_dp, 0.5_dp,&
         0.0_dp, 1.0_dp, 0.5_dp, 1.0_dp, 1.0_dp, 1.0_dp ]

    type(triangle_mesh2d) :: Th ! Build new mesh
    call init(Th, file_name)

    call assert_equals(nvertices(Th), 9)
    call assert_equals(ncells(Th), 8)
    associate(vertices => reshape(Th%vertices, [24]))
      call assert_equals( maxval(abs(vertices-expected_vertices)), 0)
    end associate
    associate(coords => reshape(Th%coordinates, [18]))
      call assert_true( maxval(abs(coords-expected_coordinates)) .lt. 1.0e-16_dp )
    end associate

  end subroutine test_mesh2d_init_from_file

end module mesh_test
