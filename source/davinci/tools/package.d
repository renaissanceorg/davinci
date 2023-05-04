module davinci.tools;

// TODO: Add a way to enforce that T must be derived from or equal to BaseMessage
public T decodeTo(T)(byte[] data)
{
    // Currently we are using message pack
    import msgpack;
    return unpack!(T)(cast(ubyte[])data);
}