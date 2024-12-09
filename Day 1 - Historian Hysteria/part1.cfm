<cfscript>
    lines = application.inputReader.getInput();

    left = [];
    right = [];

    distance = 0;

    for (i = 1; i <= arrayLen(lines); i++)
    {
        line = listToArray(lines[i], "   ");
        arrayAppend(left, val(line[1]));
        arrayAppend(right, val(line[2]));
    }

    arraysort(left, "numeric", "asc");
    arraysort(right, "numeric", "asc");

    for (i = 1; i <= arrayLen(left); i++)
    {
        distance += abs(left[i] - right[i]);
    }

    writeOutput(distance);
</cfscript>

<!--- Answer: 1938424 --->