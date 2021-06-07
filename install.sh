echo 'ACTION=="change",KERNEL=="card0", SUBSYSTEM=="drm", RUN+="/usr/local/bin/x-resize"' > 50-x-resize.rules
sudo cp 50-x-resize.rules /etc/udev/rules.d/50-x-resize.rules
rm 50-x-resize.rules
echo '#! /bin/sh' > x-resize
echo 'PATH=/usr/bin' >> x-resize
echo "desktopuser=$(/bin/ps -ef  | /bin/grep -oP '^\w+ (?=.*vdagent( |$))') || exit 0 " >> x-resize
echo "export DISPLAY=:0" >> x-resize
echo 'export XAUTHORITY=$(eval echo "~$desktopuser")/.Xauthority' >> x-resize
echo "xrandr --output $(xrandr | awk '/ connected/{print $1; exit; }') --auto" >> x-resize
chmod +x x-resize
sudo cp x-resize /usr/local/bin/x-resize
rm x-resize
