clear
echo ""
echo "Install TWRP recovery"
echo ""
echo "Please boot your Nexus 10 into fastboot mode by pressing Power & Volume Up (+) & Volume Down (-)"
sleep 1
echo ""
echo -n "Is your Nexus 10 in fastboot mode now? [Y] "; read bootloadermode
if [ "$bootloadermode"==Y -o "$bootloadermode"==y -o "$bootloadermode"=="" ]; then
  clear
  echo ""
  echo "Detecting device"
  echo ""
  sleep 1
  fastboot devices > /tmp/AttachedDevices
fi
  if grep 'device$\|fastboot$' /tmp/AttachedDevices
  then
    echo "Device detected !"
    sleep 1
    clear
    echo ""
    echo "Downloading latest TWRP recovery image.."
    echo ""
    wget -c --quiet --show-progress --tries=10 http://people.ubuntu.com/~marius.quabeck/magic-device-tool/recoverys/twrp-3.0.2-0-manta.img
    sleep 2
    echo "Installing TWRP..."
    fastboot flash recovery ./twrp-3.0.2-0-manta.img
    fastboot reboot-bootloader
    sleep 4
    echo ""
    echo "You can now boot into TWRP recovery"
    sleep 1
    echo ""
    echo "Cleaning up.."
    rm -f /tmp/AttachedDevices
    #rm -f ./*.img
    echo ""
    sleep 1
    echo "Exiting script. Bye Bye"
    sleep 1
    exit
  else
    echo "Device not found"
    rm -f /tmp/AttachedDevices
    exit
  fi
