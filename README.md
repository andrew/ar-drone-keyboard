# AR Drone Keyboard Controller

Control your Parrot AR Drone with your a keyboard via a web-browser

## Libraries

* webserver - express (https://github.com/visionmedia/express)
* websockets - socket.io (https://github.com/LearnBoost/socket.io)
* drone client - node-ar-drone (https://github.com/felixge/node-ar-drone)
* keyboard library - KeyboardJS (https://github.com/RobertWHurst/KeyboardJS)

## Usage

1. git clone https://github.com/andrew/ar-drone-keyboard

2. cd ar-drone-keyboard

3. npm install

4. Connect to wifi on parrot ar drone

5. run `coffee server.coffee` in the root of the app

6. open `http://localhost:8080`

## Controls

Take off with `space`

forward,backward,left,right with `wsad`

up, down, turn left, turn right with `ikjl`

land with `x`

increase speed `=`
decrease speed `-`

## Copyright

Copyright (c) 2013 Andrew Nesbitt. See [LICENSE](https://github.com/andrew/ar-drone-keyboard/blob/master/LICENSE) for details.