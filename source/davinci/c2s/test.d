module davinci.c2s.test;

import davinci.base;
import msgpack;

public final class NopMessage : Command
{
    private string testField = "ABBAd";

    this()
    {
        registerClass!(typeof(this));
        super(cast(byte[])pack(this));
    }

    public string getTestField()
    {
        return testField;
    }

    // TOOD: The pack does a runtime type lookup (PROBABLY) and therefore we could
    // just rather have it as a final emthod

    // private void repack()
    // {
    //     setEncoded(cast(byte[])pack(this));
    // }

    public void setTestField(string testField)
    {
        this.testField = testField;

        // Ensure re-encoded
        repack();
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
    // Using this to ensure decode matches encoded
    string testingField = "ThisIsTestField";

    NopMessage exampleCommand = new NopMessage();
    exampleCommand.setTestField(testingField);

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
        assert(testCommand.getTestField() == testingField);
    }
    else
    {
        assert(false);
    }
    
}