#!/bin/sh

PROJECT=$(dirname $(readlink -f "$0"))

if [ -e $PROJECT/target ]; then
    docker run --rm -i -v $PROJECT:/src alpine:3.6 rm -rf /src/target
fi

# Structure
docker run --rm -i \
    -v $PROJECT:/src \
    -v $PROJECT/target:/target \
    difi/vefa-structure:0.6.1

# Schematron
for sch in $PROJECT/rules/sch/*.sch; do
    docker run --rm -i -v $PROJECT:/src -v $PROJECT/target/schematron:/target klakegg/schematron prepare /src/rules/sch/$(basename $sch) /target/$(basename $sch)
done
docker run --rm -i -v $PROJECT/target/site/files:/src alpine:3.6 rm -rf /src/PEPPOLBIS-Upgrade-Schematron.zip
docker run --rm -i -v $PROJECT/target/schematron:/src -v $PROJECT/target/site/files:/target -w /src kramos/alpine-zip -r /target/PEPPOLBIS-Upgrade-Schematron.zip .

# Example files
docker run --rm -i -v $PROJECT/target/site/files:/src alpine:3.6 rm -rf /src/PEPPOLBIS-Examples.zip
docker run --rm -i -v $PROJECT/rules/examples:/src -v $PROJECT/target/site/files:/target -w /src kramos/alpine-zip -r /target/PEPPOLBIS-Examples.zip .


# Guides
docker run --rm -i -v $PROJECT:/documents -v $PROJECT/target:/target difi/asciidoctor

# Fix ownership
docker run --rm -i -v $PROJECT:/src alpine:3.6 chown -R $(id -g $USER).$(id -g $USER) /src/target
