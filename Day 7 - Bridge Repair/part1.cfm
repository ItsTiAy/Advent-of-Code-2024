<cffile action="read" file="input.txt" variable="values">
<cfset lines = listToArray(values, Chr(10))>

<cfset equations = arrayNew(2)>

<cfloop index="i" from="1" to="#arrayLen(lines)#">
    <cfset line = listToArray(lines[i], ":")>
    <cfset equations[i][1] = line[1]>
    <cfset equations[i][2] = listToArray(line[2], " ")>
</cfloop>

<cfset operators = ["*", "+"]>

<cfset total = 0>

<cfloop item="equation" array="#equations#">
    <cfloop index="j" from="1" to="#arrayLen(operators) ^ (arrayLen(equation[2]) - 1)#">
        <cfset values = equation[2]>
        <cfset expression = []>
        <cfset binary = reverse(right(repeatString("0", arrayLen(equation[2]) - 1) & formatBaseN(j, arrayLen(operators)), arrayLen(equation[2]) - 1))>
        <cfloop index="i" from="1" to="#arrayLen(values)#">
            <cfset arrayAppend(expression, values[i] & ")")>
            <cfset arrayInsertAt(expression, 1, "(")>
            <cfif i LT arrayLen(values)>
                <cfset arrayAppend(expression, operators[mid(binary, i, 1) + 1])>
            </cfif>
        </cfloop>
        <cfif evaluate(arrayToList(expression, "")) EQ val(equation[1])>
            <cfset total += equation[1]>
            <cfbreak>
        </cfif>
    </cfloop>
</cfloop>

<cfoutput>#total#</cfoutput>

<!--- Answer: 2654749936343 --->