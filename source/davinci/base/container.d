module davinci.base.container;

import davinci.base.components;
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

    public static BaseMessage decode(byte[] encodedBytes)
    {
        return unpack!(BaseMessage)(cast(ubyte[])encodedBytes);
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
            import davinci.c2s.test : NopMessage;
            message.command = Command.decodeTo!(NopMessage)(payload);
        }
        else if(message.commandType == CommandType.AUTH_COMMAND)
        {
            import davinci.c2s.auth : AuthMessage;
            message.command = Command.decodeTo!(AuthMessage)(payload);
        }
        else if(message.commandType == CommandType.AUTH_RESPONSE)
        {
            import davinci.c2s.auth : AuthResponse;
            message.command = Command.decodeTo!(AuthResponse)(payload);
        }
        else if(message.commandType == CommandType.CHANNELS_ENUMERATE_REQ)
        {
            import davinci.c2s.channels : ChannelEnumerateRequest;
            message.command = Command.decodeTo!(ChannelEnumerateRequest)(payload);
        }
        else if(message.commandType == CommandType.CHANNELS_ENUMERATE_REP)
        {
            import davinci.c2s.channels : ChannelEnumerateReply;
            message.command = Command.decodeTo!(ChannelEnumerateReply)(payload);
        }
        else if(message.commandType == CommandType.CHANNEL_SEND_MESSAGE)
        {
            import davinci.c2s.channels : ChannelMessage;
            message.command = Command.decodeTo!(ChannelMessage)(payload);
        }
        else if(message.commandType == CommandType.CHANNEL_NEW_MESSAGE)
        {
            import davinci.c2s.channels : ChannelMessage;
            message.command = Command.decodeTo!(ChannelMessage)(payload);
        }
        else if(
                message.commandType == CommandType.MEMBERSHIP_JOIN ||
                message.commandType == CommandType.MEMBERSHIP_LEAVE ||
                message.commandType == CommandType.MEMBERSHIP_LIST
                )
        {
            import davinci.c2s.channels : ChannelMembership;
            message.command = Command.decodeTo!(ChannelMembership)(payload);
        }
        
        
    }
}


