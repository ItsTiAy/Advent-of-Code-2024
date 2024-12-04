<cffile action="read" file="input.txt" variable="values">

<cfset xmasNum = 0>

<cfset rows = listToArray(values, Chr(10))>
<cfset wordSearch = arrayNew(2)>

<cfloop index="i" from="1" to="#arrayLen(rows)#">
    <cfset rowArray = []>
    <cfloop index="j" from="1" to="#len(rows[i]) - 1#">
        <cfset arrayAppend(rowArray, mid(rows[i], j, 1))>
        <cfset wordSearch[i][j] = rowArray[j]>
    </cfloop>
</cfloop>

<cfloop index="y" from="1" to="#arrayLen(wordSearch)#">
    <cfloop index="x" from="1" to="#arrayLen(wordSearch[y])#">
        <cfset current = wordSearch[x][y]>
        <cfif current EQ "A">
            <cfset xmasNum += CheckAround(x, y)>
        </cfif>
    </cfloop>
</cfloop>

<cffunction access="private" returntype="number" name="CheckAround">
    <cfargument required="true" type="number" name="currentX">
    <cfargument required="true" type="number" name="currentY">

    <cfset currentXmasNum = 0>

    <cftry>
        <cfset topLeft = wordSearch[currentX - 1][currentY - 1]>
        <cfset bottomRight = wordSearch[currentX + 1][currentY + 1]>

        <cfset bottomLeft = wordSearch[currentX - 1][currentY + 1]>
        <cfset topRight = wordSearch[currentX + 1][currentY - 1]>

        <cfif ((topLeft EQ "M" AND bottomRight EQ "S") OR
              (topLeft EQ "S" AND bottomRight EQ "M")) AND 
              ((bottomLeft EQ "M" AND topRight EQ "S") OR
              (bottomLeft EQ "S" AND topRight EQ "M"))>
            <cfset currentXmasNum++>
        </cfif>

        <cfcatch>
            <cfreturn currentXmasNum>
        </cfcatch>
    </cftry>

    <cfreturn currentXmasNum>
</cffunction>

<cfoutput>#xmasNum#</cfoutput>

<!--- Answer: 1908--->