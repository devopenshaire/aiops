#!/bin/sh
FILE=/usr/share/nginx/html/index.html
echo """
<html>
    <head><title>URLS</title></head>
    <body>
        <h1>Available URLS</h1><ul>""" > $FILE
for URL in $(echo $URLS | tr "," " "); do
    if [[ `echo $URL | grep 'http'` ]]; then
        echo "<a href='$URL' target="_blank"> $URL </a><br>" >> $FILE
    else
        echo "<li>$URL</li>" >> $FILE
    fi
done
echo "</ul></body></html>" >> $FILE