# Docker container for Postfix

This container uses the Alpine Linux base image and installs the Postfix SMTP server, along with a minimal bootstrap
script which sets up the container at runtime for Postfix.

## Getting Started

The Postfix configuration files are stored in the `/etc/postfix` directory. You can mount custom configuration files
over `/etc/postfix/main.cf` and `/etc/postfix/master.cf` as needed.

*Don't* mount a volume over `/etc/postfix` as the installation created several system-specific files:

- `/etc/postfix/dynamic-maps.cf`
- `/etc/postfix/dynamic-maps.cf.d/*`
- `/etc/postfix/postfix-files`
- `/etc/postfix/postfix-files.d/*`

## Bootstrap Phase

When the container is started, the `bootstrap` script is used as the entrypoint and performs a few setup tasks before
starting Postfix:

1. The system's `resolv.conf` file is copied into Postfix's chroot environment.
2. Custom scripts stored in `/etc/postfix/bootstrap.d` are executed.

After this, the `bootstrap` script is replaced by Postfix's `master` process through the `exec` command.

You can mount a volume over `/etc/postfix/bootstrap.d` as the directory does not exist in the container.

## License

This project is licensed under the Apache-2.0 License - see the LICENSE file for details.
