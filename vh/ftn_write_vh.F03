!===============================================================================
FUNCTION ftnwrite_vh (symID, inPtr, in_len, outPtr, out_len)
USE, INTRINSIC :: ISO_FORTRAN_ENV
USE, INTRINSIC :: ISO_C_BINDING
IMPLICIT NONE
    INTEGER (KIND=C_LONG)                        :: ftnwrite_vh
    INTEGER (KIND=C_INT64_T), VALUE, INTENT(in)  :: symID
    TYPE (C_PTR), VALUE,             INTENT(in)  :: inPtr
    INTEGER (KIND=C_SIZE_T),  VALUE, INTENT(in)  :: in_len
    TYPE (C_PTR), VALUE,             INTENT(in)  :: outPtr
    INTEGER (KIND=C_SIZE_T),  VALUE, INTENT(in)  :: out_len
!-local
    CHARACTER (LEN=*), PARAMETER :: outFile='ftnwrite_vh.txt'
    INTEGER :: nLen
    INTEGER (KIND=INT32), DIMENSION(:), POINTER  :: ftnPtr
!->
    IF ( C_ASSOCIATED(inPtr) .AND. in_len > 0 ) THEN
       nLen=in_len*8/STORAGE_SIZE(1_INT32)
       CALL C_F_POINTER (inPtr, ftnPtr, SHAPE=[nLen])
PRINT *, 'in ftnwrite_vh: in_len=', in_len
PRINT *, 'in ftnwrite_vh: nLen=', nLen
PRINT *, 'in ftnwrite_vh:', ftnPtr(:)
!      OPEN (99,FILE=outfile,FORM='formatted')
!      WRITE (99,*) ftnPtr
!      CLOSE(99)
    ENDIF
    RETURN
END FUNCTION ftnwrite_vh
!
