module davinci.c2s.test;

import davinci.base;
import msgpack;

public class TestMessage : Command
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

    public override string toString()
    {
        return "TestMessage [testField: "~testField~"]";
    }
}

version(unittest)
{
    import std.stdio : writeln;
}

unittest
{
    TestMessage exampleCommand = new TestMessage();
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
        TestMessage testCommand = cast(TestMessage)testMessage.getCommand();
        writeln(testCommand.getTestField());
    }
    
}