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
            if (current == "A")
            {
                xmasNum += CheckAround(x, y);
            }
        }
    }

    private number function CheckAround(required number currentX, required number currentY) 
    {
        currentXmasNum = 0;
        
        try 
        {
            topLeft = wordSearch[currentX - 1][currentY - 1];
            bottomRight = wordSearch[currentX + 1][currentY + 1];
            bottomLeft = wordSearch[currentX - 1][currentY + 1];
            topRight = wordSearch[currentX + 1][currentY - 1];

            if (((topLeft == "M" && bottomRight == "S") OR
                (topLeft == "S" && bottomRight == "M")) && 
                ((bottomLeft == "M" && topRight == "S") OR
                (bottomLeft == "S" && topRight == "M")))
            {
                currentXmasNum++;
            }
        }
        catch (any e)
        {
            return currentXmasNum;
        }

        return currentXmasNum;
    }

    writeOutput(xmasNum);
</cfscript>

<!--- Answer: 1908--->