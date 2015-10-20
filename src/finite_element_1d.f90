!> Fortran module containing the definition of all types of mesh are defined
!! @author J. Rafael Rodríguez Galván

module finite_element_1d_module
  use nrtypes
  use mesh1d_module
  implicit none
  private
  public :: finite_element_1d, finite_element_1d_init

  !> Data type for 1-d affine transformations, $F(t)=a\cdot t + b$,
  !! where t is defined in the interval [0,1]
  type affine_map_0_1
     real(dp) :: a !< multiplicative coefficient
     real(dp) :: b !< translation coefficient
     real(dp) :: det_jacobian !< determinant of the jacobian, |F'(t)|=|a|
  end type affine_map_0_1

  !> Data type for 1-d finite elements
  type finite_element_1d
     !>@brief TODO
     type(mesh1d) :: mesh !< TODO
     integer(long) :: idx_cell !< TODO
     type(affine_map_0_1) :: affine_map !< TODO

  end type finite_element_1d

contains

  !> Init the data a finite element (from a cell in a mesh) in order to make it usable
  subroutine finite_element_1d_init(fe, mesh, idx_cell)
    type(finite_element_1d), intent(out) :: fe !< finite element to be defined
    type(mesh1d), intent(in) :: mesh !< 1d-mesh containing the cell which will be linked to the element
    integer(long), intent(in) :: idx_cell !< index of the linked cell

    fe%mesh = mesh
    fe%idx_cell = idx_cell
    call affine_map_0_1_init(fe%affine_map, mesh, idx_cell)
  end subroutine finite_element_1d_init

  !> Init the data of affine map in order to make it transform the reference
  !! interval [0,1] into the i-th cell of mesh.
  subroutine affine_map_0_1_init(map, mesh, idx_cell)
    type(affine_map_0_1), intent(out) :: map !< affine map to be defined
    type(mesh1d), intent(in) :: mesh !< 1d-mesh containing th
    integer(long), intent(in) :: idx_cell !< index of cell which must be mapped

    ! Associate to v1 and v2 the global indices of the two vertices of the cell idx_cell
    associate( v1 => mesh%vertices(1,idx_cell), v2 => mesh%vertices(2,idx_cell) )
      ! Associate to x1 and x2 the x-coordinates of that vertices
      associate( x1 => mesh%coordinates(1,v1), x2 => mesh%coordinates(1,v2) )
        map%a = x2-x1
        map%b = x1
        map%det_jacobian = map%a
      end associate
    end associate
  end subroutine affine_map_0_1_init

end module finite_element_1d_module
