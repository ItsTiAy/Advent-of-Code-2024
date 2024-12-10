<cfscript>
    lines = application.inputReader.getInput();

    safeReports = 0;
    reports = [];

    for (i = 1; i <= arrayLen(lines); i++)
    {
        line = listToArray(lines[i], " ");
        arrayAppend(reports, line);
    }

    for (report in reports)
    {
        if (report[1] == report[2])
        {
            continue;
        }

        safe = true;

        if (report[1] > report[2])
        {
            firstBound = 3;
            secondBound = 1;
        }
        else
        {
            firstBound = -1;
            secondBound = -3;   
        }

        for (i = 1; i <= arrayLen(report) - 1; i++)
        {
            difference = val(report[i]) - val(report[i + 1]);
            
            if ((difference > firstBound) || (difference < secondBound))
            {
                safe = false;
                break;
            }
        }

        if (safe)
        {
            safeReports++;
        }
    }

    writeOutput(safeReports);
</cfscript>

<!--- Answer: 257 --->