module davinci.base.base;

/** 
 * This is the base message type for all messages
 * in the Renaissance protocol; both client-to-server
 * and server-to-server
 */
public class BaseMessage
{
    /** 
     * The type of message
     */
    private MessageType type;
}


/** 
 * 
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