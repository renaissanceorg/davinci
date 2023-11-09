module davinci.s2s.link;

import davinci.base;
import msgpack;

public final class LinkRequest : Command
{
    // TODO: Put authentication details here
    private string serverName; // Name of server wanting to link
    private string signature; // TODO: Signature to check for signing
    

    this()
    {
        registerClass!(typeof(this));
    }
}