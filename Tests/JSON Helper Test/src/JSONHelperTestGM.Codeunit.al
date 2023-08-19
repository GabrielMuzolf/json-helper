codeunit 97000 "JSON Helper Test GM"
{
    Subtype = Test;

    var
        Any: Codeunit Any;
        LibraryAssert: Codeunit "Library Assert";

    [Test]
    procedure IsEmptyNullObject();
    var
        JSONHelperGM: Codeunit "JSON Helper GM";
        JSONObject: JsonObject;
    begin
        //[SCENARIO] Run IsEmpty method for an empty JSON Object.

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
        //[SCENARIO] Run IsEmpty method for a non-empty JSON Object.

        //[GIVEN] A non-empty JSONObject.
        JSONObject.Add(Any.UnicodeText(10), Any.UnicodeText(10));

        //[WHEN] IsEmpty method is invoked.
        //[THEN] The method returns false.
        LibraryAssert.IsFalse(JSONHelperGM.IsEmpty(JSONObject), '');
    end;
}