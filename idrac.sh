
# Usage:

## put this script in the deploy/ directory in the acme.sh root

# export DEPLOY_IDRAC_HOST="idrac.domain.com"
# export DEPLOY_IDRAC_PASS="idrac_pass"
# export DEPLOY_IDRAC_USER="idrac_user"

## Issue the cert, I use CF
# acme.sh --issue --dns dns_cf -d "idrac.domain.com"
# acme.sh --deploy -d "idrac.domain.com"  --deploy-hook idrac


idrac_deploy() {
  _cdomain="$1"
  _ckey="$2"
  _ccert="$3"
  _cca="$4"
  _cfullchain="$5"

    Le_Deploy_idrac_user="$DEPLOY_IDRAC_USER"
    _savedomainconf Le_Deploy_idrac_user "$Le_Deploy_idrac_user"
    Le_Deploy_idrac_pass="$DEPLOY_IDRAC_PASS"
    _savedomainconf Le_Deploy_idrac_pass "$Le_Deploy_idrac_pass"
    Le_Deploy_idrac_host="$DEPLOY_IDRAC_HOST"
    _savedomainconf Le_Deploy_idrac_host "$Le_Deploy_idrac_host"


    ## I run this on MacOS, so I run racadm via Docker
    ## anywhere else it would just just be:
    ##
    # path/to/racadm -r "$Le_Deploy_idrac_host" -u "$Le_Deploy_idrac_user" -p"$Le_Deploy_idrac_pass" sslkeyupload -t 1 -f $_ckey
    # path/to/racadm -r "$Le_Deploy_idrac_host" -u "$Le_Deploy_idrac_user" -p"$Le_Deploy_idrac_pass" sslcertupload -t 1 -f $_cfullchain
    # path/to/racadm -r "$Le_Deploy_idrac_host" -u "$Le_Deploy_idrac_user" -p"$Le_Deploy_idrac_pass" racreset

    docker-machine rm default && docker-machine create default --driver virtualbox
    eval "$(docker-machine env default)"

    docker run -v "/Users/kroy/Documents/:/Users/kroy/Documents/" -it justinclayton/racadm -r "$Le_Deploy_idrac_host" -u "$Le_Deploy_idrac_user" -p"$Le_Deploy_idrac_pass" sslkeyupload -t 1 -f $_ckey
    docker run -v "/Users/kroy/Documents/:/Users/kroy/Documents/" -it justinclayton/racadm -r "$Le_Deploy_idrac_host" -u "$Le_Deploy_idrac_user" -p"$Le_Deploy_idrac_pass" sslcertupload -t 1 -f $_cfullchain
    docker run -it justinclayton/racadm -r "$Le_Deploy_idrac_host" -u "$Le_Deploy_idrac_user" -p"$Le_Deploy_idrac_pass" racreset

}
