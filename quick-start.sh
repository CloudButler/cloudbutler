#!/bin/sh

# DEBUG Include docker install stuff?

# Get helper bundles.
mkdir bundles
cd bundles
git clone git@github.com:CloudButler/helper.git
cd ..

# Initialize Cog.
docker-compose up -d
sleep 30

# Configure helper bundles.
echo "COG_ADMIN_PASSWORD: '${COG_ADMIN_PASSWORD}'" >> bundles/helper/layers/base.yml
docker exec -it cloudbutler_cog_1 "cogctl bundle install bundles/helper/config.yaml -e -r default"
sleep 10
docker exec -it cloudbutler_cog_1 "cogctl bundle config create helper bundles/helper/layers/base.yaml --layer=base"
sleep 10

