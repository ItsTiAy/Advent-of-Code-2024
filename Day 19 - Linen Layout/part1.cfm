<cfscript>
    lines = application.inputReader.getInput();

    towelPatterns = listToArray(lines[1], ",");
    designs = [];
    
    for (i = 3; i <= arrayLen(lines); i++)
    {
        arrayAppend(designs, lines[i]);
    }

    possibleDesigns = 0;
    cache = {};

    for (design in designs)
    {
        possibleDesigns += canMakeDesign(design); 
    }

    writeOutput(possibleDesigns);

    function canMakeDesign(inputDesign)
    {
        local.design = trim(inputDesign);

        if (design == "")
        {
            return 1;
        }

        if (structKeyExists(cache, design))
        {
            return cache[design];
        }
 
        for (p in towelPatterns)
        {
            pattern = trim(p);

            if (left(design, len(pattern)) == pattern)
            {
                if (canMakeDesign(mid(design, 1 + len(pattern))) == 1)
                {
                    cache[design] = 1;
                    return 1;
                }        
            }
        }
        
        cache[design] = 0;
        return 0;
    }
    
</cfscript>

<!--- Answer: 336 --->