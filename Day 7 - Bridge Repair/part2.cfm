<cfscript>
    values = fileRead("input.txt");
    lines = listToArray(values, Chr(10));

    equations = arrayNew(2);

    for (i = 1; i <= arrayLen(lines); i++)
    {
        line = listToArray(lines[i], ":");
        equations[i][1] = trim(line[1]);
        equations[i][2] = listToArray(line[2], " ");
    }

    operators = ["*", "+", "||"];

    total = 0;
    
    for (equation in equations)
    {
        for (j = 1; j <= arrayLen(operators) ^ (arrayLen(equation[2]) - 1); j++)
        {
            nums = equation[2];
            expression = [];
            binary = reverse(right(repeatString("0", arrayLen(equation[2]) - 1) & formatBaseN(j, arrayLen(operators)), arrayLen(equation[2]) - 1));

            for (i = 1; i <= arrayLen(nums); i++)
            {
                arrayAppend(expression, nums[i]);
                
                if (i < arrayLen(nums))
                {
                    arrayAppend(expression, operators[mid(binary, i, 1) + 1]);
                }
            }

            if (customEvaluate(expression) == val(equation[1]))
            {
                total += equation[1];
                break;
            }
        }
    }

    private number function customEvaluate(array expression)
    {
        solution = expression[1];
        
        for (i = 2; i <= arrayLen(expression); i += 2)
        {
            switch (expression[i]) {
                case "+":
                    solution = solution + expression[i + 1]
                    break;
                case "*":
                    solution = solution * expression[i + 1]
                    break;
                case "||":
                    solution = solution & expression[i + 1]
                    break;
                default:                 
            }
        }
        
        return solution;
    }

    writeOutput(total);
</cfscript>

<!--- Answer: 124060392153684 --->