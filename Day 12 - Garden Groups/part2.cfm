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
        right = {x = -1, y = 0},
        down = {x = 0, y = 1},
        left = {x = 1, y = 0}
    };

    visited = {};

    fenceCost = 0;

    for (i = 1; i <= arrayLen(garden); i++)
    {
        for (j = 1; j <= arrayLen(garden[1]); j++)
        {
            area = {};
            perimeter = [];
            corners = 0;

            if (!structKeyExists(visited, serializeJson([j, i])))
            {
                floodFill([j, i], garden[i][j]);

                for (point in area)
                {
                    corners += checkCorner(deserializeJSON(point))  
                }

                //sortPerimeter(perimeter);
                fenceCost += structCount(area) * corners;
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

    private boolean function checkCorner(array point)
    {
        return checkOuterCorner(point[1], point[2]) + checkInnerCorner(point[1], point[2]);
    }

    private numeric function checkOuterCorner(numeric x, numeric y)
    {
        local.upX = x + directions.up.x;
        local.rightX = x + directions.right.x;
        local.downX = x + directions.down.x;
        local.leftX = x + directions.left.x;

        local.upY = y + directions.up.y;
        local.rightY = y + directions.right.y;
        local.downY = y + directions.down.y;
        local.leftY = y + directions.left.y;

        local.corners = 0;

        if ((((!inBounds([upX, upY])) || (garden[upY][upX] != garden[y][x])) && ((!inBounds([rightX, rightY])) || (garden[rightY][rightX] != garden[y][x]))))
        {
            corners++;
        }
        
        if (((!inBounds([rightX, rightY])) || (garden[rightY][rightX] != garden[y][x])) && ((!inBounds([downX, downY])) || (garden[downY][downX] != garden[y][x]))) 
        {
            corners++;
        }

        if (((!inBounds([downX, downY])) || (garden[downY][downX] != garden[y][x])) && ((!inBounds([leftX, leftY])) || (garden[leftY][leftX]!= garden[y][x])))
        {
            corners++;
        }

        if (((!inBounds([leftX, leftY])) || (garden[leftY][leftX] != garden[y][x])) && ((!inBounds([upX, upY])) || (garden[upY][upX] != garden[y][x])))
        {
            corners++;
        }

        return corners;
    }

    private boolean function checkInnerCorner(numeric x, numeric y)
    {
        local.upX = x + directions.up.x;
        local.rightX = x + directions.right.x;
        local.downX = x + directions.down.x;
        local.leftX = x + directions.left.x;

        local.upY = y + directions.up.y;
        local.rightY = y + directions.right.y;
        local.downY = y + directions.down.y;
        local.leftY = y + directions.left.y;

        local.corners = 0;
  
        if ((((inBounds([upX, upY])) && (garden[upY][upX] == garden[y][x])) && ((inBounds([rightX, rightY])) && (garden[rightY][rightX] == garden[y][x])) && ((inBounds([x - 1, y - 1])) && (garden[y - 1][x - 1] != garden[y][x]))))
        {
            corners++;
        }
        
        if ((((inBounds([rightX, rightY])) && (garden[rightY][rightX] == garden[y][x])) && ((inBounds([downX, downY])) && (garden[downY][downX] == garden[y][x])) && ((inBounds([x - 1, y + 1])) && (garden[y + 1][x - 1] != garden[y][x]))))
        {
            corners++;
        }

        if ((((inBounds([downX, downY])) && (garden[downY][downX] == garden[y][x])) && ((inBounds([leftX, leftY])) && (garden[leftY][leftX] == garden[y][x])) && ((inBounds([x + 1, y + 1])) && (garden[y + 1][x + 1] != garden[y][x]))))
        {
            corners++;
        }

        if ((((inBounds([leftX, leftY])) && (garden[leftY][leftX] == garden[y][x])) && ((inBounds([upX, upY])) && (garden[upY][upX] == garden[y][x])) && ((inBounds([x + 1, y - 1])) && (garden[y - 1][x + 1] != garden[y][x]))))
        {
            corners++;
        }

        return corners;
    }

</cfscript>

<!--- Answer: 936718 --->