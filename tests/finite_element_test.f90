module finite_element_test

  use fruit ! Fortran Unit Test Framework
  use nrtypes
  implicit none

contains

  !!,----------------------------------
  !!| Simple test for 1d/2d fem objects
  !!`----------------------------------
  subroutine test_finite_element_1d_2d
    call test_finite_element_1d
  end subroutine test_finite_element_1d_2d

  !!,-----------------------
  !!| Test of fem1d building1
  !!`-----------------------
  subroutine test_finite_element_1d
    use mesh
    use finite_element
    type(mesh1d) :: Th
    type(finite_element_1d) :: fe

    ! Partition of [0,6] with 3 subintervals (x_i = 0.0, 2.0, 4.0, 6.0)
    call init(Th, x1=0.0_dp, x2=6.0_dp, ncells=3)
    ! Select the third subinterval and use it to initialize the finite element fe
    call init(fe, mesh=Th, idx_cell=3)

    ! Test that data is saved into fe
    call assert_equals(fe%idx_cell, 3)

    ! Test affinte map matrix, a, and translation, b
    call assert_equals(fe%affine_map%a, 2.0_dp, delta=1e-16_dp)
    call assert_equals(fe%affine_map%b, 4.0_dp, delta=1e-16_dp)
    ! Test the determinant of the jacobian of the affine map
    call assert_equals(fe%affine_map%det_jacobian, 2.0_dp, delta=1e-16_dp)

  end subroutine test_finite_element_1d

end module finite_element_test
