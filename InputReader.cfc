component displayName="InputReader"
{
    public array function getInput()
    {
        values = fileRead(expandPath("input.txt"));
        return listToArray(trim(values), Chr(10));
    }
}