!> Fortran module containing the definition of all types of mesh are defined
!! @author J. Rafael Rodríguez Galván

module finite_element
  use finite_element_1d_module

  interface init
     module procedure finite_element_1d_init
  end interface init

end module finite_element
