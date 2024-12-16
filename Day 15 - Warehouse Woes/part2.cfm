<cfscript>
    lines = application.inputReader.getInput();

    map = arrayNew(2);
    instructions = "";
    currentPos = [];

    splitIndex = arrayFind(lines, "");

    for (i = 1; i < splitIndex; i++)
    {
        row = listToArray(trim(lines[i]), "");
        doubleRow = [];

        for (j = 1; j <= arrayLen(row); j++)
        {
            col = row[j];

            if (col == "O")
            {
                arrayAppend(doubleRow, ["[", "]"], true);
            }
            else if (col == "@")
            {
                arrayAppend(doubleRow, ["@", "."], true);
            }
            else
            {
                arrayAppend(doubleRow, [col, col], true);    
            }

            startPos = arrayFind(doubleRow, "@");

            if (startPos > 0)
            {
                currentPos = [startPos, i];
            }
        }

        map[i] = doubleRow;
    }

    for (i = splitIndex + 1; i <= arrayLen(lines); i++)
    {
        instructions &= trim(lines[i]);
    }

    directions = 
    { 
        "^" = {x = 0, y = -1}, 
        "v" = {x = 0, y = 1}, 
        ">" = {x = 1, y = 0}, 
        "<" = {x = -1, y = 0} 
    };

    previousMap = duplicate(map);

    for (i = 1; i <= len(instructions); i++)
    {         
        currentDir = directions[mid(instructions, i, 1)];

        newPos = [currentPos[1] + currentDir.x, currentPos[2] + currentDir.y];
        newPosTile = map[newPos[2]][newPos[1]];

        if (newPosTile == "." || ((newPosTile == "[" || newPosTile == "]") && push(newPos, currentDir)))
        {
            map[newPos[2]][newPos[1]] = "@";
            map[currentPos[2]][currentPos[1]] = ".";

            currentPos = newPos;
            previousMap = duplicate(map);
        }
        else
        {
            map = duplicate(previousMap);
        }
    }

    total = 0;

    for (i = 1; i <= arrayLen(map); i++)
    {
        boxes = arrayFindAll(map[i], "[");

        for (box in boxes)
        {
            total += (100 * (i - 1)) + (box - 1);
        }
    }

    writeOutput(total);

    private boolean function push(array block, struct dir)
    {
        local.leftSide = [];
        local.rightSide = []

        if (map[block[2]][block[1]] == "[")
        {
            leftSide = block;
            rightSide = [block[1] + directions[">"].x, block[2] + directions[">"].y];
        }
        else
        {
            leftSide = [block[1] + directions["<"].x, block[2] + directions["<"].y];
            rightSide = block;
        }

        local.nextSpaceLeft = [leftSide[1] + dir.x, leftSide[2] + dir.y];
        local.nextSpaceRight = [rightSide[1] + dir.x, rightSide[2] + dir.y];

        local.nextSpaces = [];

        if (dir.x == -1 && dir.y == 0)
        {
            nextSpaces = [nextSpaceLeft];
        }
        else if (dir.x == 1 && dir.y == 0)
        {
            nextSpaces = [nextSpaceRight];
        }
        else
        {
            nextSpaces = [nextSpaceLeft, nextSpaceRight];
        }

        local.validMove = true;
        
        for (nextSpace in nextSpaces)
        {
            switch (map[nextSpace[2]][nextSpace[1]])
            {
                case "##":
                    validMove = false;
                    break;
                case "[":
                case "]":
                    validMove = push(nextSpace, dir);             
                    break;
            }

            if (!validMove)
            {
                break;
            }
        }

        if (validMove)
        {
            map[leftSide[2]][leftSide[1]] = ".";
            map[rightSide[2]][rightSide[1]] = ".";
            map[leftSide[2] + dir.y][leftSide[1] + dir.x] = "[";
            map[rightSide[2] + dir.y][rightSide[1] + dir.x] = "]"; 
        }
    
        return validMove;
    }
</cfscript>

<!--- Answer: 1519202 --->