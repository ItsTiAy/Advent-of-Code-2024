<cfset safeReports = 0>
<cfset reports = []>

<cffile action="read" file="input.txt" variable="values">

<cfset lines = listToArray(values, Chr(10))>

<cfloop index="i" from="1" to="#arraylen(lines)#">
    <cfset line = listToArray(lines[i], " ")>
    <cfset arrayAppend(reports, line)>   
</cfloop>

<cfloop item="report" array="#reports#">
    
    <cfif report[1] EQ report[2]>
        <cfcontinue>
    </cfif>
    
    <cfset safe = true>

    <cfif report[1] GT report[2]>
        <cfset firstBound = 3>
        <cfset secondBound = 1>
    <cfelse>
        <cfset firstBound = -1>
        <cfset secondBound = -3>
    </cfif>

    <cfloop index="i" from="1" to="#arrayLen(report) - 1#">
        <cfset difference = val(report[i]) - val(report[i + 1])>
        <cfif (difference GT firstBound) OR (difference LT secondBound)>          
            <cfset safe = false>
            <cfbreak>
        </cfif>
    </cfloop>

    <cfif safe>
        <cfset safeReports++>
    </cfif>
</cfloop>

<cfoutput>#safeReports#</cfoutput>

<!--- Answer: 257 --->