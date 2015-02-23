if [ "$ABMPM" = "rpm" ]; then
    if ! rpm -qa $BUILDDEP $PKGDEP; then
        zypper ref -f
        zypper install $BUILDDEP $PKGDEP
    fi
elif [ "$ABAPM" = "dpkg" ]; then
    if ! dpkg -l $BUILDDEP $PKGDEP; then
        apt-get update
        apt-get install $BUILDDEP $PKGDEP --yes
    fi
fi
