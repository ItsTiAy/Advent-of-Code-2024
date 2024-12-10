<cfscript>
    values = fileRead("input.txt");
    lines = listToArray(values, Chr(10));

    myGrid = arrayNew(2);

    directions = [[-1, 0], [0, 1], [1, 0], [0, -1]];

    for (i = 1; i <= arrayLen(lines); i++)
    {
        mapGrid[i] = listToArray(trim(lines[i]), "");
        startX = arrayFind(mapGrid[i], "^");
        if (startX > 0)
        {
            start = [i, startX];
        }
    }

    newVisited = {};
    visited = simulate(mapGrid, start);

    loopCounter = 0;

    for (tile in visited)
    {
        obstaclePos = deserializeJson(tile);

        if (mapGrid[obstaclePos[1]][obstaclePos[2]] == "^")
        {
            continue;
        }
        
        mapGrid[obstaclePos[1]][obstaclePos[2]] = "##";
    
        if (structCount(simulate(mapGrid, start)) == 0)
        {
            loopCounter++;
        }
    
        mapGrid[obstaclePos[1]][obstaclePos[2]] = ".";
    }

    private struct function simulate(array grid, array currentPos)
    {    
        dirIndex = 1;
        structClear(newVisited);
        newVisited[serializeJSON(currentPos)] = dirIndex;
    
        while (true)
        {
            currentDir = directions[dirIndex];
            nextPos = [currentPos[1] + currentDir[1], currentPos[2] + currentDir[2]];
    
            if ((nextPos[1] < 1) || (nextPos[1] > arrayLen(mapGrid)) || (nextPos[2] < 1) || (nextPos[2] > arrayLen(mapGrid[1])))
            {
                return newVisited;
            }
    
            if (mapGrid[nextPos[1]][nextPos[2]] == "##")
            {
                dirIndex = (dirIndex % 4) + 1;
            }
            else
            {         
                currentPos = nextPos;
                serializedPos = serializeJSON(currentPos);        
    
                if (structKeyExists(newVisited, serializedPos) && (newVisited[serializedPos] == dirIndex))
                {
                    return {};
                }
    
                newVisited[serializedPos] = dirIndex;
            }
        }
    }

    writeOutput(loopCounter);
</cfscript>

<!--- Answer: 1767--->
