MODULE vhve_data
  USE, INTRINSIC :: ISO_FORTRAN_ENV
  USE, INTRINSIC :: ISO_C_BINDING
  IMPLICIT NONE
  !
  INTERFACE
     ! int ve_send_data(veos_handle *, uint64_t, size_t, void *);
     FUNCTION ve_send_data(veos_handle, dst, size, src) BIND(C, NAME='ve_send_data')
       USE, INTRINSIC :: ISO_C_BINDING
       IMPLICIT NONE
       INTEGER (KIND=C_INT)             :: ve_send_data
       INTEGER (KIND=C_INT64_T), VALUE  :: veos_handle
       INTEGER (KIND=C_UINT64_T), VALUE :: dst
       INTEGER (KIND=C_SIZE_T), VALUE   :: size
       !
       ! in fortran set the following argument like
       ! src = C_LOC(array)
       TYPE (C_PTR), VALUE              :: src
     END FUNCTION ve_send_data
     !
     ! int ve_recv_data(veos_handle *h, uint64_t src, size_t size, void *dst);
     FUNCTION ve_recv_data(veos_handle, src, size, dst) BIND(C, NAME='ve_recv_data')
       USE, INTRINSIC :: ISO_C_BINDING
       IMPLICIT NONE
       INTEGER (KIND=C_INT)             :: ve_recv_data
       INTEGER (KIND=C_INT64_T), VALUE  :: veos_handle
       INTEGER (KIND=C_UINT64_T), VALUE :: src
       INTEGER (KIND=C_SIZE_T), VALUE   :: size
       !
       ! in fortran set the following argument like
       ! dst = C_LOC(array)
       TYPE (C_PTR), VALUE              :: dst
     END FUNCTION ve_recv_data

  END INTERFACE

END MODULE vhve_data
