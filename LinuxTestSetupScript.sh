#!/bin/bash
echo "*************************"

echo "***** Upgrading *****"
apt-get -y --force-yes update && apt-get -y --force-yes upgrade
echo "*************************"

echo 
echo "***** curl:"
apt-get install curl

echo 
echo "**** rvm:"
command curl -sSL https://rvm.io/mpapis.asc | gpg --import -
\curl -L https://get.rvm.io | bash -s stable

echo
echo "**** Sourcing rvm"
source ~/.rvm/scripts/rvm

echo "**** Installing RVM requisites:"
rvm requirements

echo
echo "**** Installing Ruby:"
rvm install ruby

echo
echo "**** Use the default version"
rvm use ruby --default

echo
echo "**** Installing rubygems:"
rvm rubygems current

echo
echo "**** Installing Cucumber:"
gem install cucumber

read -p "Would you like to test cucumber?" -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then 
   mkdir CucumberDemo
   echo 
   echo "Creating Gemfile"
   cat > CucumberDemo/Gemfile << EOF
source "http://rubygems.org"
gem "cucumber"
gem "capybara"
gem "rspec"
gem "selenium-webdriver"
gem "rake"
gem "rest-client"
gem "json"
EOF
   cd CucumberDemo
   echo
   echo "***** Bundle install..."
   gem install bundler
   bundle install
   

   echo 
   echo 
   echo "Creating test feature file in CucumberDemo/features"
   mkdir features 
   cat > features/demo.feature << EOF
Feature: Cucumber Demo

Sample feature file to demonstrate the successful installation of cucumber files.

Scenario: Test the cucumber installation
Given I have isntalled all the prerequisites required for cucumber
When I run this cucumber test
Then it should run the demo feature file
EOF
   cucumber
fi

echo
echo
echo "Setup script complete"

   
