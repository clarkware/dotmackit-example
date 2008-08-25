#!/bin/sh

xcodebuild -alltargets clean

xcodebuild -target DMAdmin -buildstyle Deployment build
