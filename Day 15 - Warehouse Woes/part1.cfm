<style>
    html
    {
        font-family: monospace;
    }
</style>

<cfscript>
    lines = application.inputReader.getInput();

    map = arrayNew(2);
    instructions = "";
    currentPos = [];

    splitIndex = arrayFind(lines, "");

    for (i = 1; i < splitIndex; i++)
    {
        row = listToArray(trim(lines[i]), "");

        startPos = arrayFind(row, "@");

        if (startPos > 0)
        {
            currentPos = [startPos, i];
        }

        map[i] = row;
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

    for (i = 1; i <= len(instructions); i++)
    {
        currentDir = directions[mid(instructions, i, 1)];

        newPos = [currentPos[1] + currentDir.x, currentPos[2] + currentDir.y];
        newPosTile = map[newPos[2]][newPos[1]];

        if (newPosTile == "." || (newPosTile == "O" && push(newPos, currentDir)))
        {
            map[newPos[2]][newPos[1]] = "@";
            map[currentPos[2]][currentPos[1]] = ".";

            currentPos = newPos;
        }
    }

    total = 0;

    for (i = 1; i <= arrayLen(map[1]); i++)
    {
        boxes = arrayFindAll(map[i], "O");

        for (box in boxes)
        {
            total += (100 * (i - 1)) + (box - 1);
        }
    }

    writeOutput(total);

    private boolean function push(array block, struct dir)
    {
        nextSpace = [block[1] + dir.x, block[2] + dir.y];

        switch (map[nextSpace[2]][nextSpace[1]])
        {
            case ".":
                map[nextSpace[2]][nextSpace[1]] = "O";
                return true;
            case "##":
                return false;
            case "O":
                return push(nextSpace, dir);
        }
    }
</cfscript>

<!--- Answer: 1490942 --->