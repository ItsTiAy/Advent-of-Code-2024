<cfscript>
    lines = application.inputReader.getInput();

    positions = [];
    velocities = [];

    for (line in lines)
    {
        values = reMatch("-?\d+", line);
        arrayAppend(positions, [values[1], values[2]]);
        arrayAppend(velocities, [values[3], values[4]]);
    }

    width = 101;
    height = 103;

    for (i = 1; i <= 100; i++)
    {
        for (j = 1; j <= arrayLen(positions); j++)
        {
            positions[j][1] = ((positions[j][1] + velocities[j][1]) % width + width) % width;
            positions[j][2] = ((positions[j][2] + velocities[j][2]) % height + height) % height;
        }
    }

    widthCenter = ((width - 1) / 2);
    heightCenter = ((height - 1) / 2);
    
    quadrants = [0, 0, 0, 0];

    for (position in positions)
    {

        if (position[1] < widthCenter && position[2] < heightCenter)
        {
            quadrants[1]++;
        }
        else if (position[1] > widthCenter && position[2] < heightCenter)
        {
            quadrants[2]++;
        }
        else if (position[1] > widthCenter && position[2] > heightCenter)
        {
            quadrants[3]++;
        }
        else if (position[1] < widthCenter && position[2] > heightCenter)
        {
            quadrants[4]++;
        }
    }

    safteyFactor = quadrants[1] * quadrants[2] * quadrants[3] * quadrants[4];

    writeOutput(safteyFactor);
</cfscript>

<!--- Answer: 209409792 --->