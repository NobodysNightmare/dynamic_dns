# Dynamic DNS

Application acting as a web proxy for Dynamic
DNS updates using `nsupdate` (e.g. for bind9).
Consumer routers usually offer updating DNS
entries using a web call.

## Managing users

The application is configured to authenticate via Google (using omniauth) and
only grant access to a few selected users. Everyone that is allowed to access
the application has full access.

Check `rake -T`, all commands starting with `users:` are intended for user
management.
