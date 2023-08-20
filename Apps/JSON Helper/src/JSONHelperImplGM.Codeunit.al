codeunit 96001 "JSON Helper Impl. GM"
{
    Access = Internal;

    procedure IsEmpty(JSONObject: JSONObject): Boolean
    var
        JSONAsText: Text;
    begin
        if not JSONObject.WriteTo(JSONAsText) then
            exit(true);

        exit((JSONAsText = 'null') or (JSONAsText = '[]') or (JSONAsText = '') or (JSONAsText = '{}'));
    end;

    [TryFunction]
    procedure GetValueByKey(JSONObject: JsonObject; JSONKey: Text; var Value: Text)
    var
        JSONToken: JSONToken;
    begin
        Clear(Value);
        JSONObject.Get(JSONKey, JSONToken);
        Value := JSONToken.AsValue().AsText();
    end;


    [TryFunction]
    procedure GetValueByKey(JSONObject: JsonObject; JSONKey: Text; var Value: Integer)
    var
        JSONToken: JSONToken;
    begin
        Clear(Value);
        JSONObject.Get(JSONKey, JSONToken);
        Value := JSONToken.AsValue().AsInteger();
    end;

    [TryFunction]
    procedure GetValueByKey(JSONObject: JsonObject; JSONKey: Text; var Value: Date)
    var
        JSONToken: JSONToken;
    begin
        Clear(Value);
        JSONObject.Get(JSONKey, JSONToken);
        Value := JSONToken.AsValue().AsDate();
    end;

    [TryFunction]
    procedure GetValueByKey(JSONObject: JsonObject; JSONKey: Text; var Value: Boolean)
    var
        JSONToken: JSONToken;
    begin
        Clear(Value);
        JSONObject.Get(JSONKey, JSONToken);
        Value := JSONToken.AsValue().AsBoolean();
    end;

    [TryFunction]
    procedure GetObjectByKey(JSONObject: JsonObject; JSONKey: Text; var RestoredJSONObject: JsonObject)
    var
        JSONToken: JSONToken;
    begin
        Clear(RestoredJSONObject);
        JSONObject.Get(JSONKey, JSONToken);
        RestoredJSONObject := JSONToken.AsObject();
    end;

    [TryFunction]
    procedure GetArrayByKey(JSONObject: JsonObject; JSONKey: Text; var RestoredJSONArray: JsonArray)
    var
        JSONToken: JSONToken;
    begin
        Clear(RestoredJSONArray);
        JSONObject.Get(JSONKey, JSONToken);
        RestoredJSONArray := JSONToken.AsArray();
    end;

    [TryFunction]
    procedure GetValueByPath(JSONObject: JsonObject; JSONPath: Text; var Value: Text)
    var
        JSONToken: JSONToken;
    begin
        Clear(Value);
        JSONObject.SelectToken(JSONPath, JSONToken);
        Value := JSONToken.AsValue().AsText();
    end;

    [TryFunction]
    procedure GetValueByPath(JSONObject: JsonObject; JSONPath: Text; var Value: Integer)
    var
        JSONToken: JSONToken;
    begin
        Clear(Value);
        JSONObject.SelectToken(JSONPath, JSONToken);
        Value := JSONToken.AsValue().AsInteger();
    end;

    [TryFunction]
    procedure GetValueByPath(JSONObject: JsonObject; JSONPath: Text; var Value: Date)
    var
        JSONToken: JSONToken;
    begin
        Clear(Value);
        JSONObject.SelectToken(JSONPath, JSONToken);
        Value := JSONToken.AsValue().AsDate();
    end;

    [TryFunction]
    procedure GetValueByPath(JSONObject: JsonObject; JSONPath: Text; var Value: Boolean)
    var
        JSONToken: JSONToken;
    begin
        Clear(Value);
        JSONObject.SelectToken(JSONPath, JSONToken);
        Value := JSONToken.AsValue().AsBoolean();
    end;

    [TryFunction]
    procedure GetObjectByPath(JSONObject: JsonObject; JSONPath: Text; var RestoredJSONObject: JsonObject)
    var
        JSONToken: JSONToken;
    begin
        Clear(RestoredJSONObject);
        JSONObject.SelectToken(JSONPath, JSONToken);
        RestoredJSONObject := JSONToken.AsObject();
    end;

    [TryFunction]
    procedure GetArrayByPath(JSONObject: JsonObject; JSONPath: Text; var RestoredJSONArray: JsonArray)
    var
        JSONToken: JSONToken;
    begin
        Clear(RestoredJSONArray);
        JSONObject.SelectToken(JSONPath, JSONToken);
        RestoredJSONArray := JSONToken.AsArray();
    end;
}