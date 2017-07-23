#################################################################################################################
# Open Xchange Server based on centos										#
# using howto: https://oxpedia.org/wiki/index.php?title=AppSuite:Open-Xchange_Installation_Guide_for_CentOS_7	#
# 														#
#														#




FROM centos 
MAINTAINER Paul Hoeß paul.hoess@gmail.com

# add repo 
RUN touch /etc/yum.repos.d/ox.repo
RUN { \
	echo '[ox-appsuiteui]'; \
	echo 'name = Open-Xchange-appsuiteui'; \
	echo 'baseurl = http://software.open-xchange.com/products/appsuite/stable/appsuiteui/RHEL7/'; \
	echo 'gpgkey = http://software.open-xchange.com/oxbuildkey.pub'; \
	echo 'enabled = 1'; \
	echo 'gpgcheck = 1'; \
	echo 'metadata_expire = 0m'; \
	echo  ;\
	echo '[ox-backend]';\
	echo 'name = Open-Xchange-backend'; \
        echo 'baseurl = http://software.open-xchange.com/products/appsuite/stable/backend/RHEL7/'; \
        echo 'gpgkey = http://software.open-xchange.com/oxbuildkey.pub'; \
        echo 'enabled = 1'; \
        echo 'gpgcheck = 1'; \
        echo 'metadata_expire = 0m'; \
} > /etc/yum.repos.d/ox.repo 

# ultimativly trust this key
# you need to adjust key id and options (1)
# RUN gpg --edit-key XXXXXX
# select 1 
# trust
# select 5 + yes
# quit

RUN yum update -y

# install additional tools
RUN yum install wget vim -y

# add gpg key and import to keyring
RUN wget http://software.open-xchange.com/oxbuildkey.pub -O - | gpg --import -

# install open-xchange stuff
RUN yum install mariadb-server open-exchange open-xchange-authentication-ldap open-xchange-grizzly \
		open-xchange-admin open-xchange-appsuite \
		open-xchange-appsuite-backend open-xchange-appsuite-manifest -y
