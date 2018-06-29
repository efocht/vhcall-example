!
!-------------------------------------------------------------------------------
PROGRAM vhcall_ftest
!-------------------------------------------------------------------------------
USE, INTRINSIC :: ISO_FORTRAN_ENV
USE, INTRINSIC :: ISO_C_BINDING
USE :: vhcall_ffunctions
IMPLICIT NONE
CHARACTER (KIND=C_CHAR,LEN=128) :: mySoLib=' '
CHARACTER (KIND=C_CHAR,LEN=128) :: symbol1=' '
CHARACTER (KIND=C_CHAR,LEN=128) :: symbol2=' '
INTEGER (KIND=C_INT64_T) :: handle=-1
INTEGER (KIND=C_INT64_T) :: symID1=-1
INTEGER (KIND=C_INT64_T) :: symID2=-1
INTEGER (KIND=C_LONG)    :: rCode
INTEGER (KIND=C_INT)     :: iRet
INTEGER (KIND=INT32), DIMENSION(:), ALLOCATABLE, TARGET :: iArray
TYPE (C_PTR) :: inPtr=C_NULL_PTR, outPtr=C_NULL_PTR
INTEGER (KIND=C_SIZE_T) :: in_len, out_len
INTEGER :: k, n

!
!->
    mySoLib='vh/libftnio_vh.so'
    handle = vhcall_install (TRIM(mySoLib))
    PRINT *, 'vhcall_install:'//TRIM(mySoLib),handle

    symbol1  = 'cwrite_vh'
    symID1   = vhcall_find (handle,TRIM(symbol1))
    PRINT *, 'vhcall_find:'//TRIM(symbol1),symID1
    symbol2  = 'ftnwrite_vh_'
    symID2   = vhcall_find (handle, TRIM(symbol2))
    PRINT *, 'vhcall_find:'//TRIM(symbol2),symID2

    n=16
    ALLOCATE (iArray(n))
    iArray = [ (k,k=1,n) ]

    in_len = SIZE(iArray)*STORAGE_SIZE(iArray)/8
    inPtr  = C_LOC(iArray)
    
    out_len=0
    outPtr = C_NULL_PTR

    PRINT *, 'before vhcall_invoke (C): iArray=', iArray
    PRINT *, 'before vhcall_invoke (C): in_len=', in_len

    rcode = vhcall_invoke (symID1, inPtr, in_len, outPtr, out_len)

    PRINT *, 'after vhcall_invoke:', rcode

    PRINT *, 'before vhcall_invoke (ftn): iArray=', iArray
    PRINT *, 'before vhcall_invoke (ftn): in_len=', in_len

    rcode = vhcall_invoke (symID2, inPtr, in_len, outPtr, out_len)

    PRINT *, 'after vhcall_invoke:', rcode


    iRet = vhcall_uninstall (handle)
    PRINT *, 'after vhcall_uninstall:', iRet


END PROGRAM vhcall_ftest
