#!/bin/bash

majorVersion=`grep "majorVersion =" __init__.py | cut -d "=" -f 2`
minorVersion=`grep "minorVersion =" __init__.py | cut -d "=" -f 2`
patchLevel=`grep "patchLevel =" __init__.py | cut -d "=" -f 2`
preVersion=`grep "preVersion =" __init__.py | cut -d "=" -f 2`


if [ $preVersion != "0" ] && [ $patchLevel != "0" ]; then
  echo "!!! ILLEGAL CONDITION !!!"
  echo "preVersion!=0 and patchLevel!=0 at the same time"
  exit 1
fi

if [ $preVersion == "0" ]; then
  if [ $patchLevel == "0" ]; then
    export DIRACVersion="v${majorVersion// }r${minorVersion// }"
  else
    export DIRACVersion="v${majorVersion// }r${minorVersion// }p${patchLevel// }"
  fi
else
  export DIRACVersion="v${majorVersion// }r${minorVersion// }-pre${preVersion// }"
fi

if [ $TRAVIS_BRANCH == rel-* ]; then
  DIRACLastTag=`git tag -l ${TRAVIS_BRANCH//rel-}* --sort=committerdate | tail -1`
else
  DIRACLastTag="Not tagged"
fi

echo ""
echo "The branch is ${TRAVIS_BRANCH}"
echo "The version in __init__.py is ${DIRACVersion}"
echo "The last tag of branch ${TRAVIS_BRANCH} is $DIRACLastTag"
echo ""

if [ $DIRACVersion == $DIRACLastTag ]; then
  echo "The version in __init__.py and the last tag match -- PASS"
  echo ""
  exit 0
else
  echo "The version in __init__.py and the last tag DO NOT MATCH -- FAIL"
  echo ""
  exit 1
fi