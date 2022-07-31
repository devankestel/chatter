#!/usr/bin/env bash

chromedriver_path=$(command -v chromedriver)

chrome_path="/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"
chromedriver_version=$("${chromedriver_path}" --version)
chrome_version=$("${chrome_path}" --version)

chromedriver_major_version=$("${chromedriver_path}" --version | cut -f 2 -d " " | cut -f 1 -d ".")
chrome_major_version=$("${chrome_path}" --version | cut -f 3 -d " " | cut -f 1 -d ".")

if [ "${chromedriver_major_version}" == "${chrome_major_version}" ]; then
  exit 0
else
  echo "Wallaby often fails with 'invalid session id' if Chromedriver and Chrome have different versions."
  echo "Chromedriver version: ${chromedriver_version} (${chromedriver_path})"
  echo "Chrome version      : ${chrome_version} (${chrome_path})"
  echo "Go here to download a match: https://chromedriver.chromium.org/downloads"
  echo "After download the correct version, extract the chromedriver_mac64.zip file" 
  echo "Then move it to /usr/local/bin by using this command: mv chromedriver /usr/local/bin"
  echo "For more info visit: https://www.thanh.xyz/post/2021-04-29-how-to-fix-the-invalid-session-id-in-wallaby-integration-testing/"
  echo "You may also have to run: xattr -d com.apple.quarantine /usr/local/bin/chromedriver"
  echo "For more info visit:https://timonweb.com/misc/fixing-error-chromedriver-cannot-be-opened-because-the-developer-cannot-be-verified-unable-to-launch-the-chrome-browser-on-mac-os/ "
  exit 1
fi