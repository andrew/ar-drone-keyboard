express = require 'express'
ejs = require 'ejs'
app = express()

app.configure ->
  app.use(express.bodyParser())
  app.set('dirname', __dirname)
  app.use(app.router)
  app.use(express.static(__dirname + "/public/"))
  app.use(express.errorHandler({ dumpExceptions: true, showStack: true}))
  app.set('views',__dirname + "/views/")

# server routes
app.get "/", (req,res) ->
  res.render 'index.ejs'

port = process.env.PORT || 8080
app.listen port
console.log "Listening on Port '#{port}'"

#----------------

arDrone = require("ar-drone")
control = arDrone.createUdpControl()
start = Date.now()

ref = {}
pcmd = {}

class Drone
  constructor: (name) ->
    @name = name
  takeoff: ->
    console.log "Takeoff ..."
    ref.emergency = false
    ref.fly = true

  land: ->
    console.log "Landing ..."
    ref.fly = false
    pcmd = {}

  front: ->
    pcmd.front = 0.5
  back: ->
    pcmd.back= 0.5
  left: ->
    pcmd.left = 0.5
  right: ->
    pcmd.right = 0.5
  counterClockwise: ->
    pcmd.counterClockwise = 0.5
  clockwise: ->
    pcmd.clockwise = 0.5
  up: ->
    pcmd.up = 0.5
  down: ->
    pcmd.down = 0.5
  stop: ->
    pcmd = {}

  command: (name) ->
    console.log name
    pcmd[name] = 0.5
    
  commands: (names) ->
    pcmd = {}
    for name in names
      pcmd[name] = 0.5
    console.log 'PCMD: ', pcmd

setInterval (->
  control.ref ref
  control.pcmd pcmd
  control.flush()
), 30

#----------------

drone = new Drone

io = require("socket.io").listen(8081)
io.sockets.on "connection", (socket) ->
  socket.emit "news",
    hello: "world"

  socket.on "takeoff", drone.takeoff
  socket.on "land", drone.land
  socket.on "stop", drone.stop
  socket.on "command", drone.commands