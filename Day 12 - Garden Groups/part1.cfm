<cfscript>
    lines = application.inputReader.getInput();

    garden = [];

    for (i = 1; i <= arrayLen(lines); i++)
    {
        line = listToArray(trim(lines[i]), "");
        arrayAppend(garden, line);
    }

    directions = 
    { 
        up = {x = 0, y = -1}, 
        down = {x = 0, y = 1}, 
        left = {x = 1, y = 0}, 
        right = {x = -1, y = 0} 
    };

    visited = {};

    fenceCost = 0;

    for (i = 1; i <= arrayLen(garden); i++)
    {
        for (j = 1; j <= arrayLen(garden[1]); j++)
        {
            area = {};
            perimeter = 0;

            if (!structKeyExists(visited, serializeJson([j, i])))
            {
                floodFill([j, i], garden[i][j]);
                fenceCost += structCount(area) * perimeter;
            }
        }
    }

    writeOutput(fenceCost);

    private function floodFill(array nodePosition, string nodeLetter)
    {   
        local.serializedPosition = serializeJSON(nodePosition);

        if (structKeyExists(area, serializedPosition))
        {
            return;
        }

        if (!inBounds(nodePosition) || garden[nodePosition[2]][nodePosition[1]] != nodeLetter)
        {
            perimeter++;
            return;
        }

        local.node = garden[nodePosition[2]][nodePosition[1]];

        area[serializedPosition] = 1;
        visited[serializedPosition] = 1;

        floodFill([nodePosition[1] + directions.up.x, nodePosition[2] + directions.up.y], node);
        floodFill([nodePosition[1] + directions.down.x, nodePosition[2] + directions.down.y], node);
        floodFill([nodePosition[1] + directions.left.x, nodePosition[2] + directions.left.y], node);
        floodFill([nodePosition[1] + directions.right.x, nodePosition[2] + directions.right.y], node);

        return;
    }

    private boolean function inBounds(array pos)
    {
        return (pos[1] >= 1) && (pos[1] <= arrayLen(garden[1])) && (pos[2] >= 1) && (pos[2] <= arrayLen(garden));
    }

</cfscript>

<!--- Answer: 1533644 --->