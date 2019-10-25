#!/bin/bash -eux
# -e: Exit immediately if a command exits with a non-zero status.
# -u: Treat unset variables as an error when substituting.
# -x: Display expanded script commands

if [ "${TRAVIS_PULL_REQUEST}" = "false" ]
then
CURL_HEADER="Authorization: token $GITHUB_OATH_TOKEN"
else
# use an empty authorization header. this will fall back to 50 requests per hour from given Travis IP (for any project, not only ours!)
CURL_HEADER=""
fi

LIBCMINI_URL=$(curl -s -H "$CURL_HEADER" https://api.github.com/repos/mfro0/libcmini/releases/latest | jq -r '.assets[].browser_download_url')
LIBCMINI_NAME=$(curl -s -H "$CURL_HEADER" https://api.github.com/repos/mfro0/libcmini/releases/latest | jq -r '.assets[].name')

cd ..
mkdir libcmini
wget -q "$LIBCMINI_URL"
tar xzvf "$LIBCMINI_NAME" -C libcmini
cd -

QED_URL=$(curl -s -H "$CURL_HEADER" https://api.github.com/repos/freemint/freemint.github.io/contents/builds/qed/master | jq -r '.[].download_url')
QED_NAME=$(curl -s -H "$CURL_HEADER" https://api.github.com/repos/freemint/freemint.github.io/contents/builds/qed/master | jq -r '.[].name')

cd .travis
wget -q "$QED_URL"
unzip "$QED_NAME"
rm "$QED_NAME"
cd -

if test -f .travis/install-udo.sh; then
	. .travis/install-udo.sh
fi
