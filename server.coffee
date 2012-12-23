express = require 'express'
ejs = require 'ejs'
arDrone = require("ar-drone")

control = arDrone.createUdpControl()
start = Date.now()
ref = {}
pcmd = {}
app = express()

app.configure ->
  app.use(express.bodyParser())
  app.set('dirname', __dirname)
  app.use(app.router)
  app.use(express.static(__dirname + "/public/"))
  app.use(express.errorHandler({ dumpExceptions: true, showStack: true}))
  app.set('views',__dirname + "/views/")

app.get "/", (req,res) ->
  res.render 'index.ejs'

port = process.env.PORT || 8080
app.listen port
console.log "Listening on Port '#{port}'"

class Drone
  constructor: (speed) ->
    @speed = speed
    @accel = 0.01
  takeoff: ->
    console.log "Takeoff ..."
    ref.emergency = false
    ref.fly = true

  land: ->
    console.log "Landing ..."
    ref.fly = false
    pcmd = {}

  stop: ->
    pcmd = {}

  commands: (names) =>
    pcmd = {}
    for name in names
      pcmd[name] = @speed
    console.log 'PCMD: ', pcmd
  
  increaseSpeed: =>
    @speed += @accel
    console.log @speed

  decreaseSpeed: =>
    @speed -= @accel
    console.log @speed

setInterval (->
  control.ref ref
  control.pcmd pcmd
  control.flush()
), 30

drone = new Drone(0.5)

drone.speed = 0.4

console.log drone 

io = require("socket.io").listen(8081)
io.sockets.on "connection", (socket) ->
  socket.on "takeoff", drone.takeoff
  socket.on "land", drone.land
  socket.on "stop", drone.stop
  socket.on "command", drone.commands
  socket.on "increaseSpeed", drone.increaseSpeed
  socket.on "decreaseSpeed", drone.decreaseSpeed