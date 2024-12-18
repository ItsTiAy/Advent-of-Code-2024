<cfscript>
    lines = application.inputReader.getInput();

    coordinates = [];
    map = arrayNew(2);
    mapSize = 70;
    bytes = 1024;

    start = {x = 1, y = 1};
    end = {x = 71, y = 71};

    for (line in lines)
    {
        arrayAppend(coordinates, listToArray(line, ",")); 
    }

    for (i = 1; i <= mapSize + 1; i++)
    {
        arraySet(map[i], 1, mapSize + 1, ".");
    }
    
    for (i = 1; i <= bytes; i++)
    {
        coordinate = coordinates[i];
        map[coordinate[2] + 1][coordinate[1] + 1] = "##";
    }

    bestPath = bfs(map, start, end);

    writeOutput(arrayLen(bestPath) - 1);

    private function BFS(maze, start, end)
    {
        var directions = 
        [
            {x = 0, y = -1, name = "up"},
            {x = 0, y = 1, name = "down"},
            {x = -1, y = 0, name = "left"},
            {x = 1, y = 0, name = "right" }
        ];

        queue = 
        [{
            x = start.x, 
            y = start.y,
            path = 
            [{
                x = start.x, 
                y = start.y
            }]
        }];

        visited = arrayNew(2);

        for (var i = 1; i <= arrayLen(maze); i++)
        {
            arraySet(visited[i], 1, arrayLen(maze[i]), false);
        }

        visited[start.y + 1][start.x + 1] = true;

        while (!arrayIsEmpty(queue)) 
        {
            current = arrayShift(queue);
    
            if (current.x == end.x && current.y == end.y)
            {
                return current.path;
            }
    
            for (direction in directions)
            {
                newX = current.x + direction.x;
                newY = current.y + direction.y;

                if (newY >= 1 && newY <= arrayLen(maze) && newX >= 1 && newX <= arrayLen(maze[newY]) && maze[newY][newX] == "." && !visited[newY][newX])
                {
                    visited[newY][newX] = true;
                    newPath = duplicate(current.path);
                    arrayAppend(newPath, {x = newX, y = newY})
                    arrayAppend(queue, {x = newX, y = newY, path = newPath});
                }
            }
        }

        return [];
    }
</cfscript>

<!--- Answer: 288 --->