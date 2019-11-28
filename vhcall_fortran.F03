!
!-------------------------------------------------------------------------------
MODULE vhcall_fortran
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
FUNCTION vhcall_invoke (symID, inPtr, in_len, outPtr, out_len) &
                       & BIND(C,NAME='vhcall_invoke')
USE, INTRINSIC :: ISO_C_BINDING
IMPLICIT NONE
    INTEGER (KIND=C_LONG)           :: vhcall_invoke
    INTEGER (KIND=C_INT64_T), VALUE :: symID
    TYPE (C_PTR),             VALUE :: inPtr     ! pointer to object of any type
    INTEGER (KIND=C_SIZE_T),  VALUE :: in_len
    TYPE (C_PTR),             VALUE :: outPtr    ! pointer to object of any type
    INTEGER (KIND=C_SIZE_T),  VALUE :: out_len
END FUNCTION vhcall_invoke

!=int vhcall_uninstall(vhcall_handle);
FUNCTION vhcall_uninstall (h) BIND(C,NAME='vhcall_uninstall')
USE, INTRINSIC :: ISO_C_BINDING
IMPLICIT NONE
    INTEGER (KIND=C_INT)                         :: vhcall_uninstall
    INTEGER (KIND=C_INT64_T), VALUE, INTENT(in)  :: h   !  vhcall_handle
END FUNCTION vhcall_uninstall
!
END INTERFACE

#ifndef VHCALLNOENHANCE
!-from file "vhcall.h"
!
ENUM, BIND(C) ! :: vhcall_args_class
    ENUMERATOR ::  VHCALL_CLASS_INT = 1
    ENUMERATOR ::  VHCALL_CLASS_DBL
    ENUMERATOR ::  VHCALL_CLASS_CDB
    ENUMERATOR ::  VHCALL_CLASS_PTR
    ENUMERATOR ::  VHCALL_CLASS_HDL
END ENUM ! vhcall_args_class
INTEGER, PARAMETER :: vhcall_args_class = KIND(VHCALL_CLASS_INT)
!---in interface: INTEGER(KIND=vhcall_args_class), VALUE :: set_operation
!
ENUM , BIND(C) ! :: vhcall_args_intent
    ENUMERATOR :: VHCALL_INTENT_IN = 1
    ENUMERATOR :: VHCALL_INTENT_INOUT
    ENUMERATOR :: VHCALL_INTENT_OUT
END ENUM !  vhcall_args_intent
INTEGER, PARAMETER :: vhcall_args_intent = KIND(VHCALL_INTENT_IN)
!
TYPE, BIND(C) :: vhcall_data
!   TYPE    (vhcall_args_class)            ::  cl
!   TYPE    (vhcall_args_intent)           ::  inout
    INTEGER(KIND=vhcall_args_class)        ::  argClass
    INTEGER(KIND=vhcall_args_intent)       ::  argIntent
    INTEGER (KIND=C_INT64_T), DIMENSION(2) ::  argValues
    INTEGER (KIND=C_SIZE_T)                ::  argSize
END TYPE vhcall_data
!
TYPE, BIND(C) ::  vhcall_args
        INTEGER (KIND=C_INT) :: num
        TYPE (vhcall_data)   :: argData
        TYPE (C_PTR)         :: next ! struct vhcall_args *next;
END TYPE vhcall_args

!-interfaces from file "libvhcall.h"
INTERFACE 

!=vhcall_args *vhcall_args_alloc(void);
FUNCTION vhcall_args_alloc (args)    BIND(C,NAME='vhcall_args_alloc')
USE, INTRINSIC :: ISO_C_BINDING
IMPLICIT NONE
TYPE (C_PTR)        :: vhcall_args_alloc                  ! TYPE(vhcall_args)
TYPE (C_PTR)        :: args                               ! TYPE(vhcall_args)  ?
END FUNCTION vhcall_args_alloc

!=int vhcall_args_set_i8(vhcall_args *, int, int8_t);
FUNCTION vhcall_args_set_i8 (args, num, val) BIND(C,NAME='vhcall_args_set_i8')
USE, INTRINSIC :: ISO_C_BINDING
IMPLICIT NONE
INTEGER (KIND=C_INT)           :: vhcall_args_set_i8
TYPE (C_PTR),            VALUE :: args                    ! TYPE (vhcall_args)
INTEGER (KIND=C_INT),    VALUE :: num
INTEGER (KIND=C_INT8_T), VALUE :: val
END FUNCTION vhcall_args_set_i8

