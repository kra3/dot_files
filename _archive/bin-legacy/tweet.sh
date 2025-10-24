#! /usr/bin/env bash
curl -u kra3:${1} -d status="${2}" http://twitter.com/statuses/update.xml
