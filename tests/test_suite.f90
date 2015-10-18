! Copyright (c) 2005-2010, 2012-2013, Andrew Hang Chen and contributors,
! All rights reserved.
! Licensed under the 3-clause BSD license.

program fruit_driver
  use fruit

  ! Load modules to be tested
  use mesh_test
  use finite_element_test

  ! Run tests
  call init_fruit

  call test_mesh_1d_2d
  call test_finite_element_1d_2d

  ! Finalize
  call fruit_summary
  call fruit_finalize
  if (fruit_if_case_failed()) then
     stop 1
  else
     stop 0
  endif

end program fruit_driver
