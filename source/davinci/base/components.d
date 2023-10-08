module davinci.base.components;

import davinci.base.container : BaseMessage;
import msgpack;

public enum ProtocolVersion
{
    VERSION_0_PHONK
}

/** 
 * The type of message
 */
public enum MessageType
{
    /**
     * If the message is client-to-server
     */ 
    CLIENT_TO_SERVER,

    /**
     * If the message is server-to-server
     */
    SERVER_TO_SERVER
}


public abstract class Command
{
    private byte[] data;

    this(byte[] data)
    {
        this.data = data;
    }

    /** 
     * Sets the binary data of this command
     *
     * Params:
     *   data = a `byte[]import std.stdio;
        writeln("About to do base message pack of child: ", message.getCommand());`
     */
    protected final void setEncoded(byte[] data)
    {
        this.data = data;
    }

    // public abstract byte[] encode();

    /** 
     * Returns the bianry data of this
     * command
     *
     * Returns: a `byte[]`
     */
    public final byte[] getEncoded()
    {
        // Force repack of the object
        repack();

        // Return the data
        return data;
    }

    /** 
     * Repacks all the fields of this
     * message
     */
    protected final void repack()
    {
        setEncoded(cast(byte[])pack(this));
    }

    // TODO: Add a way to enforce that T must be derived from or equal to BaseMessage
    public static T decodeTo(T)(byte[] data)
    {
        // Currently we are using message pack
        import msgpack;
        return unpack!(T)(cast(ubyte[])data);
    }
}

public enum CommandType
{
    SPACER,
    NOP_COMMAND,

    /**
     * Authentication command
     *
     * Used for clients to
     * login
     */
    AUTH_COMMAND,

    /**
     * Server linkg request
     *
     * Made by a server who
     * is requesting to link
     * with this server
     */
    LINK_REQUEST
}