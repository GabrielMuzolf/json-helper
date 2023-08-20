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
        JSONHelperImplGM.GetValueByKey(JSONObject, JSONKey, Value);
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
        JSONHelperImplGM.GetValueByKey(JSONObject, JSONKey, Value);
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
        JSONHelperImplGM.GetValueByKey(JSONObject, JSONKey, Value);
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
        JSONHelperImplGM.GetValueByKey(JSONObject, JSONKey, Value);
    end;

    /// <summary>
    /// Retrieves the object from the specified <paramref name="JSONObject"/> using the specified <paramref name="JSONKey"/> and assigns it to the <paramref name="RestoredJSONObject"/>.
    /// </summary>
    /// <param name="JSONObject">The JSON Object.</param>
    /// <param name="JSONKey">The key in the JSON object.</param>
    /// <param name="RestoredJSONObject">The variable to store the retrieved JSON object.</param>
    /// <returns>True if the value was successfully retrieved; otherwise, false.</returns>
    [TryFunction]
    procedure GetObjectByKey(JSONObject: JsonObject; JSONKey: Text; var RestoredJSONObject: JsonObject)
    begin
        JSONHelperImplGM.GetObjectByKey(JSONObject, JSONKey, RestoredJSONObject);
    end;

    /// <summary>
    /// Retrieves a Text value and sets it to <paramref name="Value"/> if an element exists in <paramref name="JSONObject"/> with the specified <paramref name="JSONPath"/>.
    /// </summary>
    /// <param name="JSONObject">The JSON object.</param>
    /// <param name="JSONPath">The JSON path.</param>
    /// <param name="Value">The Text variable to store the retrieved value.</param>
    [TryFunction]
    procedure GetValueByPath(JSONObject: JsonObject; JSONPath: Text; var Value: Text)
    begin
        JSONHelperImplGM.GetValueByPath(JSONObject, JSONPath, Value);
    end;

    /// <summary>
    /// Retrieves an Integer value and sets it to <paramref name="Value"/> if an element exists in <paramref name="JSONObject"/> with the specified <paramref name="JSONPath"/>.
    /// </summary>
    /// <param name="JSONObject">The JSON object.</param>
    /// <param name="JSONPath">The JSON path.</param>
    /// <param name="Value">The Integer variable to store the retrieved value.</param>
    [TryFunction]
    procedure GetValueByPath(JSONObject: JsonObject; JSONPath: Text; var Value: Integer)
    begin
        JSONHelperImplGM.GetValueByPath(JSONObject, JSONPath, Value);
    end;

    /// <summary>
    /// Retrieves a Date value and sets it to <paramref name="Value"/> if an element exists in <paramref name="JSONObject"/> with the specified <paramref name="JSONPath"/>.
    /// </summary>
    /// <param name="JSONObject">The JSON object.</param>
    /// <param name="JSONPath">The JSON path.</param>
    /// <param name="Value">The Date variable to store the retrieved value.</param>
    [TryFunction]
    procedure GetValueByPath(JSONObject: JsonObject; JSONPath: Text; var Value: Date)
    begin
        JSONHelperImplGM.GetValueByPath(JSONObject, JSONPath, Value);
    end;

    /// <summary>
    /// Retrieves a Boolean value and sets it to <paramref name="Value"/> if an element exists in <paramref name="JSONObject"/> with the specified <paramref name="JSONPath"/>.
    /// </summary>
    /// <param name="JSONObject">The JSON object.</param>
    /// <param name="JSONPath">The JSON path.</param>
    /// <param name="Value">The Boolean variable to store the retrieved value.</param>
    [TryFunction]
    procedure GetValueByPath(JSONObject: JsonObject; JSONPath: Text; var Value: Boolean)
    begin
        JSONHelperImplGM.GetValueByPath(JSONObject, JSONPath, Value);
    end;

    /// <summary>
    /// Retrieves the object from the specified <paramref name="JSONObject"/> using the specified <paramref name="JSONPath"/> and assigns it to the <paramref name="RestoredJSONObject"/>.
    /// </summary>
    /// <param name="JSONObject">The JSON Object.</param>
    /// <param name="JSONPath">The JSON object path.</param>
    /// <param name="RestoredJSONObject">The variable to store the retrieved JSON object.</param>
    /// <returns>True if the value was successfully retrieved; otherwise, false.</returns>
    [TryFunction]
    procedure GetObjectByPath(JSONObject: JsonObject; JSONPath: Text; var RestoredJSONObject: JsonObject)
    begin
        JSONHelperImplGM.GetObjectByPath(JSONObject, JSONPath, RestoredJSONObject);
    end;
}