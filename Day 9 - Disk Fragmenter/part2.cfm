<cfscript>
    line = application.inputReader.getInput()[1];

    disk = [];
    id = 0;
    checksum = 0;

    freeSpaces = structNew("ordered");
    files = structNew("ordered");

    for (i = 1; i <= len(line); i++)
    {
        number = val(mid(line, i, 1));
        append = id;

        if (i % 2 == 0)
        {
            append = ".";
            id++;
        }

        temp = [];

        for (j = 1; j <= number; j++)
        {
            arrayAppend(temp, append);
        }

        arrayAppend(disk, temp);
        
        if (append == ".")
        {
            freeSpaces[arrayLen(disk)] = duplicate(temp);
        }
        else
        {
            files[arrayLen(disk)] = duplicate(temp);
        }
    }

    reverseFiles = structNew("ordered");
    structKeys = structKeyArray(files);
    arraySort(structkeys, "numeric", "desc");

    for (key in structKeys)
    {
        reverseFiles[key] = files[key];
    }

    for (fileIndex in reverseFiles)
    {
        file = reverseFiles[fileIndex];
        
        for (spaceIndex in freeSpaces)
        {
            space = freeSpaces[spaceIndex];

            if (spaceIndex < fileIndex && arrayLen(space) >= arrayLen(file))
            {
                startIndex = arrayFind(disk[spaceIndex], ".");

                for (i = 1; i <= arrayLen(file); i++)
                {
                    disk[spaceIndex][startIndex] = file[i];
                    arrayDeleteAt(space, 1);
                    disk[fileIndex][i] = ".";
                    startIndex++;
                }
               
                break;
            }
        }
    }

    diskArray = [];

    for (file in disk)
    {
        for (value in file)
        {
            arrayAppend(diskArray, value);
        }
    }

    for (i = 1; i <= arrayLen(diskArray); i++)
    {
        if (diskArray[i] != ".")
        {
            checksum += (i - 1) * diskArray[i];
        }
    } 

    writeOutput(checksum);
</cfscript>

<!--- Answer: 6493634986625 --->