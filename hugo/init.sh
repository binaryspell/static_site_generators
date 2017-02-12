#!/bin/bash -e
# this runs inside a docker container

repo_name="$1"
repo_path="$(realpath "$2")"

cd "$repo_path"

tmp_dir="/tmp/$(date +%Y%m%d%H%M%S)/$repo_name"
# create a new hugo site
mkdir -p "$tmp_dir"
cd "$tmp_dir/.."
hugo new site "$repo_name"
mv -v $tmp_dir/* "$repo_path/"

cd "$repo_path"
# create a new post
hugo new post/hello-world.md
sed -i -e 's/draft = true/draft = false/g' content/post/hello-world.md

# create theme
git submodule add "https://github.com/vjeantet/hugo-theme-casper" themes/casper
echo 'theme = "casper"' >> "config.toml"

#docker run --rm --volume="$repo_path:/opt/build" "$docker_image" hugo new site "$repo_name" "$repo_path"""
