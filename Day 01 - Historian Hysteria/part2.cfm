<cfscript>
    lines = application.inputReader.getInput();

    left = [];
    right = [];

    similarity = 0;
    instances = {};

    for (i = 1; i <= arrayLen(lines); i++)
    {
        line = listToArray(lines[i], "   ");
        arrayAppend(left, val(line[1]));
        arrayAppend(right, val(line[2]));
    }

    for (key in right)
    {
        if (!structKeyExists(instances, key))
        {
            instances[key] = 0;
        }

        instances[key]++;    
    }

    for (key in left)
    {
        if (structKeyExists(instances, key))
        {
            similarity += instances[key] * key;
        }
    }

    writeOutput(similarity);
</cfscript>

<!--- Answer 22014209 --->