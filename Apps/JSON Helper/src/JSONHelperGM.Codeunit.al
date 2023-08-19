/// <summary>
/// Offers useful functions for working with JSON.
/// </summary>
codeunit 96000 "JSON Helper GM"
{
    Access = Public;

    var
        JSONHelperImplGM: Codeunit "JSON Helper Impl. GM";

    /// <summary>
    /// Checks if the specified <paramref name="JSONObject"/> is empty.
    /// </summary>
    /// <param name="JSONObject">The JSON object to check.</param>
    /// <returns>True if <paramref name="JSONObject"/> is empty; otherwise, false.</returns>
    procedure IsEmpty(JSONObject: JSONObject): Boolean
    begin
        exit(JSONHelperImplGM.IsEmpty(JSONObject));
    end;
}