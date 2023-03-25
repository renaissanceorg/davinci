module davinci.base.base;

import msgpack;

/** 
 * This is the base message type for all messages
 * in the Renaissance protocol; both client-to-server
 * and server-to-server
 */
public abstract class BaseMessage
{
    /** 
     * The type of message
     */
    private MessageType type;

    /** 
     * Constructs a new base message of the provided
     * type
     *
     * Params:
     *   type = the type of message
     */
    this(MessageType type)
    {
        this.type = type;
    }

    /** 
     * Get the type of message
     *
     * Returns: the type of message
     */
    public final MessageType getMessageType()
    {
        return type;
    }
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