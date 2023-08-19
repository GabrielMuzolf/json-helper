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

    /// <summary>
    /// Retrieves the value from the specified <paramref name="JSONObject"/> using the given <paramref name="JSONKey"/> and assigns it to the <paramref name="Value"/> text variable.
    /// </summary>
    /// <param name="JSONObject">The JSON Object.</param>
    /// <param name="JSONKey">The key in the JSON object.</param>
    /// <param name="Value">The variable to store the retrieved value.</param>
    /// <returns>True if the value was successfully retrieved; otherwise, false.</returns>
    [TryFunction]
    procedure GetValueByKey(JSONObject: JsonObject; JSONKey: Text; var Value: Text)
    begin
    end;

    /// <summary>
    /// Retrieves the value from the specified <paramref name="JSONObject"/> using the given <paramref name="JSONKey"/> and assigns it to the <paramref name="Value"/> Integer variable.
    /// </summary>
    /// <param name="JSONObject">The JSON Object.</param>
    /// <param name="JSONKey">The key in the JSON object.</param>
    /// <param name="Value">The variable to store the retrieved Integer value.</param>
    /// <returns>True if the value was successfully retrieved; otherwise, false.</returns>
    [TryFunction]
    procedure GetValueByKey(JSONObject: JsonObject; JSONKey: Text; var Value: Integer)
    begin

    end;

    /// <summary>
    /// Retrieves the value from the specified <paramref name="JSONObject"/> using the given <paramref name="JSONKey"/> and assigns it to the <paramref name="Value"/> Date variable.
    /// </summary>
    /// <param name="JSONObject">The JSON Object.</param>
    /// <param name="JSONKey">The key in the JSON object.</param>
    /// <param name="Value">The variable to store the retrieved Date value.</param>
    /// <returns>True if the value was successfully retrieved; otherwise, false.</returns>
    [TryFunction]
    procedure GetValueByKey(JSONObject: JsonObject; JSONKey: Text; var Value: Date)
    begin

    end;

    /// <summary>
    /// Retrieves the value from the specified <paramref name="JSONObject"/> using the given <paramref name="JSONKey"/> and assigns it to the <paramref name="Value"/> Boolean variable.
    /// </summary>
    /// <param name="JSONObject">The JSON Object.</param>
    /// <param name="JSONKey">The key in the JSON object.</param>
    /// <param name="Value">The variable to store the retrieved Boolean value.</param>
    [TryFunction]
    procedure GetValueByKey(JSONObject: JsonObject; JSONKey: Text; var Value: Boolean)
    begin

    end;
}