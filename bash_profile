

# Source global definitions
if [ -f /etc/bashrc ]; then
        . /etc/bashrc
fi


echo "Running sshd on port 22..."
/sbin/sshd -D &

source $BUILD_SCRIPTS/gluex_env_boot_jlab.sh
