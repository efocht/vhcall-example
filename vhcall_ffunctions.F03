!
!-------------------------------------------------------------------------------
MODULE vhcall_ffunctions
!-------------------------------------------------------------------------------
!-fortran2003 interfaces to the vhcall_cfunctions
!-------------------------------------------------------------------------------
USE, INTRINSIC :: ISO_FORTRAN_ENV
USE, INTRINSIC :: ISO_C_BINDING
IMPLICIT NONE
!-------------------------------------------------------------------------------
!=typedef uint64_t vhcall_handle;
INTERFACE 
  !=vhcall_handle vhcall_install(const char *);
  FUNCTION vhcall_install (libName) BIND(C,NAME='vhcall_install')
      USE, INTRINSIC :: ISO_C_BINDING
      IMPLICIT NONE
      INTEGER (KIND=C_INT64_T)                          :: vhcall_install
      CHARACTER (KIND=C_CHAR), DIMENSION(*), INTENT(in) :: libName
  END FUNCTION vhcall_install

  !=int64_t vhcall_find(vhcall_handle, const char *);
  FUNCTION vhcall_find (h, symbolName) BIND(C,NAME='vhcall_find')
      USE, INTRINSIC :: ISO_C_BINDING
      IMPLICIT NONE
      INTEGER (KIND=C_INT64_T)                          :: vhcall_find
      INTEGER (KIND=C_INT64_T), VALUE,       INTENT(in) :: h   ! vhcall_handle
      CHARACTER (KIND=C_CHAR), DIMENSION(*), INTENT(in) :: symbolName
  END FUNCTION vhcall_find

  !=long vhcall_invoke(int64_t, const void *, size_t, void *, size_t);
  FUNCTION vhcall_invoke (symid, inPtr, in_len, outPtr, out_len) &
                       & BIND(C,NAME='vhcall_invoke')
      USE, INTRINSIC :: ISO_C_BINDING
      IMPLICIT NONE
      INTEGER (KIND=C_LONG)            :: vhcall_invoke
      INTEGER (KIND=C_INT64_T), VALUE  :: symid
      TYPE (C_PTR), VALUE              :: inPtr
      INTEGER (KIND=C_SIZE_T),  VALUE  :: in_len
      TYPE (C_PTR), VALUE              :: outPtr
      INTEGER (KIND=C_SIZE_T),  VALUE  :: out_len
  END FUNCTION vhcall_invoke

  !=int vhcall_uninstall(vhcall_handle);
  FUNCTION vhcall_uninstall (h) BIND(C,NAME='vhcall_uninstall')
      USE, INTRINSIC :: ISO_C_BINDING
      IMPLICIT NONE
      INTEGER (KIND=C_INT)                         :: vhcall_uninstall
      INTEGER (KIND=C_INT64_T), VALUE, INTENT(in)  :: h   !  vhcall_handle
  END FUNCTION vhcall_uninstall

END INTERFACE

!===============================================================================
END MODULE vhcall_ffunctions

