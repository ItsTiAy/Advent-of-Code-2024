<cffile action="read" file="input.txt" variable="values">

<cfset total = 0>
<cfset add = true>

<cfset items = reFind("mul\(\d+,\d+\)|don't\(\)|do\(\)", values, "1", true, "all")>

<cfloop item="item" array="#items#">
    <cfif item.match[1] EQ "don't()">
        <cfset add = false>
        <cfcontinue>
    <cfelseif item.match[1] EQ "do()">
        <cfset add = true>
        <cfcontinue>
    </cfif>

    <cfif add>
        <cfset values = listToArray(item.match[1], ",")>
        <cfset a = mid(values[1], 5)>
        <cfset b = mid(values[2], 1, Len(values[2]) - 1)>
        <cfset total += (a * b)>
    </cfif>
</cfloop>

<cfoutput>#total#</cfoutput>

<!--- Answer: 74361272--->