$ ->
  window.dispatcher = new WebSocketRails 'localhost:3000/websocket'

  dispatcher.trigger('circles.create')

  dispatcher.on_open = ->
    console.log 'Dispatcher Open'

  dispatcher.on_close = ->
    console.log 'Dispatcher Close'

  dispatcher.bind 'circles.create', (value) ->
    $('#main-container').append "<div id='circle_#{value}' class='circle'></div>"
    window.circle_value = value

  $('body').on 'keyup', (e)->
    if e.keyCode is 87
      direction = 'top'
      new_value = parseInt($("#circle_#{window.circle_value}").css(direction)) - 5
    else if e.keyCode is 83
      direction = 'top'
      new_value = parseInt($("#circle_#{window.circle_value}").css(direction)) + 5
    else if e.keyCode is 68
      direction = 'left'
      new_value = parseInt($("#circle_#{window.circle_value}").css(direction)) + 5
    else if e.keyCode is 65
      direction = 'left'
      new_value = parseInt($("#circle_#{window.circle_value}").css(direction)) - 5

    $("#circle_#{window.circle_value}").css(direction, new_value)