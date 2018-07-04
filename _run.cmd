@echo off
rem In case eventmachine fails to load:
rem gem uninstall eventmachine
rem gem install eventmachine --platform=ruby
set PAGES_REPO_NWO=flyway/flywaydb.org
jekyll serve -w -L