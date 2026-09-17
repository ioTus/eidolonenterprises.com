#!/bin/sh
# Deploy eidolonenterprises.com to Bluehost, or check the live site.
# Uses the "retrotuned" host alias from ~/.ssh/config (same account;
# no credentials live in this repo).
#
#   ./deploy.sh push     build, then rsync dist/ to the addon domain's document root
#   ./deploy.sh verify   fetch the home page over HTTPS with a browser user agent
#   ./deploy.sh diff     dry run: show what push would change
#   ./deploy.sh domain   add the addon domain via cPanel (once DNS points here)
#   ./deploy.sh ssl      ask cPanel to run an AutoSSL check now
set -eu

HOST="retrotuned"
DOMAIN="eidolonenterprises.com"
DOCROOT="public_html/eidolonenterprises"
REMOTE="$HOST:$DOCROOT/"
ROOT="$(cd "$(dirname "$0")" && pwd)"
DIST="$ROOT/dist/"
UA="Mozilla/5.0 (Macintosh; Intel Mac OS X 14_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/128.0 Safari/537.36"
EXCLUDES="--exclude .DS_Store"

build() { sh "$ROOT/build.sh"; }

case "${1:-}" in
  diff)
    build
    rsync -avzn --checksum --delete $EXCLUDES "$DIST" "$REMOTE"
    echo "(dry run — nothing was changed)"
    ;;
  push)
    build
    ssh "$HOST" "mkdir -p $DOCROOT"
    rsync -avz --checksum --delete $EXCLUDES "$DIST" "$REMOTE"
    ;;
  verify)
    curl -sS -A "$UA" -o /dev/null -w "%{http_code} %{url_effective} (%{size_download} bytes, ssl verify %{ssl_verify_result})\n" "https://$DOMAIN/"
    curl -sS -A "$UA" "https://$DOMAIN/" | grep -o '<title>[^<]*</title>'
    ;;
  domain)
    ssh "$HOST" "cpapi2 --output=jsonpretty AddonDomain addaddondomain newdomain=$DOMAIN subdomain=eidolonenterprises dir=$DOCROOT"
    ;;
  ssl)
    ssh "$HOST" "uapi --output=jsonpretty SSL start_autossl_check"
    ;;
  *)
    echo "usage: $0 push|verify|diff|domain|ssl" >&2
    exit 1
    ;;
esac
