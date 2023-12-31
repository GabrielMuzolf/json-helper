codeunit 97000 "JSON Helper Test GM"
{
    Subtype = Test;

    var
        Any: Codeunit Any;
        LibraryAssert: Codeunit "Library Assert";
        LibraryJSONGM: Codeunit "Library - JSON GM";
        MissingJSONKeyErr: Label 'There is no property with the ''%1'' key on the JSON object.', Comment = '%1 = JSON key', Locked = true;
        TokenNotAValueErr: Label 'Unable to convert from Microsoft.Dynamics.Nav.Runtime.NavJsonToken to Microsoft.Dynamics.Nav.Runtime.NavJsonValue.', Locked = true;
        MissingJSONPathErr: Label 'The JSON path ''%1'' does not match any tokens.', Comment = '%1 = JSON path', Locked = true;
        TokenNotAnObjectErr: Label 'Unable to convert from Microsoft.Dynamics.Nav.Runtime.NavJsonToken to Microsoft.Dynamics.Nav.Runtime.NavJsonObject.', Locked = true;
        TokenNotAnArrayErr: Label 'Unable to convert from Microsoft.Dynamics.Nav.Runtime.NavJsonToken to Microsoft.Dynamics.Nav.Runtime.NavJsonArray.', Locked = true;

    [Test]
    procedure IsEmptyNullObject();
    var
        JSONHelperGM: Codeunit "JSON Helper GM";
        JSONObject: JsonObject;
    begin
        //[SCENARIO] Invoke IsEmpty method for an empty JSON Object.

        //[GIVEN] An empty JSON Object.
        //[WHEN] IsEmpty method is invoked.
        //[THEN] The method returns true.
        LibraryAssert.IsTrue(JSONHelperGM.IsEmpty(JSONObject), '');
    end;

    [Test]
    procedure IsEmptyNotNullObject()
    var
        JSONHelperGM: Codeunit "JSON Helper GM";
        JSONObject: JsonObject;
    begin
        //[SCENARIO] Invoke IsEmpty method for a non-empty JSON Object.

        //[GIVEN] A non-empty JSONObject.
        JSONObject.Add(Any.UnicodeText(10), Any.UnicodeText(10));

        //[WHEN] IsEmpty method is invoked.
        //[THEN] The method returns false.
        LibraryAssert.IsFalse(JSONHelperGM.IsEmpty(JSONObject), '');
    end;

    [Test]
    procedure GetTextValueByKeyMissingKey()
    var
        JSONHelperGM: Codeunit "JSON Helper GM";
        JSONObject: JsonObject;
        Value: Text;
        JSONKey: Text;
    begin
        //[SCENARIO] Invoke GetValueByKey method for an undefined key.

        //[GIVEN] A JSONKey.
        JSONKey := Any.UnicodeText(10);

        //[GIVEN] A JSONObject without a defined JSONKey.
        //[WHEN] GetValueByKey method is invoked.
        //[THEN] An error occurs.
        asserterror JSONHelperGM.GetValueByKey(JSONObject, JSONKey, Value);
        LibraryAssert.ExpectedError(StrSubstNo(MissingJSONKeyErr, JSONKey));
    end;

    [Test]
    procedure GetTextValueByKeyNotAJSONValue()
    var
        JSONHelperGM: Codeunit "JSON Helper GM";
        JSONObject: JsonObject;
        InnerJSONObject: JsonObject;
        Value: Text;
        JSONKey: Text;
    begin
        //[SCENARIO] Invoke GetValueByKey for specified key which value is not a JSONValue.

        //[GIVEN] A JSONKey.
        JSONKey := Any.UnicodeText(10);

        //[GIVEN] A JSONObject with a defined value for JSONKey, the value is not a JSONValue.
        InnerJSONObject.Add(Any.UnicodeText(10), Any.UnicodeText(10));
        JSONObject.Add(JSONKey, InnerJSONObject);

        //[WHEN] GetValueByKey method is invoked.
        //[THEN] An error occurs.
        asserterror JSONHelperGM.GetValueByKey(JSONObject, JSONKey, Value);
        LibraryAssert.ExpectedError(TokenNotAValueErr);
    end;

    [Test]
    procedure GetTextValueByKey()
    var
        JSONHelperGM: Codeunit "JSON Helper GM";
        JSONObject: JsonObject;
        Value: Text;
        JSONKey: Text;
        JSONValue: Text;
    begin
        //[SCENARIO] Invoke GetValueByKey for and existing key which value is a text.

        //[GIVEN] A JSONKey.
        JSONKey := Any.UnicodeText(10);

        //[GIVEN] A text JSONValue.
        JSONValue := Any.UnicodeText(10);

        //[GIVEN] A JsonObject with defined value for JSONKey, the value is a text.
        JSONObject.Add(JSONKey, JSONValue);

        //[WHEN] GetValueByKey method is invoked.
        JSONHelperGM.GetValueByKey(JSONObject, JSONKey, Value);

        //[THEN] Restored text value is equal to previosuly defined text value.
        LibraryAssert.AreEqual(JSONValue, Value, '');
    end;

    [Test]
    procedure GetIntegerValueByKeyMissingKey()
    var
        JSONHelperGM: Codeunit "JSON Helper GM";
        JSONObject: JsonObject;
        Value: Integer;
        JSONKey: Text;
    begin
        //[SCENARIO] Invoke GetValueByKey method for an undefined key.

        //[GIVEN] A JSONKey.
        JSONKey := Any.UnicodeText(10);

        //[GIVEN] A JSONObject without a defined JSONKey.
        //[WHEN] GetValueByKey method is invoked.
        //[THEN] An error occurs.
        asserterror JSONHelperGM.GetValueByKey(JSONObject, JSONKey, Value);
        LibraryAssert.ExpectedError(StrSubstNo(MissingJSONKeyErr, JSONKey));
    end;

    [Test]
    procedure GetIntegerValueByKeyNotAJSONValue()
    var
        JSONHelperGM: Codeunit "JSON Helper GM";
        JSONObject: JsonObject;
        InnerJSONObject: JsonObject;
        Value: Integer;
        JSONKey: Text;
    begin
        //[SCENARIO] Invoke GetValueByKey for specified key which value is not a JSONValue.

        //[GIVEN] A JSONKey.
        JSONKey := Any.UnicodeText(10);

        //[GIVEN] A JSONObject with a defined value for JSONKey, the value is not a JSONValue.
        InnerJSONObject.Add(Any.UnicodeText(10), Any.UnicodeText(10));
        JSONObject.Add(JSONKey, InnerJSONObject);

        //[WHEN] GetValueByKey method is invoked.
        //[THEN] An error occurs.
        asserterror JSONHelperGM.GetValueByKey(JSONObject, JSONKey, Value);
        LibraryAssert.ExpectedError(TokenNotAValueErr);
    end;

    [Test]
    procedure GetIntegerValueByKeyNotAnInteger()
    var
        JSONHelperGM: Codeunit "JSON Helper GM";
        JSONObject: JsonObject;
        Value: Integer;
        JSONKey: Text;
        ExpectedErr: Label 'Unable to convert from Microsoft.Dynamics.Nav.Runtime.NavJsonValue to System.Int32.', Locked = true;
    begin
        //[SCENARIO] Invoke GetValueByKey for specified key which value is not an integer.

        //[GIVEN] A JSONKey.
        JSONKey := Any.UnicodeText(10);

        //[GIVEN] A JSONObject with defined value for JSONKey, the value is not an integer.
        JSONObject.Add(JSONKey, Any.UnicodeText(10));

        //[WHEN] GetValueByKey method is invoked.
        //[THEN] An error occurs.
        asserterror JSONHelperGM.GetValueByKey(JSONObject, JSONKey, Value);
        LibraryAssert.ExpectedError(ExpectedErr);
    end;

    [Test]
    procedure GetIntegerValueByKey()
    var
        JSONHelperGM: Codeunit "JSON Helper GM";
        JSONObject: JsonObject;
        Value: Integer;
        JSONKey: Text;
        JSONValue: Integer;
    begin
        //[SCENARIO] Invoke GetValueByKey for an existing key which value is an integer.

        //[GIVEN] A JSONKey.
        JSONKey := Any.UnicodeText(10);

        //[GIVEN] An integer JSONValue.
        JSONValue := Any.IntegerInRange(1, 10);

        //[GIVEN] A JsonObject with defined value for JSONKey, the value is an integer.
        JSONObject.Add(JSONKey, JSONValue);

        //[WHEN] GetValueByKey method is invoked.
        JSONHelperGM.GetValueByKey(JSONObject, JSONKey, Value);

        //[THEN] Restored integer value is equal to previosuly defined integer value.
        LibraryAssert.AreEqual(JSONValue, Value, '');
    end;

    [Test]
    procedure GetDateValueByKeyMissingKey()
    var
        JSONHelperGM: Codeunit "JSON Helper GM";
        JSONObject: JsonObject;
        Value: Date;
        JSONKey: Text;
    begin
        //[SCENARIO] Invoke GetValueByKey method for an undefined key.

        //[GIVEN] A JSONKey.
        JSONKey := Any.UnicodeText(10);

        //[GIVEN] A JSONObject without a defined JSONKey.
        //[WHEN] GetValueByKey method is invoked.
        //[THEN] An error occurs.
        asserterror JSONHelperGM.GetValueByKey(JSONObject, JSONKey, Value);
        LibraryAssert.ExpectedError(StrSubstNo(MissingJSONKeyErr, JSONKey));
    end;

    [Test]
    procedure GetDateValueByKeyNotAJSONValue()
    var
        JSONHelperGM: Codeunit "JSON Helper GM";
        JSONObject: JsonObject;
        InnerJSONObject: JsonObject;
        Value: Date;
        JSONKey: Text;
    begin
        //[SCENARIO] Invoke GetValueByKey for specified key which value is not a JSONValue.

        //[GIVEN] A JSONKey.
        JSONKey := Any.UnicodeText(10);

        //[GIVEN] A JSONObject with a defined value for JSONKey, the value is not a JSONValue.
        InnerJSONObject.Add(Any.UnicodeText(10), Any.UnicodeText(10));
        JSONObject.Add(JSONKey, InnerJSONObject);

        //[WHEN] GetValueByKey method is invoked.
        //[THEN] An error occurs.
        asserterror JSONHelperGM.GetValueByKey(JSONObject, JSONKey, Value);
        LibraryAssert.ExpectedError(TokenNotAValueErr);
    end;

    [Test]
    procedure GetDateValueByKeyNotADate()
    var
        JSONHelperGM: Codeunit "JSON Helper GM";
        JSONObject: JsonObject;
        Value: Date;
        JSONKey: Text;
        ExpectedErr: Label 'Unable to convert from Microsoft.Dynamics.Nav.Runtime.NavJsonValue to Microsoft.Dynamics.Nav.Runtime.NavDate.', Locked = true;
    begin
        //[SCENARIO] Invoke GetValueByKey for specifed key which value is not a date.

        //[GIVEN] A JSONKey.
        JSONKey := Any.UnicodeText(10);

        //[GIVEN] A JSONObject with defined value for JSONKey, the value is not a date.
        JSONObject.Add(JSONKey, Any.UnicodeText(10));

        //[WHEN] GetValueByKey method is invoked.
        //[THEN] An error occures
        asserterror JSONHelperGM.GetValueByKey(JSONObject, JSONKey, Value);
        LibraryAssert.ExpectedError(ExpectedErr);
    end;

    [Test]
    procedure GetDateValueByKey()
    var
        JSONHelperGM: Codeunit "JSON Helper GM";
        JSONObject: JsonObject;
        Value: Date;
        JSONKey: Text;
        JSONValue: Date;
    begin
        //[SCENARIO] Invoke GetValueByKey for an existing key which value is a date.

        //[GIVEN] A JSONKey.
        JSONKey := Any.UnicodeText(10);

        //[GIVEN] A date JSONValue.
        JSONValue := Any.DateInRange(10);

        //[GIVEN] A JsonObject with defined value for JSONKey, the value is a date.
        JSONObject.Add(JSONKey, JSONValue);

        //[WHEN] GetValueByKey method is invoked.
        JSONHelperGM.GetValueByKey(JSONObject, JSONKey, Value);

        //[THEN] Restored date value is equal to previosuly defined date value.
        LibraryAssert.AreEqual(JSONValue, Value, '');
    end;

    [Test]
    procedure GetBooleanValueByKeyMissingKey()
    var
        JSONHelperGM: Codeunit "JSON Helper GM";
        JSONObject: JsonObject;
        Value: Boolean;
        JSONKey: Text;
    begin
        //[SCENARIO] Invoke GetValueByKey method for an undefined key.

        //[GIVEN] A JSONKey.
        JSONKey := Any.UnicodeText(10);

        //[GIVEN] A JSONObject without a defined JSONKey.
        //[WHEN] GetValueByKey method is invoked.
        //[THEN] An error occurs.
        asserterror JSONHelperGM.GetValueByKey(JSONObject, JSONKey, Value);
        LibraryAssert.ExpectedError(StrSubstNo(MissingJSONKeyErr, JSONKey));
    end;

    [Test]
    procedure GetBooleanValueByKeyNotAJSONValue()
    var
        JSONHelperGM: Codeunit "JSON Helper GM";
        JSONObject: JsonObject;
        InnerJSONObject: JsonObject;
        Value: Boolean;
        JSONKey: Text;
    begin
        //[SCENARIO] Invoke GetValueByKey for specified key which value is not a JSONValue.

        //[GIVEN] A JSONKey.
        JSONKey := Any.UnicodeText(10);

        //[GIVEN] A JSONObject with a defined value for JSONKey, the value is not a JSONValue.
        InnerJSONObject.Add(Any.UnicodeText(10), Any.UnicodeText(10));
        JSONObject.Add(JSONKey, InnerJSONObject);

        //[WHEN] GetValueByKey method is invoked.
        //[THEN] An error occurs.
        asserterror JSONHelperGM.GetValueByKey(JSONObject, JSONKey, Value);
        LibraryAssert.ExpectedError(TokenNotAValueErr);
    end;

    [Test]
    procedure GetBooleanValueByKeyNotABoolean()
    var
        JSONHelperGM: Codeunit "JSON Helper GM";
        JSONObject: JsonObject;
        Value: Boolean;
        JSONKey: Text;
        ExpectedErr: Label 'Unable to convert from Microsoft.Dynamics.Nav.Runtime.NavJsonValue to System.Boolean.', Locked = true;
    begin
        //[SCENARIO] Invoke GetValueByKey for specifed key which value is not a boolean.

        //[GIVEN] A JSONKey.
        JSONKey := Any.UnicodeText(10);

        //[GIVEN] A JSONObject with defined value for JSONKey, the value is not a boolean.
        JSONObject.Add(JSONKey, Any.UnicodeText(10));

        //[WHEN] GetValueByKey method is invoked.
        //[THEN] An error occures
        asserterror JSONHelperGM.GetValueByKey(JSONObject, JSONKey, Value);
        LibraryAssert.ExpectedError(ExpectedErr);
    end;

    [Test]
    procedure GetBooleanValueByKey()
    var
        JSONHelperGM: Codeunit "JSON Helper GM";
        JSONObject: JsonObject;
        Value: Boolean;
        JSONKey: Text;
        JSONValue: Boolean;
    begin
        //[SCENARIO] Invoke GetValueByKey for an existing key which value is a boolean.

        //[GIVEN] A JSONKey.
        JSONKey := Any.UnicodeText(10);

        //[GIVEN] A boolean JSONValue.
        JSONValue := Any.Boolean();

        //[GIVEN] A JsonObject with defined value for JSONKey, the value is a boolean.
        JSONObject.Add(JSONKey, JSONValue);

        //[WHEN] GetValueByKey method is invoked.
        JSONHelperGM.GetValueByKey(JSONObject, JSONKey, Value);

        //[THEN] Restored boolean value is equal to previosuly defined boolean value.
        LibraryAssert.AreEqual(JSONValue, Value, '');
    end;

    [Test]
    procedure GetObjectByKeyMissingKey()
    var
        JSONHelperGM: Codeunit "JSON Helper GM";
        JSONObject: JsonObject;
        RestoredJSONObject: JsonObject;
        JSONKey: Text;
    begin
        //[SCENARIO] Invoke GetObjectByKey method for undefined key.

        //[GIVEN] A JSONKey.
        JSONKey := Any.UnicodeText(10);

        //[GIVEN] A JSONObject without defined JSONKey.
        //[WHEN] GetObjectByKey method is invoked.
        //[THEN] An error occures
        asserterror JSONHelperGM.GetObjectByKey(JSONObject, JSONKey, RestoredJSONObject);
        LibraryAssert.ExpectedError(StrSubstNo(MissingJSONKeyErr, JSONKey));
    end;

    [Test]
    procedure GetObjectByKeyNotAJSONObject()
    var
        JSONHelperGM: Codeunit "JSON Helper GM";
        JSONObject: JsonObject;
        RestoredJSONObject: JsonObject;
        JSONKey: Text;
    begin
        //[SCENARIO] Invoke GetObjectByKey for specifed key which value is not a JSONObject.

        //[GIVEN] A JSONKey.
        JSONKey := Any.UnicodeText(10);

        //[GIVEN] A JSONObject with defined value for JSONKey, the value is not an object.
        JSONObject.Add(JSONKey, Any.UnicodeText(10));

        //[WHEN] GetObjectByKey method is invoked.
        //[THEN] An error occures
        asserterror JSONHelperGM.GetObjectByKey(JSONObject, JSONKey, RestoredJSONObject);
        LibraryAssert.ExpectedError(TokenNotAnObjectErr);
    end;

    [Test]
    procedure GetObjectByKey()
    var
        JSONHelperGM: Codeunit "JSON Helper GM";
        JSONObject: JsonObject;
        InnerJSONObject: JsonObject;
        RestoredJSONObject: JsonObject;
        JSONKey: Text;
    begin
        //[SCENARIO] Invoke GetObjectByKey for and existing key which value is an object.

        //[GIVEN] A JSONKey.
        JSONKey := Any.UnicodeText(10);

        //[GIVEN] A JSONObject with defined value for JSONKey, the value is an object.
        InnerJSONObject.Add(JSONKey, Any.UnicodeText(10));
        JSONObject.Add(JSONKey, InnerJSONObject);

        //[WHEN] GetObjectByKey method is invoked.
        JSONHelperGM.GetObjectByKey(JSONObject, JSONKey, RestoredJSONObject);

        //[THEN] Restored JSON Object is equal to previosuly created inner JSON Object.
        LibraryAssert.AreEqual(Format(InnerJSONObject), Format(RestoredJSONObject), '');
    end;

    [Test]
    procedure GetArrayByKeyMissingKey()
    var
        JSONHelperGM: Codeunit "JSON Helper GM";
        JSONObject: JsonObject;
        RestoredJSONArray: JsonArray;
        JSONKey: Text;
    begin
        //[SCENARIO] Invoke GetArrayByKey method for undefined key.

        //[GIVEN] A JSONKey.
        JSONKey := Any.UnicodeText(10);

        //[GIVEN] A JSONObject without defined JSONKey.
        //[WHEN] GetArrayByKey method is invoked.
        //[THEN] An error occures
        asserterror JSONHelperGM.GetArrayByKey(JSONObject, JSONKey, RestoredJSONArray);
        LibraryAssert.ExpectedError(StrSubstNo(MissingJSONKeyErr, JSONKey));
    end;

    [Test]
    procedure GetArrayByKeyNotAJSONArray()
    var
        JSONHelperGM: Codeunit "JSON Helper GM";
        JSONObject: JsonObject;
        RestoredJSONArray: JsonArray;
        JSONKey: Text;
    begin
        //[SCENARIO] Invoke GetArrayByKey for specifed key which value is not a JSONArray.

        //[GIVEN] A JSONKey.
        JSONKey := Any.UnicodeText(10);

        //[GIVEN] A JSONObject with defined value for JSONKey, the value is not an array.
        JSONObject.Add(JSONKey, Any.UnicodeText(10));

        //[WHEN] GetArrayByKey method is invoked.
        //[THEN] An error occures
        asserterror JSONHelperGM.GetArrayByKey(JSONObject, JSONKey, RestoredJSONArray);
        LibraryAssert.ExpectedError(TokenNotAnArrayErr);
    end;

    [Test]
    procedure GetArrayByKey()
    var
        JSONHelperGM: Codeunit "JSON Helper GM";
        JSONObject: JsonObject;
        InnerJSONArray: JsonArray;
        RestoredJSONArray: JsonArray;
        JSONKey: Text;
    begin
        //[SCENARIO] Invoke GetArrayByKey for and existing key which value is an array.

        //[GIVEN] A JSONKey.
        JSONKey := Any.UnicodeText(10);

        //[GIVEN] A JSONObject with defined value for JSONKey, the value is an array.
        InnerJSONArray.Add(Any.UnicodeText(10));
        JSONObject.Add(JSONKey, InnerJSONArray);

        //[WHEN] GetArrayByKey method is invoked.
        JSONHelperGM.GetArrayByKey(JSONObject, JSONKey, RestoredJSONArray);

        //[THEN] Restored JSON Array is equal to previosuly created inner JSON Array.
        LibraryAssert.AreEqual(Format(InnerJSONArray), Format(RestoredJSONArray), '');
    end;

    [Test]
    procedure GetTextValueByPathMissingPath()
    var
        JSONHelperGM: Codeunit "JSON Helper GM";
        JSONObject: JsonObject;
        Value: Text;
        JSONPath: Text;
    begin
        //[SCENARIO] Invoke GetValueByPath method for an undefined path.

        //[GIVEN] A JSONPath.
        JSONPath := LibraryJSONGM.RandomJsonPath(Any.IntegerInRange(1, 10));

        //[GIVEN] A JSONObject without a defined JSONPath.

        //[WHEN] GetValueByPath method is invoked.
        //[THEN] An error occurs.
        asserterror JSONHelperGM.GetValueByPath(JSONObject, JSONPath, Value);
        LibraryAssert.ExpectedError(StrSubstNo(MissingJSONPathErr, JSONPath));
    end;

    [Test]
    procedure GetTextValueByPathValueNotAJSONObject()
    var
        JSONHelperGM: Codeunit "JSON Helper GM";
        JSONObject: JsonObject;
        InnerJSONObject: JsonObject;
        Value: Text;
        JSONPath: Text;
        JSONKey: Text;
    begin
        //[SCENARIO] Invoke GetValueByPath value for specified path which is not a JSONObject.

        //[GIVEN] A JSONKey
        JSONKey := Any.UnicodeText(10);

        //[GIVEN] A JSONPath.
        JSONPath := '$.' + JSONKey;

        //[GIVEN] A JSONObject with defined value for JSONPath which is not a JsonValue.
        JSONObject.Add(JSONKey, InnerJSONObject);

        //[WHEN] GetValueByPath method is invoked.
        //[THEN] An error occurs.
        asserterror JSONHelperGM.GetValueByPath(JSONObject, JSONPath, Value);
        LibraryAssert.ExpectedError(TokenNotAValueErr);
    end;

    [Test]
    procedure GetTextValueByPath()
    var
        JSONHelperGM: Codeunit "JSON Helper GM";
        JSONObject: JsonObject;
        Value: Text;
        JSONPath: Text;
        JSONKey: Text;
        JSONValue: Text;
    begin
        //[SCENARIO] Invoke GetValueByPath for an existing path which value is a text.

        //[GIVEN] A JSONKey
        JSONKey := Any.UnicodeText(10);

        //[GIVEN] A JSONPath.
        JSONPath := '$.' + JSONKey;

        //[GIVEN] A text JSONValue
        JSONValue := Any.UnicodeText(10);

        //[GIVEN] A JSONObject with defined value for JSONPath which is a text value.
        JSONObject.Add(JSONKey, JSONValue);

        //[WHEN] GetValueByPath method is invoked.
        JSONHelperGM.GetValueByPath(JSONObject, JSONPath, Value);

        //[THEN] Restored text value is equal to previosuly defined text value.
        LibraryAssert.AreEqual(JSONValue, Value, '');
    end;

    [Test]
    procedure GetIntegerValueByPathMissingPath()
    var
        JSONHelperGM: Codeunit "JSON Helper GM";
        JSONObject: JsonObject;
        Value: Integer;
        JSONPath: Text;
    begin
        //[SCENARIO] Invoke GetValueByPath method for an undefined path.

        //[GIVEN] A JSONPath.
        JSONPath := LibraryJSONGM.RandomJsonPath(Any.IntegerInRange(1, 10));

        //[GIVEN] A JSONObject without a defined JSONPath.

        //[WHEN] GetValueByPath method is invoked.
        //[THEN] An error occurs.
        asserterror JSONHelperGM.GetValueByPath(JSONObject, JSONPath, Value);
        LibraryAssert.ExpectedError(StrSubstNo(MissingJSONPathErr, JSONPath));
    end;

    [Test]
    procedure GetIntegerValueByPathValueNotAJSONObject()
    var
        JSONHelperGM: Codeunit "JSON Helper GM";
        JSONObject: JsonObject;
        InnerJSONObject: JsonObject;
        Value: Integer;
        JSONPath: Text;
        JSONKey: Text;
    begin
        //[SCENARIO] Invoke GetValueByPath value for specified path which is not a JSONObject.

        //[GIVEN] A JSONKey
        JSONKey := Any.UnicodeText(10);

        //[GIVEN] A JSONPath.
        JSONPath := '$.' + JSONKey;

        //[GIVEN] A JSONObject with defined value for JSONPath which is not a JsonValue.
        JSONObject.Add(JSONKey, InnerJSONObject);

        //[WHEN] GetValueByPath method is invoked.
        //[THEN] An error occurs.
        asserterror JSONHelperGM.GetValueByPath(JSONObject, JSONPath, Value);
        LibraryAssert.ExpectedError(TokenNotAValueErr);
    end;

    [Test]
    procedure GetIntegerValueByPathValueNotAnInteger()
    var
        JSONHelperGM: Codeunit "JSON Helper GM";
        JSONObject: JsonObject;
        Value: Integer;
        JSONPath: Text;
        JSONKey: Text;
        JSONValue: Text;
        ExpectedErr: Label 'Unable to convert from Microsoft.Dynamics.Nav.Runtime.NavJsonValue to System.Int32', Locked = true;
    begin
        //[SCENARIO] Invoke GetValueByPath value for specified path which is not a JSONObject.

        //[GIVEN] A JSONKey
        JSONKey := Any.UnicodeText(10);

        //[GIVEN] A JSONPath.
        JSONPath := '$.' + JSONKey;

        //[GIVEN] A text JSONValue.
        JSONValue := Any.UnicodeText(10);

        //[GIVEN] A JSONObject with defined value for JSONPath which is not an integer value.
        JSONObject.Add(JSONKey, JSONValue);

        //[WHEN] GetValueByPath method is invoked.
        //[THEN] An error occurs.
        asserterror JSONHelperGM.GetValueByPath(JSONObject, JSONPath, Value);
        LibraryAssert.ExpectedError(ExpectedErr);
    end;

    [Test]
    procedure GetIntegerValueByPath()
    var
        JSONHelperGM: Codeunit "JSON Helper GM";
        JSONObject: JsonObject;
        Value: Integer;
        JSONPath: Text;
        JSONKey: Text;
        JSONValue: Integer;
    begin
        //[SCENARIO] Invoke GetValueByPath for an existing path which value is an integer.

        //[GIVEN] A JSONKey
        JSONKey := Any.UnicodeText(10);

        //[GIVEN] A JSONPath.
        JSONPath := '$.' + JSONKey;

        //[GIVEN] An integer JSONValue
        JSONValue := Any.IntegerInRange(1, 10);

        //[GIVEN] A JSONObject with defined value for JSONPath which is an integer value.
        JSONObject.Add(JSONKey, JSONValue);

        //[WHEN] GetValueByPath method is invoked.
        JSONHelperGM.GetValueByPath(JSONObject, JSONPath, Value);

        //[THEN] Restored integer value is equal to previosuly defined integer value.
        LibraryAssert.AreEqual(JSONValue, Value, '');
    end;

    [Test]
    procedure GetDateValueByPathMissingPath()
    var
        JSONHelperGM: Codeunit "JSON Helper GM";
        JSONObject: JsonObject;
        Value: Date;
        JSONPath: Text;
    begin
        //[SCENARIO] Invoke GetValueByPath method for an undefined path.

        //[GIVEN] A JSONPath.
        JSONPath := LibraryJSONGM.RandomJsonPath(Any.IntegerInRange(1, 10));

        //[GIVEN] A JSONObject without a defined JSONPath.

        //[WHEN] GetValueByPath method is invoked.
        //[THEN] An error occurs.
        asserterror JSONHelperGM.GetValueByPath(JSONObject, JSONPath, Value);
        LibraryAssert.ExpectedError(StrSubstNo(MissingJSONPathErr, JSONPath));
    end;

    [Test]
    procedure GetDateValueByPathValueNotAJSONObject()
    var
        JSONHelperGM: Codeunit "JSON Helper GM";
        JSONObject: JsonObject;
        InnerJSONObject: JsonObject;
        Value: Date;
        JSONPath: Text;
        JSONKey: Text;
    begin
        //[SCENARIO] Invoke GetValueByPath value for specified path which is not a JSONObject.

        //[GIVEN] A JSONKey
        JSONKey := Any.UnicodeText(10);

        //[GIVEN] A JSONPath.
        JSONPath := '$.' + JSONKey;

        //[GIVEN] A JSONObject with defined value for JSONPath which is not a JsonValue.
        JSONObject.Add(JSONKey, InnerJSONObject);

        //[WHEN] GetValueByPath method is invoked.
        //[THEN] An error occurs.
        asserterror JSONHelperGM.GetValueByPath(JSONObject, JSONPath, Value);
        LibraryAssert.ExpectedError(TokenNotAValueErr);
    end;

    [Test]
    procedure GetDateValueByPathValueNotADate()
    var
        JSONHelperGM: Codeunit "JSON Helper GM";
        JSONObject: JsonObject;
        Value: Date;
        JSONPath: Text;
        JSONKey: Text;
        JSONValue: Text;
        ExpectedErr: Label 'Unable to convert from Microsoft.Dynamics.Nav.Runtime.NavJsonValue to Microsoft.Dynamics.Nav.Runtime.NavDate', Locked = true;
    begin
        //[SCENARIO] Invoke GetValueByPath value for specified path which is not a JSONObject.

        //[GIVEN] A JSONKey
        JSONKey := Any.UnicodeText(10);

        //[GIVEN] A JSONPath.
        JSONPath := '$.' + JSONKey;

        //[GIVEN] A text JSONValue.
        JSONValue := Any.UnicodeText(10);

        //[GIVEN] A JSONObject with defined value for JSONPath which is not a date value.
        JSONObject.Add(JSONKey, JSONValue);

        //[WHEN] GetValueByPath method is invoked.
        //[THEN] An error occurs.
        asserterror JSONHelperGM.GetValueByPath(JSONObject, JSONPath, Value);
        LibraryAssert.ExpectedError(ExpectedErr);
    end;

    [Test]
    procedure GetDateValueByPath()
    var
        JSONHelperGM: Codeunit "JSON Helper GM";
        JSONObject: JsonObject;
        Value: Date;
        JSONPath: Text;
        JSONKey: Text;
        JSONValue: Date;
    begin
        //[SCENARIO] Invoke GetValueByPath for an existing path which value is a date.

        //[GIVEN] A JSONKey
        JSONKey := Any.UnicodeText(10);

        //[GIVEN] A JSONPath.
        JSONPath := '$.' + JSONKey;

        //[GIVEN] A date JSONValue
        JSONValue := Any.DateInRange(100);

        //[GIVEN] A JSONObject with defined value for JSONPath which is a date value.
        JSONObject.Add(JSONKey, JSONValue);

        //[WHEN] GetValueByPath method is invoked.
        JSONHelperGM.GetValueByPath(JSONObject, JSONPath, Value);

        //[THEN] Restored date value is equal to previosuly defined date value.
        LibraryAssert.AreEqual(JSONValue, Value, '');
    end;

    [Test]
    procedure GetBooleanValueByPathMissingPath()
    var
        JSONHelperGM: Codeunit "JSON Helper GM";
        JSONObject: JsonObject;
        Value: Boolean;
        JSONPath: Text;
    begin
        //[SCENARIO] Invoke GetValueByPath method for an undefined path.

        //[GIVEN] A JSONPath.
        JSONPath := LibraryJSONGM.RandomJsonPath(Any.IntegerInRange(1, 10));

        //[GIVEN] A JSONObject without a defined JSONPath.

        //[WHEN] GetValueByPath method is invoked.
        //[THEN] An error occurs.
        asserterror JSONHelperGM.GetValueByPath(JSONObject, JSONPath, Value);
        LibraryAssert.ExpectedError(StrSubstNo(MissingJSONPathErr, JSONPath));
    end;

    [Test]
    procedure GetBooleanValueByPathValueNotAJSONObject()
    var
        JSONHelperGM: Codeunit "JSON Helper GM";
        JSONObject: JsonObject;
        InnerJSONObject: JsonObject;
        Value: Boolean;
        JSONPath: Text;
        JSONKey: Text;
    begin
        //[SCENARIO] Invoke GetValueByPath value for specified path which is not a JSONObject.

        //[GIVEN] A JSONKey
        JSONKey := Any.UnicodeText(10);

        //[GIVEN] A JSONPath.
        JSONPath := '$.' + JSONKey;

        //[GIVEN] A JSONObject with defined value for JSONPath which is not a JsonValue.
        JSONObject.Add(JSONKey, InnerJSONObject);

        //[WHEN] GetValueByPath method is invoked.
        //[THEN] An error occurs.
        asserterror JSONHelperGM.GetValueByPath(JSONObject, JSONPath, Value);
        LibraryAssert.ExpectedError(TokenNotAValueErr);
    end;

    [Test]
    procedure GetBooleanValueByPathValueNotBoolean()
    var
        JSONHelperGM: Codeunit "JSON Helper GM";
        JSONObject: JsonObject;
        Value: Boolean;
        JSONPath: Text;
        JSONKey: Text;
        JSONValue: Text;
        ExpectedErr: Label 'Unable to convert from Microsoft.Dynamics.Nav.Runtime.NavJsonValue to System.Boolean', Locked = true;
    begin
        //[SCENARIO] Invoke GetValueByPath value for specified path which is not a JSONObject.

        //[GIVEN] A JSONKey
        JSONKey := Any.UnicodeText(10);

        //[GIVEN] A JSONPath.
        JSONPath := '$.' + JSONKey;

        //[GIVEN] A text JSONValue.
        JSONValue := Any.UnicodeText(10);

        //[GIVEN] A JSONObject with defined value for JSONPath which is not a boolean value.
        JSONObject.Add(JSONKey, JSONValue);

        //[WHEN] GetValueByPath method is invoked.
        //[THEN] An error occurs.
        asserterror JSONHelperGM.GetValueByPath(JSONObject, JSONPath, Value);
        LibraryAssert.ExpectedError(ExpectedErr);
    end;

    [Test]
    procedure GetBooleanValueByPath()
    var
        JSONHelperGM: Codeunit "JSON Helper GM";
        JSONObject: JsonObject;
        Value: Boolean;
        JSONPath: Text;
        JSONKey: Text;
        JSONValue: Boolean;
    begin
        //[SCENARIO] Invoke GetValueByPath for an existing path which value is a boolean.

        //[GIVEN] A JSONKey
        JSONKey := Any.UnicodeText(10);

        //[GIVEN] A JSONPath.
        JSONPath := '$.' + JSONKey;

        //[GIVEN] A boolean JSONValue
        JSONValue := Any.Boolean();

        //[GIVEN] A JSONObject with defined value for JSONPath which is a boolean value.
        JSONObject.Add(JSONKey, JSONValue);

        //[WHEN] GetValueByPath method is invoked.
        JSONHelperGM.GetValueByPath(JSONObject, JSONPath, Value);

        //[THEN] Restored boolean value is equal to previosuly defined boolean value.
        LibraryAssert.AreEqual(JSONValue, Value, '');
    end;

    [Test]
    procedure GetObjectByPathMissingPath()
    var
        JSONHelperGM: Codeunit "JSON Helper GM";
        JSONObject: JsonObject;
        RestoredJSONObject: JsonObject;
        JSONPath: Text;
    begin
        //[SCENARIO] Invoke GetObjectByPath method for undefined path.

        //[GIVEN] A JSONPath.
        JSONPath := LibraryJSONGM.RandomJsonPath(Any.IntegerInRange(1, 10));

        //[GIVEN] A JSONObject without defined JSONPath.
        //[WHEN] GetObjectByPath method is invoked.
        //[THEN] An error occures.
        asserterror JSONHelperGM.GetObjectByPath(JSONObject, JSONPath, RestoredJSONObject);
        LibraryAssert.ExpectedError(StrSubstNo(MissingJSONPathErr, JSONPath));
    end;

    [Test]
    procedure GetObjectByPathValueNotAJSONObject()
    var
        JSONHelperGM: Codeunit "JSON Helper GM";
        JSONObject: JsonObject;
        RestoredJSONObject: JsonObject;
        JSONPath: Text;
        JSONKey: Text;
    begin
        //[SCENARIO] Invoke GetObjectByPath value for specifed path which token is not a JSONObject.

        //[GIVEN] A JSONKey
        JSONKey := Any.UnicodeText(10);

        //[GIVEN] A JSONPath.
        JSONPath := '$.' + JSONKey;

        //[GIVEN] A JSONObject with defined value for JSONPath which is not an object.
        JSONObject.Add(JSONKey, Any.UnicodeText(10));

        //[WHEN] GetObjectByPath method is invoked.
        //[THEN] An error occures.
        asserterror JSONHelperGM.GetObjectByPath(JSONObject, JSONPath, RestoredJSONObject);
        LibraryAssert.ExpectedError(TokenNotAnObjectErr);
    end;

    [Test]
    procedure GetObjectByPath()
    var
        JSONHelperGM: Codeunit "JSON Helper GM";
        JSONObject: JsonObject;
        InnerJSONObject: JsonObject;
        RestoredJSONObject: JsonObject;
        JSONPath: Text;
        JSONKey: Text;
    begin
        //[SCENARIO] Invoke GetObjectByKey for and existing path which value is an object.

        //[GIVEN] A JSONKey
        JSONKey := Any.UnicodeText(10);

        //[GIVEN] A JSONPath.
        JSONPath := '$.' + JSONKey;

        //[GIVEN] A JSONObject with defined value for JSONPath which is an object.
        InnerJSONObject.Add(Any.UnicodeText(10), Any.UnicodeText(10));
        JSONObject.Add(JSONKey, InnerJSONObject);

        //[WHEN] GetObjectByPath method is invoked.
        JSONHelperGM.GetObjectByPath(JSONObject, JSONPath, RestoredJSONObject);

        //[THEN] Restored JSON Object is equal to previosuly created inner JSON Object.
        LibraryAssert.AreEqual(Format(InnerJSONObject), Format(RestoredJSONObject), '');
    end;

    [Test]
    procedure GetArrayByPathMissingPath()
    var
        JSONHelperGM: Codeunit "JSON Helper GM";
        JSONObject: JsonObject;
        RestoredJSONArray: JsonArray;
        JSONPath: Text;
    begin
        //[SCENARIO] Invoke GetArrayByPath method for undefined path.

        //[GIVEN] A JSONPath.
        JSONPath := LibraryJSONGM.RandomJsonPath(Any.IntegerInRange(1, 10));

        //[GIVEN] A JSONObject without defined JSONPath.
        //[WHEN] GetArrayByPath method is invoked.
        //[THEN] An error occures.
        asserterror JSONHelperGM.GetArrayByPath(JSONObject, JSONPath, RestoredJSONArray);
        LibraryAssert.ExpectedError(StrSubstNo(MissingJSONPathErr, JSONPath));
    end;

    [Test]
    procedure GetArrayByPathValueNotAJSONArray()
    var
        JSONHelperGM: Codeunit "JSON Helper GM";
        JSONObject: JsonObject;
        RestoredJSONArray: JsonArray;
        JSONPath: Text;
        JSONKey: Text;
    begin
        //[SCENARIO] Invoke GetArrayByPath value for specifed path which token is not a JSONArray.

        //[GIVEN] A JSONKey
        JSONKey := Any.UnicodeText(10);

        //[GIVEN] A JSONPath.
        JSONPath := '$.' + JSONKey;

        //[GIVEN] A JSONObject with defined value for JSONPath which is not an array.
        JSONObject.Add(JSONKey, Any.UnicodeText(10));

        //[WHEN] GetArrayByPath method is invoked.
        //[THEN] An error occures.
        asserterror JSONHelperGM.GetArrayByPath(JSONObject, JSONPath, RestoredJSONArray);
        LibraryAssert.ExpectedError(TokenNotAnArrayErr);
    end;

    [Test]
    procedure GetArrayByPath()
    var
        JSONHelperGM: Codeunit "JSON Helper GM";
        JSONObject: JsonObject;
        InnerJSONArray: JsonArray;
        RestoredJSONArray: JsonArray;
        JSONPath: Text;
        JSONKey: Text;
    begin
        //[SCENARIO] Invoke GetArrayByPath for and existing path which value is an array.

        //[GIVEN] A JSONKey
        JSONKey := Any.UnicodeText(10);

        //[GIVEN] A JSONPath.
        JSONPath := '$.' + JSONKey;

        //[GIVEN] A JSONObject with defined value for JSONPath which is an array.
        InnerJSONArray.Add(Any.UnicodeText(10));
        JSONObject.Add(JSONKey, InnerJSONArray);

        //[WHEN] GetArrayByPath method is invoked.
        JSONHelperGM.GetArrayByPath(JSONObject, JSONPath, RestoredJSONArray);

        //[THEN] Restored JSON Array is equal to previosuly created inner JSON Array.
        LibraryAssert.AreEqual(Format(InnerJSONArray), Format(RestoredJSONArray), '');
    end;

}