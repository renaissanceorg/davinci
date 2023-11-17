module davinci.c2s.generic;

import davinci.base : Command;

public final class UnknownCommandReply
{
    private string offendingCommand;

    this()
    {

    }

    this(string offending)
    {
        setOffending(offending);
    }

    public UnknownCommandReply setOffending(string offending)
    {
        this.offendingCommand = offending;
        return this;
    }

    public string getOffending()
    {
        return this.offendingCommand;
    }
}