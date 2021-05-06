exit_script() {
    SIGNAL=$1
    echo "Caught $SIGNAL! Unmounting ${AWS_S3_MOUNT}..."
    umount ${AWS_S3_MOUNT}
    trap - $SIGNAL # clear the trap
    exit $?
}
echo "register trap"
trap "exit_script QUIT EXIT INT" QUIT EXIT INT