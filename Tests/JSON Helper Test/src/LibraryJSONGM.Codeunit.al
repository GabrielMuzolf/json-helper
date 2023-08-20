codeunit 97001 "Library - JSON GM"
{
    var
        Any: Codeunit Any;

    /// <summary>
    /// Generates a random JSON path with the specified length.
    /// </summary>
    /// <param name="PathLength">The desired length of the generated JSON path.</param>
    /// <returns>A randomly generated JSON path as a Text value.</returns>
    procedure RandomJsonPath(PathLength: Integer) JSONPath: Text
    var
        i: Integer;
    begin
        JSONPath := '$';
        if PathLength < 1 then
            exit;

        for i := 1 to PathLength do
            JSONPath += '.' + Any.UnicodeText(10);
    end;
}