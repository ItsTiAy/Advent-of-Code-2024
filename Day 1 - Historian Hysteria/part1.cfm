<cfset left = []>
<cfset right = []>

<cfset distance = 0>

<cffile action="read" file="input.txt" variable="values">

<cfset lines = listToArray(values, Chr(10))>

<cfloop index="i" from="1" to="#arraylen(lines)#">
    <cfset line = listToArray(lines[i], "   ")>

    <cfset arrayAppend(left, val(line[1]))>
    <cfset arrayAppend(right, val(line[2]))>
</cfloop>

<cfset arraySort(left, "numeric", "asc")>
<cfset arraySort(right, "numeric", "asc")>

<cfloop index="i" from="1" to="#arraylen(left)#">
    <cfset distance += abs(left[i] - right[i])>
</cfloop>

<cfoutput>#distance#</cfoutput>

<!--- Answer: 1938424 --->