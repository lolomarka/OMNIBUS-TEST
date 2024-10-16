#
# Copyright 2024 YOUR NAME
#
# All Rights Reserved.
#

name "TEST"
maintainer "CHANGE ME"
homepage "https://CHANGE-ME.com"

# Defaults to C:/TEST on Windows
# and /opt/TEST on all other platforms
install_dir "#{default_root}/#{name}"

build_version Omnibus::BuildVersion.semver
build_iteration 1

# Creates required build directories
dependency "preparation"

# TEST dependencies/components
# dependency "somedep"

exclude "**/.git"
exclude "**/bundler/git"
