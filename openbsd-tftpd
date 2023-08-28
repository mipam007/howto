# Running TFTPD on OpenBSD

```
mkdir /tftpboot
chown 0755 /tftpboot
rcctl enable tftpd
doas cat /etc/pf.conf
set skip on lo
block return	# block stateless traffic
pass		# establish keep-state

# By default, do not permit remote connections to X11
block return in on ! lo0 proto tcp to port 6000:6010

# Port build user does not need network
block return out log proto {tcp udp} user _pbuild

pass in on egress proto tcp to any port 22

pass in on egress proto udp to any port 69
pass out on egress proto udp from any port 69

```
