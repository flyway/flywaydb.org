@echo off
docker run --rm -v "%CD%:/srv/jekyll" -p 35729:35729 -p 4000:4000 -e PAGES_REPO_NWO='flyway/flywaydb.org' -it jekyll/jekyll:3.8 jekyll serve --livereload --incremental --force_polling