
cat packages.csv | while read -r line; do
    NAME=$(echo "$line" | cut -d';' -f1)
    VERSION=$(echo "$line" | cut -d';' -f2)
    URL=$(echo "$line" | cut -d';' -f3)
    MD5SUM=$(echo "$line" | cut -d';' -f4)
    CACHEFILE=$(basename "$URL")

    if [ ! -f "$CACHEFILE" ]; then
        echo "Downloading $URL"
        wget "$URL"
        if ! echo "$MD5SUM $CACHEFILE" | md5sum -c --quiet; then
            rm -f "$CACHEFILE"
            echo "Verification of $CACHEFILE failed! MD5 mismatch!"
            exit 1
        fi
    else
        echo "$CACHEFILE already exists, skipping download."
    fi
done

