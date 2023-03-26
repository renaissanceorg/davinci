module davinci.s2s.server;

import davinci.base.base : BaseMessage, MessageType;

public class S2SMessage : BaseMessage
{
    this()
    {
        super(MessageType.SERVER_TO_SERVER);
    }
}