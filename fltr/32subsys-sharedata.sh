if bool $32SUBSYSBUILD
then
    rm -rfv abdist/opt/32/share
fi

export ABFLTRS="$ABFLTRS 32subsys-sharedata"
