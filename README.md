# KoveRobot

A little game written in jruby using lwjgl and slick2d.

## Usage

in linux you have to:

    export LD_LIBRARY_PATH=./lib/java/
    jruby game.rb

unless you use rvm, in which case you just run:

    ruby game.rb

## Gameplay

In the game world there is a number of factories and cities. These
produce and/or consume commodities. There is a number of robot vehicles
transporting goods. It's your mission, if you accept the challenge, to
build roads so that the robots can travel fast enough to satisfy the
supply chain.

### Keys

These are the keys to use:

* left mousebutton to place road
* right mousebutton to remove road
* arrowkeys to pan
* ctrl up/down to zoom
* esc to quit
* r to restart
* s to save
* l to load

## Todo

* Game should run on Windows (it might already but test it)
* refactor
* collision detection


## Changelog

### 3/2 14:30
* Robots gets godds from site with most goods

### 3/2 14:00
* Robots takes fastest route

### 3/2 11:10
* Path optimiser
* Robots avoids obstacles

### 2/2 22:00
* sites produce on given producerate

### 2/2 20:50
* set limits on zoom

### 2/2 18:10
* added logs produser

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
