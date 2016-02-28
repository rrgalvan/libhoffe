module mesh_test

  use fruit ! Fortran Unit Test Framework
  use nrtypes
  implicit none

contains

  !!,----------------------------------------------------------------
  !!| Simple test to assert that mesh1D class is working well
  !!`----------------------------------------------------------------
  subroutine test_mesh_1d
    call test_mesh1d_build
  end subroutine test_mesh_1d

  !!,----------------------------------------------------------------------
  !!| Test of mesh construction
  !!`----------------------------------------------------------------------
  subroutine test_mesh1d_build
    use mesh
    integer(long) :: i, ncells, nvertices
    type(mesh1d) :: Th

    Th = mesh1d( x1=0.0_dp, x2=1.0_dp, ncells=10 )

    ncells = Th%ncells()
    call assert_equals(ncells, 10)

    nvertices = Th%nvertices()
    call assert_equals(nvertices, 11)

    ! Test access to vertices of each cell
    do i=1, ncells
       associate( v => Th%vertices_of_cell(i) )
         call assert_equals(v(1), i)
         call assert_equals(v(2), i+1)
       end associate
    end do

    ! Test access to all coordinates
    do i=1, nvertices
       associate(&
         coord => Th%coordinates_of_vertex(i),&
         y => 0.0_dp + (i-1)*1.0_dp/10 )
         call assert_equals(coord(1), y, delta=0.1e-14_dp)
       end associate
    end do

  end subroutine test_mesh1d_build

end module mesh_test
