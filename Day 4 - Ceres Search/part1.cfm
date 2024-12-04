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
        <cfif current EQ "X">
            <cfset xmasNum += CheckAround(x, y)>
        </cfif>
    </cfloop>
</cfloop>

<cffunction access="private" returntype="number" name="CheckAround">
    <cfargument required="true" type="number" name="currentX">
    <cfargument required="true" type="number" name="currentY">

    <cfset offsets = [
    {row=-1, col=0},
    {row=-1, col=1},
    {row=0, col=1},
    {row=1, col=1},
    {row=1, col=0},
    {row=1, col=-1},
    {row=0, col=-1},
    {row=-1, col=-1}]>

    <cfset currentXmasNum = 0>

    <cfloop index="offset" array="#offsets#">
        <cftry>
            <cfif wordSearch[currentX + offset.row][currentY + offset.col] EQ "M" AND
                  wordSearch[currentX + (offset.row * 2)][currentY + (offset.col * 2)] EQ "A" AND
                  wordSearch[currentX + (offset.row * 3)][currentY + (offset.col * 3)] EQ "S">
                <cfset currentXmasNum++>
            </cfif>
            <cfcatch>
                <cfcontinue>
            </cfcatch>
        </cftry>
    </cfloop>

    <cfreturn currentXmasNum>
</cffunction>

<cfoutput>#xmasNum#</cfoutput>

<!--- Answer: 2370--->