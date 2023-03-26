module davinci.c2s.client;

import davinci.base.base : BaseMessage, MessageType;

public class C2SMessage : BaseMessage
{
    this()
    {
        super(MessageType.CLIENT_TO_SERVER);
    }
}