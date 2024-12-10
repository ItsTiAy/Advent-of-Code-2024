<cfscript>
    rows = application.inputReader.getInput();

    xmasNum = 0;
    wordSearch = arrayNew(2);

    for (i = 1; i <= arrayLen(rows); i++)
    {
        rowArray = [];
        for (j = 1; j <= len(rows[i]); j++)
        {
            arrayAppend(rowArray, mid(rows[i], j, 1));
            wordSearch[i][j] = rowArray[j];
        }
    }

    for (y = 1; y <= arrayLen(wordSearch); y++)
    {
        for (x = 1; x <= arrayLen(wordSearch[y]); x++)
        {
            current = wordSearch[x][y];
            if (current == "X") 
            {
                xmasNum += CheckAround(x, y);
            }
        }
    }

    private number function CheckAround(required number currentX, required number currentY) 
    {
        offsets = 
        [
            {row = -1, col = 0},
            {row = -1, col = 1},
            {row = 0, col = 1},
            {row = 1, col = 1},
            {row = 1, col = 0},
            {row = 1, col = -1},
            {row = 0, col = -1},
            {row = -1, col = -1}
        ];

        currentXmasNum = 0;

        for (offset in offsets)
        {
            try
            {
                if (wordSearch[currentX + offset.row][currentY + offset.col] == "M" AND
                    wordSearch[currentX + (offset.row * 2)][currentY + (offset.col * 2)] == "A" AND
                    wordSearch[currentX + (offset.row * 3)][currentY + (offset.col * 3)] == "S") 
                {
                    currentXmasNum++;
                }
            } 
            catch (any e)
            {
                continue;
            }
        }
        
        return currentXmasNum;
    }

    writeOutput(xmasNum);
</cfscript>

<!--- Answer: 2370 --->