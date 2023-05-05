module davinci.base.base;

import msgpack;

/** 
 * This is the base message type for all messages
 * in the Renaissance protocol; both client-to-server
 * and server-to-server
 */
public class BaseMessage
{
    static this()
    {
        registerPackHandler!(typeof(this), pkr);
        registerUnpackHandler!(typeof(this), upkr);
    }

    /** 
     * Current version of the protocol in use
     */
    private ProtocolVersion protocolVersion;


    /** 
     * The type of message
     */
    private MessageType type;
    
    private CommandType commandType;

    private Command command;

    /** 
     * Constructs a new base message of the provided
     * type
     *
     * Params:
     *   type = the type of message
     */
    this(MessageType type, CommandType commandType, Command command)
    {
        this.type = type;
        this.commandType = commandType;
        this.command = command;
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

    public CommandType getCommandType()
    {
        return commandType;
    }

    public Command getCommand()
    {
        return command;
    }

    /** 
     * Encodes this message into the wire format
     *
     * Returns: the encoded bytes
     */
    public final byte[] encode()
    {
        // FIXME: It won't encode nested classes, so enforce each `Command`
        // ... to have an `encode()` that gives byte array then and we should
        // ... manually pack here then for that
        return cast(byte[])pack(this);
    }


    public static void pkr(ref Packer packer, ref BaseMessage message)
    {
        packer.pack(message.protocolVersion);
        packer.pack(message.type);
        packer.pack(message.commandType);
        
        /* Payload bytes */
        byte[] payload = message.getCommand().getEncoded();
        packer.pack(payload);
    }

    public static void upkr(ref Unpacker unpacker, ref BaseMessage message)
    {
        unpacker.unpack!(ProtocolVersion)(message.protocolVersion);
        unpacker.unpack!(MessageType)(message.type);
        unpacker.unpack!(CommandType)(message.commandType);

        byte[] payload;
        unpacker.unpack!(byte[])(payload);

        // TODO: Now COmmndType check
        if(message.commandType == CommandType.NOP_COMMAND)
        {
            import davinci.c2s.test : TestMessage;
            message.command = Command.decodeTo!(TestMessage)(payload);
        }
        
        
    }
}


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