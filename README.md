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
prpduce and/or consume commodities. There is a number of robot vehicles
transporting goods. It's your mission, if you accept the challenge, to
build roads so that the robots can travel fast enough to satify the
supply chain.

## Changelog

* The robots travel randomly between sites, transporing goods

## Todo

* Robots should select destination based on their cargo.

