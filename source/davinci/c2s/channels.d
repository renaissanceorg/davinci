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

    this(string[] channels)
    {
        this();
        setChannels(channels);
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

// NOTE: Can be used for reception AND request (sending)
public final class ChannelMessage : Command
{
    private string[] to;
    private string from;

    // TODO: Add mime-type here
    private string data;

    this()
    {
        registerClass!(typeof(this));
    }

    public void setTo(string[] to)
    {
        foreach(string curTo; to)
        {
            this.to ~= curTo;
        }
    }

    public void setTo(string to)
    {
        this.to ~= to;
    }

    public string getSingularTo()
    {
        return this.to[0];
    }

    public string[] getRecipients()
    {
        return this.to;
    }

    public string getFrom()
    {
        return this.from;
    }

    public string getMessage()
    {
        return data;
    }
}


public enum MembershipMode
{
    JOIN,
    LEAVE,
    LIST
}

public enum MemershipResult
{
    GOOD,
    BAD
}

public class ChannelMembership : Command
{
    private MembershipMode memMode;
    private string channel;
    private string[] members;
    private MemershipResult status;

    this()
    {
        registerClass!(typeof(this));
    }

    public string getChannel()
    {
        return this.channel;
    }

    public ChannelMembership join(string channelName)
    {
        this.channel = channelName;
        return join();
    }

    public ChannelMembership join()
    {
        return mode(MembershipMode.JOIN);
    }

    public ChannelMembership mode(MembershipMode mode)
    {
        this.memMode = mode;
        return this;
    }

    public string[] getMembers()
    {
        return this.members;
    }

    public ChannelMembership listReplyGood(string[] channels)
    {
        // Set the status to good
        replyGood();

        // Set the channels
        this.members = channels;

        return this;
    }

    public ChannelMembership replyGood()
    {
        return replyStatus(MemershipResult.GOOD);
    }

    public ChannelMembership replyBad()
    {
        return replyStatus(MemershipResult.BAD);
    }

    public bool wasGood()
    {
        return this.status == MemershipResult.GOOD;
    }

    private ChannelMembership replyStatus(MemershipResult result)
    {
        this.status = result;
        return this;
    }
}