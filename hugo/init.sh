#!/bin/bash -e
# this runs inside a docker container

set -x

echo "$*"

repo_name="$1"
repo_url="$2"
site_url="$3"
repo_path="/opt/build"

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
echo -e "# Hello, World!\nWelcome to your doom!" >> content/post/hello-world.md

# create theme
git submodule add "https://github.com/htdvisser/hugo-base16-theme" themes/base16
echo 'theme = "base16"' >> "config.toml"
sed -i -e '/baseURL/Id' "config.toml"
echo "baseURL=\"$site_url\"" >> "config.toml"
echo "relativeURLS = true" >> "config.toml"
echo "canonifyurls = true" >> "config.toml"

cat > ~/.gitconfig <<EOS
[user]
  email = binaryspell@cosmicvent.com
  name = Binary Spell
EOS

# init commit
git add .
git commit -m init

# build it
hugo --verbose

mv public /tmp/pub
git checkout -b gh-pages
rm -rf *
mv /tmp/pub/* .

git add .
git commit -m "Built site"

# push to github
git remote add origin "$repo_url"
git push origin master
git push origin gh-pages

