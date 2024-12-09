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
        if (isSafe(report))
        {
            safeReports++;
            continue;
        }
        
        for (i = 1; i <= arrayLen(report); i++)
        {
            tempReport = duplicate(report);
            arrayDeleteAt(tempReport, i);
            
            if (isSafe(tempReport))
            {
                safeReports++;
                break;
            }
        }
    }

    writeOutput(safeReports);

    private boolean function isSafe(required array currentReport)
    {
        if (currentReport[1] == currentReport[2])
        {
            return false;
        }

        safe = true;

        if (currentReport[1] > currentReport[2])
        {
            firstBound = 3;
            secondBound = 1;
        }
        else
        {
            firstBound = -1;
            secondBound = -3;   
        }

        for (j = 1; j <= arrayLen(currentReport) - 1; j++)
        {
            difference = val(currentReport[j]) - val(currentReport[j + 1]);

            if ((difference > firstBound) || (difference < secondBound))
            {
                safe = false;
                break;
            }
        }

        return safe;
    }
</cfscript>

<!--- Answer: 328 --->