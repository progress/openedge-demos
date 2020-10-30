USING Progress.Json.ObjectModel.JsonObject.

CREATE WIDGET-POOL.

{src/web2/wrap-cgi.i}

DEFINE TEMP-TABLE ttState LIKE State.
DEFINE DATASET dsState FOR ttState.

RUN process-web-request.

PROCEDURE outputHeader :
  output-content-type ("application/json":U).
END PROCEDURE.

PROCEDURE process-web-request :
  DEFINE VARIABLE oJsonObject        AS Progress.Json.ObjectModel.JsonObject NO-UNDO.
  DEFINE VARIABLE lChar              AS LONGCHAR NO-UNDO.
  RUN outputHeader.

  EMPTY TEMP-TABLE ttState.
  FOR EACH State NO-LOCK:
    CREATE ttState.
    BUFFER-COPY State TO ttState.
  END.
  
  oJsonObject = NEW JsonObject().
  oJsonObject:READ(DATASET dsState:HANDLE).

  lChar = oJsonObject:GetJsonText().
  {&OUT-LONG} lChar.

END PROCEDURE.
