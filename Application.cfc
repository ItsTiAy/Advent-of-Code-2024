component
{
    this.name = "AdventOfCode";

    function onRequestStart(targetPage)
    {
        include template="header.cfm";
    }

    function onApplicationStart()
    {
        application.inputReader = new InputReader();
        return true;
    }
}