!=int vhcall_args_set_i16(vhcall_args *, int, int16_t);
FUNCTION vhcall_args_set_i16 (args, num, val) BIND(C,NAME='vhcall_args_set_i16')
USE, INTRINSIC :: ISO_C_BINDING
IMPLICIT NONE
INTEGER (KIND=C_INT)            :: vhcall_args_set_i16
TYPE (C_PTR),             VALUE :: args
INTEGER (KIND=C_INT),     VALUE :: num                    ! TYPE (vhcall_args)
INTEGER (KIND=C_INT16_T), VALUE :: val
END FUNCTION vhcall_args_set_i16

!=int vhcall_args_set_i32(vhcall_args *, int, int32_t);
FUNCTION vhcall_args_set_i32 (args, num, val) BIND(C,NAME='vhcall_args_set_i32')
USE, INTRINSIC :: ISO_C_BINDING
IMPLICIT NONE
INTEGER (KIND=C_INT)            :: vhcall_args_set_i32
TYPE (C_PTR),             VALUE :: args                    ! TYPE (vhcall_args)
INTEGER (KIND=C_INT),     VALUE :: num
INTEGER (KIND=C_INT32_T), VALUE :: val
END FUNCTION vhcall_args_set_i32

!=int vhcall_args_set_i64(vhcall_args *, int, int64_t);
FUNCTION vhcall_args_set_i64 (args, num, val) BIND(C,NAME='vhcall_args_set_i64')
USE, INTRINSIC :: ISO_C_BINDING
IMPLICIT NONE
INTEGER (KIND=C_INT)            :: vhcall_args_set_i64
TYPE (C_PTR),             VALUE :: args                    ! TYPE (vhcall_args)
INTEGER (KIND=C_INT),     VALUE :: num
INTEGER (KIND=C_INT64_T), VALUE :: val
END FUNCTION vhcall_args_set_i64

!=int vhcall_args_set_float(vhcall_args *, int, float);
FUNCTION vhcall_args_set_float (args, num, val) &
                              & BIND(C,NAME='vhcall_args_set_float')
USE, INTRINSIC :: ISO_C_BINDING
IMPLICIT NONE
INTEGER (KIND=C_INT)         :: vhcall_args_set_float
TYPE (C_PTR),         VALUE  :: args                       ! TYPE (vhcall_args)
INTEGER (KIND=C_INT), VALUE  :: num
REAL (KIND=C_FLOAT),  VALUE  :: val
END FUNCTION vhcall_args_set_float


!=int vhcall_args_set_double(vhcall_args *, int, double);
FUNCTION vhcall_args_set_double (args, num, val) &
                               & BIND(C,NAME='vhcall_args_set_double')
USE, INTRINSIC :: ISO_C_BINDING
IMPLICIT NONE
INTEGER (KIND=C_INT)         :: vhcall_args_set_double
TYPE (C_PTR),         VALUE  :: args                       ! TYPE (vhcall_args)
INTEGER (KIND=C_INT), VALUE  :: num
REAL (KIND=C_DOUBLE), VALUE  :: val
END FUNCTION vhcall_args_set_double

!=int vhcall_args_set_complex_float(vhcall_args *, int, _Complex float);
FUNCTION vhcall_args_set_complex_float (args, num, val) &
                               & BIND(C,NAME='vhcall_args_set_complex_float')
USE, INTRINSIC :: ISO_C_BINDING
IMPLICIT NONE
INTEGER (KIND=C_INT)                    :: vhcall_args_set_complex_float
TYPE (C_PTR),                    VALUE  :: args             ! TYPE (vhcall_args)
INTEGER (KIND=C_INT),            VALUE  :: num
COMPLEX (KIND=C_FLOAT_COMPLEX),  VALUE  :: val
END FUNCTION vhcall_args_set_complex_float

