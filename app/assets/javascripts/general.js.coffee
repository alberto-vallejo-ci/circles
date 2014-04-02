$ ->
  window.dispatcher = new WebSocketRails 'localhost:3000/websocket'

  dispatcher.on_open = ->
    console.log 'Dispatcher Open'

  dispatcher.bind 'circles.create', (values) ->
    $('#start-link').hide()
    $('#main-container').html '<div class="circle"></div>'


  $('#start-link').on 'click', (e) ->
    e.preventDefault()
    values = { msg: 'Batman' }
    dispatcher.trigger('circles.create', values)

  $('body').on 'keyup', (e)->
    if e.keyCode is 87
      direction = 'top'
      new_value = parseInt($('.circle').css(direction)) - 5
    else if e.keyCode is 83
      direction = 'top'
      new_value = parseInt($('.circle').css(direction)) + 5
    else if e.keyCode is 68
      direction = 'left'
      new_value = parseInt($('.circle').css(direction)) + 5
    else if e.keyCode is 65
      direction = 'left'
      new_value = parseInt($('.circle').css(direction)) - 5

    $('.circle').css(direction, new_value)