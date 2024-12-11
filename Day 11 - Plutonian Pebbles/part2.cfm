<cfscript>
    line = application.inputReader.getInput()[1];

    numbers = listToArray(line, " ");

    totalStones = 0;

    for (number in numbers)
    {
        totalStones += processStone(trim(number), 75);
    }

    writeOutput(totalStones);

    private function processStone(numeric number, numeric blinks, struct memo = {})
    {
        if (blinks == 0)
        {   
            return 1;
        }

        local.key = number & "|" & blinks;

        if (structKeyExists(memo, key))
        {
            value = memo[key];
            return value;
        }
        
        local.count = 0;
        
        for (stone in blink(number))
        {
            count += processStone(stone, blinks - 1, memo);
        }

        memo[key] = count;
        return count;
    }

    private array function blink(stone)
    {
        if (stone == "0")
        {
            return [1];
        }
        else if (len(stone) % 2 == 0)
        {
            local.left = left(stone, len(stone) / 2);
            local.right = right(stone, len(stone) / 2);

            return [val(left), val(right)];
        }
        else
        {
            return [val(stone) * 2024];
        }
    }
</cfscript>

<!--- Answer: 237149922829154 --->