!=int vhcall_args_set_complex_double(vhcall_args *, int, _Complex double);
FUNCTION vhcall_args_set_complex_double (args, num, val) &
                               & BIND(C,NAME='vhcall_args_set_complex_double')
USE, INTRINSIC :: ISO_C_BINDING
IMPLICIT NONE
INTEGER (KIND=C_INT)                   :: vhcall_args_set_complex_double
TYPE (C_PTR),                    VALUE :: args             ! TYPE (vhcall_args)
INTEGER (KIND=C_INT),            VALUE :: num
COMPLEX (KIND=C_DOUBLE_COMPLEX), VALUE :: val
END FUNCTION vhcall_args_set_complex_double

!=int vhcall_args_set_pointer(vhcall_args *, enum vhcall_args_intent,
!                             int, void *, size_t);
FUNCTION vhcall_args_set_pointer (args, argIntent, num, buffer, bufferLen) &
                                & BIND(C,NAME='vhcall_args_set_pointer')
USE, INTRINSIC :: ISO_C_BINDING
IMPORT :: vhcall_args_intent
IMPLICIT NONE
INTEGER (KIND=C_INT)                     :: vhcall_args_set_pointer
TYPE (C_PTR),                      VALUE :: args           ! TYPE (vhcall_args)
INTEGER (KIND=vhcall_args_intent), VALUE :: argIntent
INTEGER (KIND=C_INT),              VALUE :: num
TYPE (C_PTR),                      VALUE :: buffer         ! object of any kind
INTEGER (KIND=C_SIZE_T),           VALUE :: bufferLen
END FUNCTION vhcall_args_set_pointer

!=int vhcall_args_set_veoshandle(vhcall_args *, int);
FUNCTION vhcall_args_set_veoshandle (args, num) &
                                   & BIND(C,NAME='vhcall_args_set_veoshandle')
USE, INTRINSIC :: ISO_C_BINDING
IMPLICIT NONE
INTEGER (KIND=C_INT)                :: vhcall_args_set_veoshandle
TYPE (C_PTR),                 VALUE :: args                ! TYPE (vhcall_args)
INTEGER (KIND=C_INT),         VALUE :: num
END FUNCTION vhcall_args_set_veoshandle

!=int vhcall_invoke_with_args(int64_t, vhcall_args *, uint64_t*);
FUNCTION vhcall_invoke_with_args (symID, args, retval) &
                                & BIND(C,NAME='vhcall_invoke_with_args')
USE, INTRINSIC :: ISO_C_BINDING
IMPLICIT NONE
    INTEGER (KIND=C_INT)            :: vhcall_invoke_with_args
    INTEGER (KIND=C_INT64_T), VALUE :: symID
    TYPE (C_PTR),             VALUE :: args                ! TYPE (vhcall_args)
    TYPE (C_PTR),             VALUE :: retval              ! C_INT64_T
END FUNCTION vhcall_invoke_with_args

!=void vhcall_args_clear(vhcall_args *);
SUBROUTINE vhcall_args_clear (args) BIND(C,NAME='vhcall_args_clear')
USE, INTRINSIC :: ISO_C_BINDING
IMPLICIT NONE
TYPE (C_PTR), VALUE :: args                                ! TYPE (vhcall_args)
END SUBROUTINE vhcall_args_clear

!=void vhcall_args_free(vhcall_args *);
SUBROUTINE vhcall_args_free (args) BIND(C,NAME='vhcall_args_free')
USE, INTRINSIC :: ISO_C_BINDING
IMPLICIT NONE
TYPE (C_PTR), VALUE :: args                                ! TYPE (vhcall_args)
END SUBROUTINE vhcall_args_free

END INTERFACE 


!-generic FORTRAN interface
INTERFACE vhcall_args_set
   PROCEDURE  vhcall_args_set_i8           , vhcall_args_set_i16, &
            & vhcall_args_set_i32          , vhcall_args_set_i64, &
            & vhcall_args_set_float        , vhcall_args_set_double, &
            & vhcall_args_set_complex_float, vhcall_args_set_complex_double, &
            & vhcall_args_set_pointer      , vhcall_args_set_veoshandle
END INTERFACE vhcall_args_set
!
#endif
!-------------------------------------------------------------------------------
END MODULE vhcall_fortran

