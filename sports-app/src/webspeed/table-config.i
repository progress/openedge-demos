&GLOBAL-DEFINE EntityName "{&TableName}"

CREATE WIDGET-POOL.

DEFINE TEMP-TABLE ttField NO-UNDO
    FIELD ttFieldName     AS CHARACTER. 

DEFINE VARIABLE oJsonObject AS JsonObject NO-UNDO.
DEFINE VARIABLE array       AS JsonArray  NO-UNDO.
DEFINE VARIABLE obj         AS JsonObject NO-UNDO.

DEFINE VARIABLE cConfig     AS CHARACTER  NO-UNDO.

DEFINE VARIABLE cnt         AS INTEGER    NO-UNDO.

oJsonObject = NEW JsonObject().
oJsonObject:ADD("readURL", AppURL + "/" + LOWER("{&TableName}-data.p")).
oJsonObject:ADD("data", "ds{&TableName}.tt{&TableName}").

FIND _File WHERE _File-Name = "{&TableName}" NO-LOCK.
array = NEW JsonArray().

FIND FIRST _Index WHERE RECID(_Index) = _File._Prime-Index NO-LOCK.
FOR EACH _Index-Field OF _Index NO-LOCK:
    FIND FIRST _Field WHERE RECID(_Field) = _Field-Recid NO-LOCK.
    CREATE ttField.
    ASSIGN ttFieldName = _Field-Name.
    cnt = cnt + 1.
END.

FOR EACH _Field OF _File NO-LOCK BY _Field._Order:
    IF cnt > 5 THEN LEAVE.
    cnt = cnt + 1.
    FIND FIRST ttField WHERE ttFieldName = _Field-Name NO-LOCK NO-ERROR.
    IF NOT AVAILABLE ttField THEN DO:
        CREATE ttField.
        ASSIGN ttFieldName = _Field-Name.
    END.    
END.
oJsonObject:ADD("fields", array).

FOR EACH ttField NO-LOCK:
    obj = NEW JsonObject().
    obj:ADD("field", ttFieldName).
    array:ADD(obj).
END.

cConfig = STRING(oJsonObject:GetJsonText()).
