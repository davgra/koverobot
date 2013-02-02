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
* Robots should optimise to fastest route
* Game should run on Windows (it might already but test it)
* refactor
* set limits on zoom
* sites should produce on given producerate


## Changelog

### 2/2 17:20
* Sites should display current stock

### 2/2 16:50
* Robots move faster on roads

### 2/2 16:15
* Player kan now build roads

### 2/2 12:00
* Sites produces based on income

### 2/2 10:10
* Sites keep stock of goods

### 2/2 8:00
* Robots selects destination based on their cargo.

### 1/2
* The robots travel randomly between sites, transporing goods
