module davinci.c2s.generic;

import davinci.base : Command;
import msgpack;

public final class UnknownCommandReply : Command
{
    private string offendingCommand;

    this()
    {
        // TODO: This should be a mixin
        registerClass!(typeof(this));
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