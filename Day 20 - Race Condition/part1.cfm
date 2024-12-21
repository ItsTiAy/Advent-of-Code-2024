<cfscript>
    lines = application.inputReader.getInput();

    coordinates = [];
    map = arrayNew(2);

    for (i = 1; i <= arrayLen(lines); i++)
    {
        row = listToArray(trim(lines[i]), "");
        map[i] = row;

        startPos = arrayFind(row, "S");
        endPos = arrayFind(row, "E");

        if (startPos > 0)
        {
            start = {x = startPos, y = i};
            map[i][startPos] = "."
        }

        if (endPos > 0)
        {
            end = {x = endPos, y = i};
            map[i][endPos] = "."
        }
    }

    directions = 
    [
        {x = 0, y = -1, name = "up"},
        {x = 0, y = 1, name = "down"},
        {x = -1, y = 0, name = "left"},
        {x = 1, y = 0, name = "right" }
    ];

    bestPath = bfs(map, start, end);
    baseTime = arrayLen(bestPath) - 1; 

    savedTime = structNew();

    shortcutsChecked = {};

    for (i = 1; i <= baseTime; i++)
    {
        point = bestPath[i];

        for (direction in directions)
        {
            newPoint = {x = point.x + (2 * direction.x), y = point.y + (2 * direction.y)};

            if (inBounds(newPoint, map))
            {
                if (map[newPoint.y][newPoint.x] == "##")
                {
                    continue;
                }
    
                shortcutsChecked[serializeJSON(newPoint)] = true;

                pointIndex = arrayFind(bestPath, newPoint);

                if (pointIndex > 0)
                {
                    newTime = baseTime - (arrayLen(bestPath) - pointIndex + i + 1);

                    if (newTime >= 100)
                    {
                        if (structKeyExists(savedTime, newTime))
                        {
                            savedTime[newTime]++;
                        }
                        else
                        {
                            savedTime[newTime] = 1;
                        }
                    }
                }
            }
        }
    }

    numberOfCheats = 0;

    for (time in savedTime)
    {
        numberOfCheats += savedTime[time];
    }

    writeOutput(numberOfCheats);

    private function BFS(maze, start, end)
    {
        local.queue = 
        [{
            x = start.x, 
            y = start.y,
            path = 
            [{
                x = start.x, 
                y = start.y
            }]
        }];

        local.visited = arrayNew(2);

        for (var i = 1; i <= arrayLen(maze); i++)
        {
            arraySet(visited[i], 1, arrayLen(maze[i]), false);
        }

        visited[start.y + 1][start.x + 1] = true;

        while (!arrayIsEmpty(queue)) 
        {
            local.current = arrayShift(queue);
    
            if (current.x == end.x && current.y == end.y)
            {
                return current.path;
            }
    
            for (dir in directions)
            {
                local.newX = current.x + dir.x;
                local.newY = current.y + dir.y;

                if (newY >= 1 && newY <= arrayLen(maze) && newX >= 1 && newX <= arrayLen(maze[newY]) && maze[newY][newX] == "." && !visited[newY][newX])
                {
                    visited[newY][newX] = true;
                    local.newPath = duplicate(current.path);
                    arrayAppend(newPath, {x = newX, y = newY})
                    arrayAppend(queue, {x = newX, y = newY, path = newPath});
                }
            }
        }

        return [];
    }

    private boolean function inBounds(struct pos, array map)
    {
        return (pos.x >= 1) && (pos.x <= arrayLen(map[1])) && (pos.y >= 1) && (pos.y <= arrayLen(map));
    }
</cfscript>

<!--- Answer: 1296 --->