CCC=======================================================================
CCC   
CCC   (FWJ 03-APR-2012 | RCW 13-APR-2019)
CCC   THIS PROGRAM CONVERTS 3D OPERA FIELD DATA FOR INPUT TO G4BEAMLINE
CCC   SPECIAL THANKS TO F.W. JONES AT TRIUMF FOR PROVIDING HIS BASE CODE
CCC
CCC   PARAMETERS OF LINE 37/38 MUST BE CHANGED IN ACCORDANCE TO OPERA DATA
CCC   TABLE OUTPUT (I.E. X0, Y0, Z0, NX, NY, NZ, DX, DY, DZ).
CCC
CCC=======================================================================
      IMPLICIT NONE

      INTEGER NX,NY,NZ,I1,I2
      REAL X,Y,Z
      REAL*8 BX,BY,BZ

      CHARACTER*80 CBUFF
      CHARACTER*60 R8BUFF
      INTEGER I,LINE
      INTEGER LSIG

 1000 FORMAT(A)
 2000 FORMAT(3E20.12)
 3000 FORMAT(6E16.8)

      LINE=1
      READ(1,*,ERR=98,END=99)NZ,NX,NY,I2
      WRITE(6,*)'NZ,NX,NY = ',NZ,NX,NY

      DO I=1,7
         READ(1,1000,ERR=98,END=99)CBUFF
         WRITE(6,*)CBUFF(1:LSIG(CBUFF))
      ENDDO

      WRITE(2,1000)'#BLFieldMap'
      WRITE(2,1000)'param gradient=0 normB=1'
      WRITE(2,1000)'grid X0=-200 Y0=-100 Z0=-350 nX=81 nY=41 nZ=141'//
     &     ' dX=5 dY=5 dZ=5'
      WRITE(2,1000)'data'

      LINE=0

C For ELBD:MB0 dipole oriented at 45 degrees
   10 READ(1,*,ERR=98,END=99)X,Y,Z,BX,BY,BZ
C changed line above (39) from Z,Y,X,BZ,BY,BX to X,Y,Z,BX,BY,BZ
C  10 READ(1,*,ERR=98,END=99)X,Z,Y,BX,BZ,BY
      LINE=LINE+1
C      WRITE(R8BUFF,2000)BX,BY,BZ
      WRITE(2,3000)X,Y,Z,BX,BY,BZ
C Mirror symmetry to reduce Opera map file size
C      IF(Y.NE.0.)THEN
C         WRITE(R8BUFF,2000)BX,BY,-BZ
C         WRITE(2,*)X,-Y,Z,R8BUFF
C      ENDIF
      GO TO 10

   98 WRITE(6,*)'Error reading file at line',LINE
      STOP

   99 WRITE(6,*)'End of file'
      WRITE(6,*)LINE,' data lines processed'
      STOP
      END


      FUNCTION LSIG(STRING)
C======================================================================C
C  Returns significant length of a character string.
C  All characters are significant except blanks and nulls.
C======================================================================C
      IMPLICIT NONE
      INTEGER LSIG

      CHARACTER*(*) STRING
      CHARACTER*1 NULL
C#ifdef g77
C      PARAMETER(NULL=0)
C#else
      PARAMETER(NULL=CHAR(0))
C#endif

      INTEGER I

      DO I=LEN(STRING),1,-1
        LSIG=I
        IF(STRING(I:I).NE.' '.AND.STRING(I:I).NE.NULL)RETURN
      ENDDO
      LSIG=0
      RETURN
      END
