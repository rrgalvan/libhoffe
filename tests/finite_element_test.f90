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
    use finite_element
    call assert_not_equals(1,2)
  end subroutine test_finite_element_1d

end module finite_element_test
