#!/bin/bash
# run this on server

RESPOS_DIR=/var/lib/svn
REPOS=( "191343" REPO2 )
HTPASSWD=/etc/apache2/dav_svn.passwd

rm -fr $RESPOS_DIR

mkdir -p $RESPOS_DIR
for REPO in "${REPOS[@]}"; do
    mkdir -p $RESPOS_DIR/$REPO
    svnadmin create $RESPOS_DIR/$REPO
    # set permission to directory
done

htpasswd -bc $HTPASSWD user1 ask
htpasswd -b $HTPASSWD user2 ask

#modules are in: /etc/apache2/mods-available
a2enmod dav_svn
a2enmod authz_svn
a2enmod ssl

cp ./dav_svn.conf /etc/apache2/mods-enabled/dav_svn.conf
cp ./dav_svn.authz /etc/apache2/dav_svn.authz
systemctl restart apache2
# open http://192.168.56.101/svn/191343/

# Secure all the files so that only Apache user will have access to them
# only user we ignore group
chown www-data $RESPOS_DIR -R
chmod u+rw $RESPOS_DIR -R
chmod g-rwxX $RESPOS_DIR -R
chmod o-rwxX $RESPOS_DIR -R