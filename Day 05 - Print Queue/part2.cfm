<cffile action="read" file="input.txt" variable="values">

<cfset rulesForward = {}>
<cfset rulesBackward = {}>
<cfset updates = []>

<cfset validUpdates = 0>

<cfset lines = listToArray(values, Chr(10))>

<cfset i = 1>
<cfwhile condition="#len(lines[i]) GT 1#">
    <cfset line = listToArray(lines[i], "|")>

    <cfset left = val(line[1])>
    <cfset right = val(line[2])>

    <cfif structKeyExists(rulesForward, left)>
        <cfset arrayAppend(rulesForward[left], right)>
    <cfelse>
        <cfset rulesForward[left] = [right]>
    </cfif>

    <cfif structKeyExists(rulesBackward, right)>
        <cfset arrayAppend(rulesBackward[right], left)>
    <cfelse>
        <cfset rulesBackward[right] = [left]>
    </cfif>
    <cfset i++>
</cfwhile>

<cfset i++>

<cfwhile condition="#i LTE arrayLen(lines)#" >
    <cfset line = listToArray(lines[i], ",")>
    <cfset arrayAppend(updates, arrayMap(line, function(item) {return val(item)}))>   
    <cfset i++>
</cfwhile>

<cfloop item="update" array="#updates#">
    <cfset valid = true>

    <cfloop index="i" from="1" to="#arrayLen(update)#">
        <cfif NOT valid>
            <cfbreak>
        </cfif>
        <cfloop index="j" from="#i + 1#" to="#arrayLen(update)#">
            <cfif structKeyExists(rulesForward, update[i]) AND (arrayContains(rulesForward[update[i]], update[j]) LTE 0)>
                <cfset valid = false>
                <cfbreak>
            </cfif>
        </cfloop>
        <cfloop index="k" from="#i - 1#" to="#1#" step="-1">
            <cfif structKeyExists(rulesBackward, update[i]) AND (arrayContains(rulesBackward[update[i]], update[k]) LTE 0)>
                <cfset valid = false>
                <cfbreak>
            </cfif>
        </cfloop>
    </cfloop>
    
    <cfif NOT valid>
        <cfset arraySort(update, 
        function (a, b)
        {
            if (arrayContains(rulesForward[a], b) GT 0) return -1;
            else if (arrayContains(rulesBackward[a], b) GT 0) return 1;   
            else return 0;
        })>
        <cfset validUpdates += update[(arrayLen(update) + 1) / 2]>
    </cfif>
</cfloop>

<cffunction access="private" returntype="number" name="Sort">
    <cfargument required="true" type="number" name="a">
    <cfargument required="true" type="number" name="b">

    <cfif arrayContains(rulesForward[a], b) GT 0>
        <cfreturn -1>
    <cfelseif arrayContains(rulesBackward[a], b) GT 0>
        <cfreturn 1>
    <cfelse>
        <cfreturn 0>
    </cfif>

</cffunction>

<cfoutput>#validUpdates#</cfoutput>

<!--- Answer: 7380--->