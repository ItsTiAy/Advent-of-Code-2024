<cfscript>
    lines = application.inputReader.getInput();

    machines = [];
    tokens = 0;

    for (i = 1; i <= (arrayLen(lines) + 1) / 4; i++)
    {
        machine = [];

        for (j = 1; j <= 3; j++)
        {
            currentLine = lines[j + (4 * (i - 1))];
            start = find("X", currentLine);
            positions = listToArray(mid(currentLine, start), ", ");
            positions[1] = mid(positions[1], 3);
            positions[2] = mid(positions[2], 3);

            if (j == 3)
            {
                positions[1] += 10000000000000;
                positions[2] += 10000000000000;
            }

            arrayAppend(machine, positions);        
        }    

        arrayAppend(machines, [[machine[1][1], machine[2][1], machine[3][1]], [machine[1][2], machine[2][2], machine[3][2]]]);
    }

    for (machine in machines)
    {
        equationA = [];
        equationB = [];
        equationC = [];
        equationD = [];

        arrayAppend(equationA, machine[1][1] * machine[2][2]);
        arrayAppend(equationA, machine[1][2] * machine[2][2]);
        arrayAppend(equationA, machine[1][3] * machine[2][2]);

        arrayAppend(equationB, machine[2][1] * machine[1][2]);
        arrayAppend(equationB, machine[2][2] * machine[1][2]);
        arrayAppend(equationB, machine[2][3] * machine[1][2]);

        arrayAppend(equationC, equationA[1] - equationB[1]);
        arrayAppend(equationC, equationA[3] - equationB[3]);

        a = equationC[2] / equationC[1];
        
        arrayAppend(equationD, equationA[1] * a);
        arrayAppend(equationD, equationA[2]);
        arrayAppend(equationD, equationA[3]);

        b = (equationD[3] - equationD[1]) / equationD[2];

        tokensUsed = (a * 3) + b;

        if (tokensUsed == int(tokensUsed))
        {
            tokens += (a * 3) + b;
        }
    }

    writeOutput(tokens);

</cfscript>

<!--- Answer: 101726882250942 --->