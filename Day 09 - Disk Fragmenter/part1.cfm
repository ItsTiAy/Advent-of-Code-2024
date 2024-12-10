<cfscript>
    line = application.inputReader.getInput()[1];

    disk = [];
    id = 0;
    checksum = 0;

    freeSpaceIndexes = [];
    numberIndexes = [];

    for (i = 1; i <= len(line); i++)
    {
        number = val(mid(line, i, 1));
        append = id;

        if (i % 2 == 0)
        {
            append = ".";
            id++;
        }

        for (j = 1; j <= number; j++)
        {
            arrayAppend(disk, append);

            if (append == ".")
            {
                arrayAppend(freeSpaceIndexes, arrayLen(disk));
            }
            else
            {
                arrayAppend(numberIndexes, arrayLen(disk));
            }
        }
    }

    formattedDisk = duplicate(disk);
    numberIndexes = arrayReverse(numberIndexes);
    
    for (i = 1; i <= arrayLen(freeSpaceIndexes); i++)
    {
        frontIndex = freeSpaceIndexes[i];
        backIndex = numberIndexes[i];

        if (frontIndex >= backIndex)
        {
            break;
        }

        formattedDisk[frontIndex] = formattedDisk[backIndex];
        formattedDisk[backIndex] = ".";
    }

    for (i = 1; i <= arrayLen(numberIndexes); i++)
    {
        checksum += (i - 1) * formattedDisk[i];
    }
    
    writeOutput(checksum);
</cfscript>

<!--- Answer: 6463499258318 --->