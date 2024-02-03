firewall-cmd --zone=public --add-port=2222/tcp --permanent
firewall-cmd --zone=public --add-port=21/tcp --permanent
firewall-cmd --zone=public --add-port=80/tcp --permanent
firewall-cmd --zone=public --add-port=443/tcp --permanent
firewall-cmd --zone=public --add-port=25/tcp --permanent
firewall-cmd --reload
systemctl restart directadmin
cd /usr/local/directadmin/conf/
service directadmin stop
rm -rf /usr/local/directadmin/conf/license.key
wget -O /usr/local/directadmin/conf/license.key 'http://license.vsicloud.com/getLic.php'
chmod 600 /usr/local/directadmin/conf/license.key
chown diradmin:diradmin /usr/local/directadmin/conf/license.key
ifconfig eth0:100 176.99.3.34 netmask 255.0.0.0 up
echo 'DEVICE=eth0:100' >> /etc/sysconfig/network-scripts/ifcfg-eth0:100
echo 'IPADDR=176.99.3.34' >> /etc/sysconfig/network-scripts/ifcfg-eth0:100
echo 'NETMASK=255.0.0.0' >> /etc/sysconfig/network-scripts/ifcfg-eth0:100
service network restart
/usr/bin/perl -pi -e 's/^ethernet_dev=.*/ethernet_dev=eth0:100/' /usr/local/directadmin/conf/directadmin.conf
service directadmin start
