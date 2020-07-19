# An acme.sh deployment script for iDrac

A small deployment script for acme.sh to automate LE certs to iDracs on at least 13g+, but probably others.

## Prequisites

* Just racadm

## Install

I'm distributing this as I run it for MacOS, which means I run `racadm` via Docker.  It's painfully easy to swap over to native mode.

Just drop the script in the `deploy/` directory of your acme.sh installation.  

Run deployment hook:

```

acme.sh --deploy -d "idrac.domain.com"  --deploy-hook idrac

```

Example run with CloudFlare DNS validation:


```

export DEPLOY_IDRAC_HOST="idrac.domain.com"
export DEPLOY_IDRAC_PASS="idrac_pass"
export DEPLOY_IDRAC_USER="idrac_user"

acme.sh --issue --dns dns_cf -d "idrac.domain.com"
acme.sh --deploy -d "idrac.domain.com"  --deploy-hook idrac

```

Script default, run in docker on MacOS (with Docker Desktop)

```

docker-machine rm default && docker-machine create default --driver virtualbox
eval "$(docker-machine env default)"

docker run -v "/Users/kroy/Documents/:/Users/kroy/Documents/" -it justinclayton/racadm -r "$Le_Deploy_idrac_host" -u "$Le_Deploy_idrac_user" -p"$Le_Deploy_idrac_pass"           sslkeyupload -t 1 -f $_ckey
docker run -v "/Users/kroy/Documents/:/Users/kroy/Documents/" -it justinclayton/racadm -r "$Le_Deploy_idrac_host" -u "$Le_Deploy_idrac_user" -p"$Le_Deploy_idrac_pass"           sslcertupload -t 1 -f $_cfullchain
docker run -it justinclayton/racadm -r "$Le_Deploy_idrac_host" -u "$Le_Deploy_idrac_user" -p"$Le_Deploy_idrac_pass" racreset

```

To run on Windows or Linux where `racadm` is native, comment out above and change guts to this:


```
path/to/racadm -r "$Le_Deploy_idrac_host" -u "$Le_Deploy_idrac_user" -p"$Le_Deploy_idrac_pass" sslkeyupload -t 1 -f $_ckey
path/to/racadm -r "$Le_Deploy_idrac_host" -u "$Le_Deploy_idrac_user" -p"$Le_Deploy_idrac_pass" sslcertupload -t 1 -f $_cfullchain
path/to/racadm -r "$Le_Deploy_idrac_host" -u "$Le_Deploy_idrac_user" -p"$Le_Deploy_idrac_pass" racreset

```
