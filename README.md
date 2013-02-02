# KoveRobot

A little game written in jruby using lwjgl and slick2d.

## Usage

in linux you have to:

    export LD_LIBRARY_PATH=./lib/java/
    jruby game.rb

unless you use rvm, in which case you just run

    ruby game.rb

## Gameplay

In the game world there is a number of factories and cities. These
produce and/or consume commodities. There is a number of robot vehicles
transporting goods. It's your mission, if you accept the challenge, to
build roads so that the robots can travel fast enough to satify the
supply chain.

## Todo

* Robots should avoid obstacles
* Player should be able to build roads
* Robots should move faster on roads
* Robots should optimise to fastest route
* Sites should display current stock


## Changelog

### 2/2 10:10
* Sites should keep stock of goods

### 2/2 8:00
* Robots selects destination based on their cargo.

### 1/2
* The robots travel randomly between sites, transporing goods
