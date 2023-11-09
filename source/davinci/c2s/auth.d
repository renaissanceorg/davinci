module davinci.c2s.auth;

import davinci.base;
import msgpack;

public final class AuthMessage : Command
{
    // TODO: Put authentication details here
    private string username;
    private string password;

    this()
    {
        registerClass!(typeof(this));
    }

    public void setUsername(string username)
    {
        this.username = username;
    }

    public void setPassword(string password)
    {
        this.password = password;
    }
}

public final class AuthResponse : Command
{
    private bool status;

    this()
    {
        registerClass!(typeof(this));
    }

    public void good()
    {
        this.status = true;
    }

    public void bad()
    {
        this.status = false;
    }

    public bool didAuthSucceed()
    {
        return this.status;
    }
}