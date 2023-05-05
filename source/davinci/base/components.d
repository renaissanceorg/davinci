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

    

    // public abstract byte[] encode();

    public final byte[] getEncoded()
    {
        return data;
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
    NOP_COMMAND
}