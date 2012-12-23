arDrone = require("ar-drone")
control = arDrone.createUdpControl()
start = Date.now()

ref = {}
pcmd = {}

# console.log "Recovering from emergency mode if there was one ..."
# ref.emergency = true

takeoff = ->
  console.log "Takeoff ..."
  ref.emergency = false
  ref.fly = true

land = ->
  console.log "Landing ..."
  ref.fly = false
  pcmd = {}

command = (name) ->
  console.log name
  pcmd[name] = 0.5

setTimeout takeoff, 1000

setTimeout (->
  command('counterClockwise')
), 6000

setTimeout land, 8000

setInterval (->
  control.ref ref
  control.pcmd pcmd
  control.flush()
), 30