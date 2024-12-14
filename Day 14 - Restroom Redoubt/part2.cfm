<style>
    #grid
    {
        display: grid;
        grid-template-columns: repeat(101, 8px);
        gap: 0px;
    }

    .cell 
    {
        width: 8px;
        height: 8px;
    }
</style>

<cfscript>
    lines = application.inputReader.getInput();

    positions = [];
    velocities = [];

    iterations = 7950;

    for (line in lines)
    {
        values = reMatch("-?\d+", line);
        arrayAppend(positions, [values[1], values[2]]);
        arrayAppend(velocities, [values[3], values[4]]);
    }

    width = 101;
    height = 103;

    if (structKeyExists(form, "jsonData"))
    {
        positions = deserializeJSON(form.jsonData);
        iterations = form.iterations;
    }

    bathroom = [];

    arraySet(bathroom, 1, width, []);

    for (row in bathroom)
    {
        arraySet(row, 1, height, 0);
    }

    for (j = 1; j <= arrayLen(positions); j++)
    {
        if (structKeyExists(form, "jsonData"))
        {
            positions[j][1] = ((positions[j][1] + velocities[j][1]) % width + width) % width;
            positions[j][2] = ((positions[j][2] + velocities[j][2]) % height + height) % height;
        }
        else
        {
            positions[j][1] = ((positions[j][1] + (velocities[j][1]) * iterations) % width + width) % width;
            positions[j][2] = ((positions[j][2] + (velocities[j][2]) * iterations) % height + height) % height;
        }

        bathroom[positions[j][1] + 1][positions[j][2] + 1]++;
    }
</cfscript>

<cfoutput>
    <div id="grid">
        <cfloop from="1" to="#arrayLen(bathroom)#" index="row">
            <div>
                <cfloop from="1" to="#arrayLen(bathroom[1])#" index="col">
                    <div id="cell_#row#_#col#" class="cell" style="background-color: #(bathroom[row][col] == 0 ? 'white' : 'black')#"></div>
                </cfloop>
            </div>
        </cfloop>
    </div>

    <form method="post">
        <input type="hidden" name="iterations" value="<cfoutput>#iterations + 1#</cfoutput>">
        <input type="hidden" name="jsonData" value='<cfoutput>#serializeJSON(positions)#</cfoutput>'>
        <button id="step" type="submit">Step</button>
    </form>
</cfoutput>

<cfoutput>#iterations#</cfoutput>

<script>
    async function step()
    {
        var btn = document.getElementById("step");
    
        if (<cfoutput>#iterations#</cfoutput> < 8006)
        {
            await new Promise(r => setTimeout(r, 1));
            btn.click();
        }
    }

    step();
</script>

<!--- Answer: 8006 --->
