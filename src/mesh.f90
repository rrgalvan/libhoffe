!> Fortran module containing the definition of all types of mesh are defined
!! @author Estefanía Alonso Alonso
!! @author J. Rafael Rodríguez Galván

module mesh
  use nrtypes
  implicit none
  private ! Content of module is private, excepting explicitly public stuff
  public :: mesh1d

  !> Data type for 1-d meshes
  type mesh1d
     private

     !> @brief Array which stores the indexes of vertices, for each cell
     !!
     !! Each column, j, stores the global indices of the vertices
     !! contained in the cell j.  I.e. vertices(i,j) = Global index of
     !! the i-th vertex of cell j
     integer(long), allocatable :: vertices_(:,:)

     !> @brief Array which stores the coordinates of each vertex
     !!
     !! Each column, j, stores the coordinates of the vertex whose global
     !! index is equal to j
     real(dp), allocatable :: coordinates_(:,:)

    integer(long) :: ncells_ !< Number of cells (subintervals)
    integer(long) :: nvertices_ !< Number of vertices in the mesh

  contains ! Public by default...
    procedure, pass(this) :: ncells
    procedure, pass(this) :: nvertices
    procedure, pass(this) :: vertices_of_cell
    procedure, pass(this) :: coordinates_of_vertex
  end type mesh1d

  interface mesh1d ! Map generic to actual name
     procedure mesh1d_constructor
  end interface mesh1d

contains

  !> Constructor for a 1D mesh in an given interval
  function mesh1d_constructor(x1, x2, ncells) result(Th)
    type(mesh1d) :: Th                  !< Mesh to be built
    real(dp), intent(in) :: x1          !< Left extreme of the domain (interval [x1,x2])
    real(dp), intent(in) :: x2          !< Right extreme of the domain (interval [x1,x2])
    integer(long), intent(in) :: ncells !< Number of cells (subintervals)

    integer(long), parameter :: dimension_of_affine_space = 1
    integer(long), parameter :: nvertices_in_each_element = 2 ! Number of vertices / elements
    integer(long) :: nvertices, i
    real(dp) :: h

    ! Define vertices for each cell
    Th%ncells_ = ncells
    allocate( Th%vertices_(nvertices_in_each_element, ncells) )
    do i=1, ncells
       Th%vertices_(:,i) = [i,i+1]  ! Define vertices in cell i
    end do

    ! Define coordinates (1d) for each vertex
    nvertices = ncells+1 ! Total number of vertices in this mesh
    Th%nvertices_ = nvertices
    h = (x2-x1)/ncells
    allocate( Th%coordinates_(dimension_of_affine_space, nvertices) )
    Th%coordinates_(dimension_of_affine_space,:) = [ (x1 + (i-1)*h,  i=1,nvertices) ]
  end function mesh1d_constructor

  !> Return the number of cells in Th
  function ncells(this) result(nb_of_cells)
    class(mesh1d), intent(in) :: this !< 1D mesh
    integer(long) :: nb_of_cells
    nb_of_cells = this%ncells_
  end function ncells

  !> Return the number of vertices in Th
  function nvertices(this) result(nb_of_vertices)
    class(mesh1d), intent(in) :: this !< 1D mesh
    integer(long) :: nb_of_vertices
    nb_of_vertices = this%nvertices_
  end function nvertices

  !> Return a copy of the vertices contained in the i-th cell of Th
  function vertices_of_cell(this, icell) result(vertices)
    class(mesh1d), intent(in) :: this !< 1D mesh
    integer(long), intent(in) :: icell
    integer(long), parameter :: nvertices_in_each_element = 2 ! Number of vertices / elements
    integer(long), dimension(nvertices_in_each_element) :: vertices
    vertices = this%vertices_(:, icell)
  end function vertices_of_cell

  !> Return a copy of the coordinates of the i-th vertex of Th
  function coordinates_of_vertex(this, ivertex) result(coordinates)
    class(mesh1d), intent(in) :: this !< 1D mesh
    integer(long), intent(in) :: ivertex
    integer(long), parameter :: dimension_of_affine_space = 1
    real(dp), dimension(dimension_of_affine_space) :: coordinates
    coordinates = this%coordinates_(:,ivertex)
  end function coordinates_of_vertex

end module mesh
