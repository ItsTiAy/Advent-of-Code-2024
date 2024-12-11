<cfscript>
    line = application.inputReader.getInput()[1];

    stones = listToArray(line, " ");
    blinks = 25;

    currentStones = stones;

    for (i = 1; i <= blinks; i++)
    {      
        newStones = [];

        for (stone in currentStones)
        {
            if (stone == "0")
            {
                arrayAppend(newStones, 1);
            }
            else if (len(stone) % 2 == 0)
            {
                left = val(left(stone, len(stone) / 2));
                right = val(right(stone, len(stone) / 2));

                arrayAppend(newStones, [left, right], true);
            }
            else
            {
                arrayAppend(newStones, val(stone) * 2024);
            }
        }

        currentStones = newStones;
    }

    writeOutput(arrayLen(currentStones));

</cfscript>

<!--- Answer: 199982 --->