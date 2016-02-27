!> Fortran module containing the definition of all types of mesh are defined
!! @author J. Rafael Rodríguez Galván
!! @author Estefanía Alonso Alonso

module mesh1d_module
  use nrtypes
  implicit none
  private
  public :: mesh1d, mesh1d_init, mesh1d_ncells, mesh1d_nvertices, &
       mesh1d_get_vertices, mesh1d_get_coordinates

  !> Data type for 1-d meshes
  type mesh1d
     !> @brief Array which stores the indexes of vertices, for each cell
     !!
     !! Each column, j, stores the global indices of the vertices
     !! contained in the cell j.  I.e. vertices(i,j) = Global index of
     !! the i-th vertex of cell j
     integer(long), allocatable :: vertices(:,:)

     !> @brief Array which stores the coordinates of each vertex
     !!
     !! Each column, j, stores the coordinates of the vertex whose global
     !! index is equal to j
     real(dp), allocatable :: coordinates(:,:)

    integer(long) :: ncells !< Number of cells (subintervals)
    integer(long) :: nvertices !< Number of vertices in the mesh

  end type mesh1d

contains

  !> Builds a 1D mesh in a given domain (in an interval)
  subroutine mesh1d_init(Th, x1, x2, ncells)
    type(mesh1d), intent(out) :: Th     !< Mesh to be built
    real(dp), intent(in) :: x1          !< Left extreme of the domain (interval [x1,x2])
    real(dp), intent(in) :: x2          !< Right extreme of the domain (interval [x1,x2])
    integer(long), intent(in) :: ncells !< Number of cells (subintervals)

    integer(long), parameter :: dimension_of_affine_space = 1
    integer(long), parameter :: nvertices_in_each_element = 2 ! Number of vertices / elements
    integer(long) :: nvertices, i
    real(dp) :: h

    ! Define vertices for each cell
    Th%ncells = ncells
    allocate( Th%vertices(nvertices_in_each_element, ncells) )
    do i=1, ncells
       Th%vertices(:,i) = [i,i+1]  ! Define vertices in cell i
    end do

    ! Define coordinates (1d) for each vertex
    nvertices = ncells+1 ! Total number of vertices in this mesh
    Th%nvertices = nvertices
    h = (x2-x1)/ncells
    allocate( Th%coordinates(dimension_of_affine_space, nvertices) )
    Th%coordinates(dimension_of_affine_space,:) = [ (x1 + (i-1)*h,  i=1,nvertices) ]
  end subroutine mesh1d_init

  !> Return the number of cells in Th
  integer(long) function mesh1d_ncells(Th)
    type(mesh1d), intent(in) :: Th !< 1D mesh
    mesh1d_ncells = Th%ncells
  end function mesh1d_ncells

  !> Return the number of vertices in Th
  integer(long) function mesh1d_nvertices(Th)
    type(mesh1d), intent(in) :: Th !< 1D mesh
    mesh1d_nvertices = Th%nvertices !size(Th%coordinates, 2)
  end function mesh1d_nvertices

  !> Return a copy of the vertices contained in the i-th cell of Th
  function mesh1d_get_vertices(Th,i)
    type(mesh1d), intent(in) :: Th !< 1D mesh
    integer(long), intent(in) :: i
    integer(long), parameter :: nvertices_in_each_element = 2 ! Number of vertices / elements
    integer(long), dimension(nvertices_in_each_element) :: mesh1d_get_vertices
    mesh1d_get_vertices = Th%vertices(:,i)
  end function mesh1d_get_vertices

  !> Return a copy of the coordinates of the i-th vertex of Th
  function mesh1d_get_coordinates(Th,i)
    type(mesh1d), intent(in) :: Th !< 1D mesh
    integer(long), intent(in) :: i
    integer(long), parameter :: dimension_of_affine_space = 1
    real(dp), dimension(dimension_of_affine_space) :: mesh1d_get_coordinates
    mesh1d_get_coordinates = Th%coordinates(:,i)
  end function mesh1d_get_coordinates

end module mesh1d_module
