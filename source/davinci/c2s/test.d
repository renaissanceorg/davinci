module davinci.c2s.test;

import davinci.base.base;
import davinci.c2s.client;
import msgpack;

public class TestMessage : C2SMessage
{
    private string testField = "ABBA";

    this()
    {
        registerClass!(typeof(this));
    }

    public string getTestField()
    {
        return testField;
    }
}

version(unittest)
{
    import std.stdio : writeln;
}

unittest
{
    BaseMessage exampleMessage = new TestMessage();

    byte[] encodedBytes = exampleMessage.encode();
    writeln("Encoded bytes: ", encodedBytes);

    // NOTE: We would firstly decode the bytes as a BaseMessage
    // ... then determine the message-type from that and then
    // ... do a full re-decode with that type. We'd do this in a
    // ... switch statement.
    //
    // Here we just go ahead and assume it is a TestMessage
    // ... kind-of message
    TestMessage testMessage = unpack!(TestMessage)(cast(ubyte[])encodedBytes);
    writeln(testMessage.getMessageType());
    writeln(testMessage.getTestField());
}