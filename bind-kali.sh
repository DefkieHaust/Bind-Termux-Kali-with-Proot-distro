#!/data/data/com.termux/files/usr/bin/bash

name="knh"

rootfs="$HOME/kali-arm64"

read -p "Do you want to bind or unbind Kali with Proot-distro? (Type 'bind' or 'unbind'): " action

if [ "$action" == "bind" ]; then

    echo "# Kali nethunter arm64
    DISTRO_NAME=\"Kali Nethunter (arm64)\"
    DISTRO_COMMENT=\"Kali nethunter arm64 (official version)\"
    TARBALL_URL['aarch64']=\"https://kali.download/nethunter-images/current/rootfs/kalifs-arm64-minimal.tar.xz\"
    TARBALL_SHA256['aarch64']=\"fe5594de8c93918be9fb5da1302af9a5c2c57bfd23a296f6c3a4b8f62d4fbe69\"" > $PREFIX/etc/proot-distro/$name.sh

    ln -s $HOME/kali-arm64 $PREFIX/var/lib/proot-distro/installed-rootfs/$name

    touch $rootfs/home/kali/.hushlogin

    echo "PATH='/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/local/games:/usr/games:$PREFIX/bin:/system/bin:/system/xbin'" > $rootfs/etc/profile.d/bind-termux-bin.sh

    proot-distro list

    echo "Distro_Name: $name"
    echo "Login_Root: proot-distro login $name"
    echo "Login_Kali: proot-distro login $name --user kali"

elif [ "$action" == "unbind" ]; then

    rm $PREFIX/etc/proot-distro/$name.sh
    rm $PREFIX/var/lib/proot-distro/installed-rootfs/$name
    rm $rootfs/home/kali/.hushlogin
    rm $rootfs/etc/profile.d/bind-termux-bin.sh

    proot-distro list

    echo "Done!"

fi
