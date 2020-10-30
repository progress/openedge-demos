DEFINE NEW GLOBAL SHARED STREAM WebStream.

DEFINE VARIABLE cSrcDir         AS CHARACTER    NO-UNDO INITIAL ".".
DEFINE VARIABLE cTargetDir      AS CHARACTER    NO-UNDO INITIAL ".".
DEFINE VARIABLE cFileName       AS CHARACTER    NO-UNDO.
DEFINE VARIABLE cParam          AS CHARACTER    NO-UNDO.
DEFINE VARIABLE pos             AS INTEGER      NO-UNDO.
DEFINE VARIABLE i               AS INTEGER      NO-UNDO.

DO i = 1 TO NUM-ENTRIES(SESSION:PARAMETER):
    cParam = ENTRY(i, SESSION:PARAMETER).

    CASE ENTRY(1, cParam, "="):
    WHEN "src" THEN DO:
        cSrcDir = ENTRY(2, cParam, "=").
        IF NOT cSrcDir BEGINS "/" THEN DO:
           FILE-INFO:FILE-NAME = ".".
           cSrcDir = FILE-INFO:FULL-PATHNAME + "/" + cSrcDir.
        END.
    END.    
    WHEN "target" THEN DO:
        cTargetDir = ENTRY(2, cParam, "=").
        IF NOT cTargetDir BEGINS "/" THEN DO:
           FILE-INFO:FILE-NAME = ".".
           cTargetDir = FILE-INFO:FULL-PATHNAME + "/" + cTargetDir.
        END.
        ELSE DO:
           cTargetDir = ENTRY(2, cParam, "=").
        END.
    END.
    END CASE.
END.

// MESSAGE "Src Directory: " cSrcDir SKIP.
// MESSAGE "Target Directory: " cTargetDir SKIP. 

INPUT FROM OS-DIR(cSrcDir).
REPEAT:
    IMPORT cFileName.

    FILE-INFO:FILE-NAME = cSrcDir + "/" + cFileName.
    pos = R-INDEX(cFileName, ".").
  
    IF INDEX(FILE-INFO:FILE-TYPE, "F") > 0 AND pos > 0 THEN DO:
        CASE SUBSTRING(cFileName, pos):
        WHEN ".p" OR WHEN ".w" THEN DO:
            COMPILE VALUE(FILE-INFO:FULL-PATHNAME) SAVE INTO VALUE(cTargetDir).
        END.
        WHEN ".html" THEN DO:
          RUN CompileSpeedScript(FILE-INFO:FULL-PATHNAME).
        END.
        END CASE.
  END.    
END.

PROCEDURE CompileSpeedScript:
  DEFINE INPUT PARAMETER cFileName  AS CHARACTER    NO-UNDO.
  
  DEFINE VARIABLE speedfile     AS CHARACTER    NO-UNDO.
  DEFINE VARIABLE wsoptions     AS CHARACTER    NO-UNDO.

  ASSIGN speedfile = ENTRY(1, cFileName, '.') + '.w'
         wsoptions = "".

  RUN tty/webutil/e4gl-gen.r 
      (INPUT cFileName,
       INPUT-OUTPUT speedfile,
       INPUT-OUTPUT wsoptions).

  COMPILE VALUE(ENTRY(1, speedfile)) SAVE INTO VALUE(cTargetDir).
  OS-DELETE VALUE(ENTRY(1, speedfile)).
END.

QUIT.
