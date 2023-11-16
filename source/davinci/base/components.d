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

    this()
    {
        
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
     * Authentication response
     *
     * Sent from server back
     * to client in reply to
     * an authentication command
     */
    AUTH_RESPONSE,

    /**
     * Channel listing (req)
     *
     * Listing/enumerating channels
     * available
     */
    CHANNELS_ENUMERATE_REQ,

    /**
     * Channel listing (reply)
     *
     * Listing/enumerating channels
     * available
     */
    CHANNELS_ENUMERATE_REP,

    /**
     * Channel message (receive)
     *
     * Sent from server to client
     * representing a new message
     * that has been sent to the
     * client.
     */
    CHANNEL_NEW_MESSAGE,

    /**
     * Channel message (send)
     *
     * A client sends this to
     * the server when he wants
     * to send a message to some
     * body(ies)
     */
    CHANNEL_SEND_MESSAGE,

    /**
     * Membership (join)
     *
     * Request to join a given
     * channel
     */
    MEMBERSHIP_JOIN,

    /**
     * Membership (list)
     *
     * List all the members
     * of a given channel
     */
    MEMBERSHIP_LIST,

    /**
     * Membership (leave)
     *
     * Request to leave a
     * given channel
     */
    MEMBERSHIP_LEAVE,

    /**
     * Server linkg request
     *
     * Made by a server who
     * is requesting to link
     * with this server
     */
    LINK_REQUEST
}