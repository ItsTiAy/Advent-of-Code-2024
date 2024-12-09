<cfscript>
    lines = application.inputReader.getInput();

    total = 0
    add = true;
    items = [];

    for (line in lines)
    {
        arrayAppend(items, reFind("mul\(\d+,\d+\)|don't\(\)|do\(\)", line, "1", true, "all"), true);
    }

    for (item in items)
    {
        word = item.match[1];
        
        if (word == "don't()")
        {
            add = false;
            continue;
        }
        else if (word == "do()")
        {
            add = true;
            continue;
        }

        if (add)
        {
            values = listToArray(word, ",");
            a = mid(values[1], 5);
            b = mid(values[2], 1, len(values[2]) - 1);
            total += (a * b);
        }
    }

    writeOutput(total);
</cfscript>

<!--- Answer: 74361272 --->