<cfscript>
    lines = application.inputReader.getInput();

    total = 0
    out = [];

    for (line in lines)
    {
        arrayAppend(out, reFind("mul\(\d+,\d+\)", line, "1", true, "all"), true);
    }

    for(mul in out)
    {
        values = listToArray(mul.match[1], ",");
        a = mid(values[1], 5);
        b = mid(values[2], 1, Len(values[2]) - 1);
        total += (a * b);
    }

    writeOutput(total);
</cfscript>

<!--- Answer: 175615763 --->