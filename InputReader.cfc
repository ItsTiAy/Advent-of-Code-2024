component
{
    public array function getInput()
    {
        output = [];

        input = fileOpen(expandPath("input.txt"), "read");

        while (!fileIsEOF(input))
        {
            arrayAppend(output, trim(fileReadLine(input)));
        }

        fileClose(input);

        return output;
    }
}