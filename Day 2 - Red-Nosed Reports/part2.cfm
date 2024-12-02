<cfset safeReports = 0>
<cfset reports = []>

<cffile action="read" file="input.txt" variable="values">

<cfset lines = listToArray(values, Chr(10))>

<cfloop index="i" from="1" to="#arraylen(lines)#">
    <cfset line = listToArray(lines[i], " ")>
    <cfset arrayAppend(reports, line)>   
</cfloop>

<cffunction access="private" returntype="boolean" name="IsSafe">
    <cfargument required="true" type="array" name="report">

    <cfif report[1] EQ report[2]>
        <cfreturn false>
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

    <cfreturn safe>
</cffunction>

<cfloop item="report" array="#reports#">    
    <cfif IsSafe(report)>
        <cfset safeReports++>
        <cfcontinue>
    </cfif>

    <cfloop index="i" from="1" to="#arrayLen(report)#">
        <cfset tempReport = duplicate(report)>
        <cfset arrayDeleteAt(tempReport, i)>
        <cfif IsSafe(tempReport)>
            <cfset safeReports++>
            <cfbreak>
        </cfif>
    </cfloop>
</cfloop>

<cfoutput>#safeReports#</cfoutput>

<!--- Answer: 328 --->