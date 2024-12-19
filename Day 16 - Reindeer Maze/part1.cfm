<cfscript>
    lines = application.inputReader.getInput();

    maze = arrayNew(2);

    for (i = 1; i <= arrayLen(lines); i++)
    {
        row = listToArray(trim(lines[i]), "");
        maze[i] = row;

        startPos = arrayFind(row, "S");
        endPos = arrayFind(row, "E");

        if (startPos > 0)
        {
            start = {x = startPos, y = i};
            maze[i][startPos] = "."
        }

        if (endPos > 0)
        {
            end = {x = endPos, y = i};
            maze[i][endPos] = "."
        }
    }

    directions = 
    [
        {x = -1, y = 0, name = "left"},
        {x = 0, y = -1, name = "up"},
        {x = 1, y = 0, name = "right" },
        {x = 0, y = 1, name = "down"}
    ];

    score = BFS(maze, start, end);

    writeOutput(score);

    private function BFS(maze, start, end)
    {
        queue = 
        [{
            x = start.x, 
            y = start.y,
            direction = "right",
            length = 0,
            turns = 0
        }];

        visited = structNew();

        while (!arrayIsEmpty(queue)) 
        {
            arraySort(queue, function(a, b)
            {
                if (a.turns < b.turns)
                {
                    return -1;
                }
                else if (a.turns > b.turns)
                {
                    return 1;
                }
                else if (a.length < b.length)
                {
                    return -1;
                }
                else if (a.length > b.length)
                {
                    return 1;
                }
                else
                {
                    return 0;
                }
            });
            
            current = arrayShift(queue);

            if (current.x == end.x && current.y == end.y)
            {
                return (current.turns * 1000) + current.length;
            }
            
            if (!structKeyExists(visited, current.y)) 
            {
                visited[current.y] = structNew();
            }

            if (!structKeyExists(visited[current.y], current.x)) 
            {
                visited[current.y][current.x] = structNew();
            }

            if (structKeyExists(visited[current.y][current.x], current.direction))
            {
                continue;
            }

            visited[current.y][current.x][current.direction] = true;
    
            for (direction in directions)
            {
                newX = current.x + direction.x;
                newY = current.y + direction.y;

                if (maze[newY][newX] == ".")
                {
                    newTurns = current.turns + (direction.name != current.direction);
                    arrayAppend(queue, {x = newX, y = newY, direction = direction.name, length = current.length + 1, turns = newTurns});
                }
            }
        }
    }
</cfscript>

<!--- Answer: 143580 --->