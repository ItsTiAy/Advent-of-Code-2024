<cfset left = []>
<cfset right = []>

<cfset similarity = 0>
<cfset instances = {}>

<cffile action="read" file="input.txt" variable="values">

<cfset lines = listToArray(values, Chr(10))>

<cfloop index="i" from="1" to="#arraylen(lines)#">
    <cfset line = listToArray(lines[i], "   ")>

    <cfset arrayAppend(left, val(line[1]))>
    <cfset arrayAppend(right, val(line[2]))>
</cfloop>

<cfloop item="key" array="#right#">
    <cfif structKeyExists(instances, key)>
        <cfset instances[key]++>
    <cfelse>
        <cfset instances[key] = 1>
    </cfif>
</cfloop>

<cfloop item="key" array="#left#">
    <cfif structKeyExists(instances, key)>
        <cfset similarity += instances[key] * key>
    </cfif>
</cfloop>

<cfoutput>#similarity#</cfoutput>

<!--- Answer 22014209 --->