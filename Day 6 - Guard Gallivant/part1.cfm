<cffile action="read" file="input.txt" variable="values">
<cfset lines = listToArray(values, Chr(10))>

<cfset mapGrid = arrayNew(2)>

<cfloop index="i" from="1" to="#arrayLen(lines)#">
    <cfset mapGrid[i] = listToArray(trim(lines[i]), "")>
    <cfset startX = arrayFind(mapGrid[i], "^")>
    <cfif startX GT 0>
        <cfset start = [i, startX]>
    </cfif>
</cfloop>

<cfset directions = [[-1, 0], [0, 1], [1, 0], [0, -1]]>

<cfset currentPos = start>
<cfset dirIndex = 1>
<cfset visited[serializeJSON(currentPos)] = dirIndex>

<cfloop condition="#true#">
    <cfset currentDir = directions[dirIndex]>
    <cfset nextPos = [currentPos[1] + currentDir[1], currentPos[2] + currentDir[2]]>

    <cfif (nextPos[1] LT 1) OR (nextPos[1] GT arrayLen(mapGrid)) OR (nextPos[2] LT 1) OR (nextPos[2] GT arrayLen(mapGrid[1]))>
        <cfbreak>
    </cfif>

    <cfif mapGrid[nextPos[1]][nextPos[2]] EQ "##">
        <cfset dirIndex = (dirIndex MOD 4) + 1>
    <cfelse>
        <cfset currentPos = nextPos>
        <cfset serializedPos = serializeJSON(currentPos)>        

        <cfset visited[serializedPos] = dirIndex>
    </cfif>
</cfloop>

<cfoutput>#structCount(visited)#</cfoutput>

<!--- Answer: 5212 --->