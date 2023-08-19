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
}