

# Source global definitions
if [ -f /etc/bashrc ]; then
        . /etc/bashrc
fi


echo "Running sshd. Login as root@localhost:2222:password"
/sbin/sshd -D &

source $BUILD_SCRIPTS/gluex_env_boot_jlab.sh
