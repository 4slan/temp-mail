#!/bin/sh
# Integration of the Temp Mail API in a shell script
# Temp Mail API - a service which provide a temporary anonymous(one-time) email address
#
# qr4 - quite request for
# domain - domain name of API
# ma - mail address
# md5oma - md5 hash of the mailing address
# a4r - address for requests
# loom - list of original messages
# brut
# firstCut
# mid - message's id
# dam - delete a message
# formOut - formatted output

qr4="curl -s"
domain="https://api.temp-mail.ru"
ma="admin@p33.org"
md5oma=$(md5 -qs $ma)

a4r="$domain/request/mail/id/$md5oma"

### Supported formats of the output: xml, json, jsonp, php, html
formOut="format/jsonp"


### List of original messages
loom="$a4r/source/id/$md5oma"
#$qr4 $loom > /dev/null

### Cut ID of message
brut=$($qr4 $loom/$formOut)
firstCut=${brut#*<mail_id>}
mid=${firstCut%%</mail_id>*}
echo "Message's ID: " $mid
#counter=0
#counter=`expr $counter + 1`
#echo "Message n°" $counter $mid


# ### Delete a message by its ID ($mid)
# dam="http://api.temp-mail.ru/request/delete/id/$mid"
# #$qr4 $dam
#
### Request for domains
rfd="$a4r/domains"
#$qr4 $rfd

### Supported formats of the output: xml, json, jsonp, php, html
formOut="$a4r/mail/id/$md5oma/format/php"
#$qr4 $formOut
