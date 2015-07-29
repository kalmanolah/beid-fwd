## beid-fwd

`beid-fwd` is a daemon that wraps around [`beid-cli`][1], forwarding all data
to a specified HTTP endpoint.

### Configuration

Configuration can be found in `/usr/local/etc/beid-fwd.cfg`.

### Installing

Please ensure that [`fpm`][2] is installed if you want to build the package.

Debian & derivatives:

```
./package.sh
dpkg -i beid-fwd_0.0.1-1_all.deb
systemctl daemon-reload
systemctl enable beid-fwd
systemctl start beid-fwd
```

RH/CentOS & derivatives:

```
./package.sh
rpm -Uvh beid-fwd-0.0.1-1.noarch.rpm
systemctl daemon-reload
systemctl enable beid-fwd
systemctl start beid-fwd
```

[1]: https://github.com/brunogoossens/beid-cli
[2]: https://github.com/jordansissel/fpm

