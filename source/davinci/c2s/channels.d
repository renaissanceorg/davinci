module davinci.c2s.channels;

import davinci.base;
import msgpack;

public final class ChannelEnumerateRequest : Command
{
    private ulong offset;
    private ubyte limit;

    this()
    {
        // Only list 100 channels by default
        this.limit = 100;

        // Offset starts at 0
        this.offset = 0;

        registerClass!(typeof(this));
    }

    public void setOffset(ulong offset)
    {
        this.offset = offset;
    }

    public void setLimit(ubyte limit)
    {
        this.limit = limit;
    }

    public ulong getOffset()
    {
        return this.offset;
    }

    public ubyte getLimit()
    {
        return this.limit;
    }
}

public final class ChannelEnumerateReply : Command
{
    private string[] channels;

    this()
    {
        registerClass!(typeof(this));
    }

    public void setChannels(string[] channels)
    {
        this.channels = channels;
    }

    public string[] getChannels()
    {
        return this.channels;
    }
}