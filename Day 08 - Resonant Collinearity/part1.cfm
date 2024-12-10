<cfscript>
    values = fileRead("input.txt");
    lines = listToArray(values, Chr(10));

    map = [];

    for (i = 1; i <= arrayLen(lines); i++)
    {
        line = listToArray(trim(lines[i]), "");
        arrayAppend(map, line);
    }

    antennas = structnew("casesensitive");
    antennaPairs = structNew("casesensitive");
    uniqueLocations = {};

    for (y = 1; y <= arrayLen(map); y++)
    {    
        row = map[y];
        for (x = 1; x <= arrayLen(row); x++)
        {
            if (row[x] != ".")
            {
                if (!structKeyExists(antennas, row[x]))
                {
                    antennas[row[x]] = [];
                }

                arrayAppend(antennas[row[x]], [x, y]);
            }
        }
    }

    antennas.each(function(key, value)
    {
        antennaPairs[key] = [];

        for (i = 1; i <= arrayLen(value); i++)
        {
            for (j = i + 1; j <= arrayLen(value); j++)
            {
                y = value[i][2] - value[j][2];
                x = value[i][1] - value[j][1];

                position = [value[i][1] + x, value[i][2] + y];
                serializedPositon = serializeJSON(position);

                if (inBounds(position) && !structKeyExists(uniqueLocations, serializedPositon))
                {
                    uniqueLocations[serializedPositon] = 1;
                }

                position = [value[j][1] - x, value[j][2] - y];
                serializedPositon = serializeJSON(position);

                if (inBounds(position) && !structKeyExists(uniqueLocations, serializedPositon))
                {
                    uniqueLocations[serializedPositon] = 1;
                }               

                arrayAppend(antennaPairs[key], [value[i], value[j]]);
            }
        }
    });
    
    private boolean function inBounds(array pos)
    {
        return (pos[1] >= 1) && (pos[1] <= arrayLen(map[1])) && (pos[2] >= 1) && (pos[2] <= arrayLen(map));
    }

    writeOutput(structCount(uniqueLocations));
</cfscript>

<!--- Answer: 303 --->