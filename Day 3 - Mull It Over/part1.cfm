<cffile action="read" file="input.txt" variable="values">

<cfset total = 0>

<cfset out = reFind("mul\(\d+,\d+\)", values, "1", true, "all")>


<cfloop item="mul" array="#out#">
    <cfset values = listToArray(mul.match[1], ",")>
    <cfset a = mid(values[1], 5)>
    <cfset b = mid(values[2], 1, Len(values[2]) - 1)>
    <cfset total += (a * b)>
</cfloop>

<cfoutput>#total#</cfoutput>

<!--- Answer: 175615763--->