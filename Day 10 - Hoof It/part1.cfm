<cfscript>
    lines = application.inputReader.getInput();

    map = arrayNew(2);
    startPoints = [];

    for (i = 1; i <= arrayLen(lines); i++)
    {
        rowArray = [];
        for (j = 1; j <= len(lines[i]); j++)
        {
            arrayAppend(rowArray, mid(lines[i], j, 1));
            map[i][j] = rowArray[j];

            if (rowArray[j] == "0")
            {
                arrayAppend(startPoints, [j, i]);
            }
        }
    }
    
    directions = 
    { 
        up = {x = 0, y = -1}, 
        down = {x = 0, y = 1}, 
        left = {x = 1, y = 0}, 
        right = {x = -1, y = 0} 
    };
   
    totalScore = 0;

    for (point in startPoints)
    {
        score = 0;
        tops = {};

        findPath(point);

        totalScore += score;
    }
    
    writeOutput(totalScore);

    private function findPath(required array position)
    {
        for (direction in directions)
        {
            currentDir = directions[direction];
            nextPoint = [position[1] + currentDir.x, position[2] + currentDir.y]; 
            
            if (!inBounds(nextPoint))
            {
                continue;
            }
            
            currentValue = map[position[2]][position[1]];
            nextValue = map[nextPoint[2]][nextPoint[1]];     

            if (nextValue == (currentValue + 1))
            {
                if (nextValue == "9")
                {
                    trailhead = serializeJSON([nextPoint[1], nextPoint[2]]);
    
                    if (!structKeyExists(tops, trailhead))
                    {
                        tops[trailhead] = 1;
                        score++;
                    }
                }
                else
                {
                    findPath(nextPoint);
                }
            }
        }
    }

    private boolean function inBounds(array pos)
    {
        return (pos[1] >= 1) && (pos[1] <= arrayLen(map[1])) && (pos[2] >= 1) && (pos[2] <= arrayLen(map));
    }

</cfscript>

<!--- Answer: 461 --->