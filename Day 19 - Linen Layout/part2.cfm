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
 
        local.total = 0;

        for (p in towelPatterns)
        {
            pattern = trim(p);

            if (left(design, len(pattern)) == pattern)
            {
                total += canMakeDesign(mid(design, 1 + len(pattern)));      
            }
        }
        
        cache[design] = total;
        return total;
    }
    
</cfscript>

<!--- Answer: 758890600222015 --->