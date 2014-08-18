fire = ->
  gap = Math.floor(Math.random() * 1201) + 600
  setTimeout(fire, gap)
  createFirework(30,125,7,5,null,null,null,null,false,true)

window.onload = fire
