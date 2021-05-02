if ping -w 1 -c 1 114.114.114.114
	then exit
	else
		if ping -w 1 -c 1 10.0.3.6
			then exit
			else
				NEWMAC=$(dd if=/dev/urandom bs=1024 count=1 2>/dev/null | md5sum | sed -e 's/^\(..\)\(..\)\(..\)\(..\)\(..\)\(..\).*$/\1:\2:\3:\4:\5:\6/' -e 's/^\(.\)[13579bdf]/\10/')
				uci set network.wan_wan_dev.macaddr=${NEWMAC}
				uci commit network
				/etc/init.d/network restart
		fi
fi
