module davinci.c2s.test;

import davinci.base;
import msgpack;

public class NopMessage : Command
{
    private string testField = "ABBAd";

    this()
    {
        import msgpack;
        registerClass!(typeof(this));
        super(cast(byte[])pack(this));
    }

    public string getTestField()
    {
        return testField;
    }

    public string setTestField(string testField)
    {
        this.testField = testField;
    }

    public override string toString()
    {
        return "NopMessage [testField: "~testField~"]";
    }
}

version(unittest)
{
    import std.stdio : writeln;
}

unittest
{
    NopMessage exampleCommand = new NopMessage();
    BaseMessage exampleMessage = new BaseMessage(MessageType.CLIENT_TO_SERVER, CommandType.NOP_COMMAND, exampleCommand);

    byte[] encodedBytes = exampleMessage.encode();
    writeln("Encoded bytes: ", encodedBytes);

    // NOTE: We would firstly decode the bytes as a BaseMessage
    // ... then determine the message-type from that and then
    // ... do a full re-decode with that type. We'd do this in a
    // ... switch statement.
    //
    // Here we just go ahead and assume it is a TestMessage
    // ... kind-of message
    BaseMessage testMessage = BaseMessage.decode(encodedBytes);
    writeln(testMessage);
    if(testMessage.getCommandType() == CommandType.NOP_COMMAND)
    {
        NopMessage testCommand = cast(NopMessage)testMessage.getCommand();
        writeln(testCommand.getTestField());
    }
    
}