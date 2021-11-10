#!/usr/bin/env bash

# https://elrey.casa/bash/scripting/harden
set -${-//[sc]/}eu${DEBUG+xv}o pipefail

function change_owners(){
  # https://github.com/elreydetoda/king-phisher/blob/6acbbd856f849d407cc904c075441e0cf13c25cf/tools/install.sh#L501
  chown -R :"${KING_PHISHER_GROUP:-king-phisher}" ../king-phisher
}

function setup_postgres(){
  if [[ -n "${POSTGRES:-}" ]] ; then
    # https://github.com/elreydetoda/king-phisher/blob/6acbbd856f849d407cc904c075441e0cf13c25cf/tools/install.sh#L547
    sed -i -re "s|database: sqlite://|#database: sqlite://|" ./server_config.yml
    # https://github.com/elreydetoda/king-phisher/blob/6acbbd856f849d407cc904c075441e0cf13c25cf/tools/install.sh#L551
    sed -i -re "s|#\\s?database: postgresql://.*$|database: postgresql://${PG_KP_DB_USER}:${PG_KP_DB_PASSWORD}@${PG_KP_DB_HOST}/${PG_KP_DB}|" ./server_config.yml
  fi
}

function start_phisher(){
  # https://github.com/elreydetoda/king-phisher/blob/6acbbd856f849d407cc904c075441e0cf13c25cf/tools/install.sh#L593
  ./KingPhisherServer -L INFO -f ./server_config.yml
}

function main(){
  change_owners
  setup_postgres
  start_phisher
}

# https://elrey.casa/bash/scripting/main
if [[ "${0}" = "${BASH_SOURCE[0]:-bash}" ]] ; then
  main "${@}"
fi
