$ ->
  window.onbeforeunload = ->
    Circle.dispatcher.trigger('circles.destroy', Circle.circle_value)
    return

  $('body').on 'keyup', (e)->
    if e.keyCode is 87
      direction = 'top'
      new_value = parseInt($("#circle_#{Circle.circle_value}").css(direction)) - 5
    else if e.keyCode is 83
      direction = 'top'
      new_value = parseInt($("#circle_#{Circle.circle_value}").css(direction)) + 5
    else if e.keyCode is 68
      direction = 'left'
      new_value = parseInt($("#circle_#{Circle.circle_value}").css(direction)) + 5
    else if e.keyCode is 65
      direction = 'left'
      new_value = parseInt($("#circle_#{Circle.circle_value}").css(direction)) - 5

    $("#circle_#{Circle.circle_value}").css(direction, new_value)

    values = {
      token: Circle.circle_value,
      dir: direction,
      value: new_value,
      pos_x: parseInt($("#circle_#{Circle.circle_value}").css('left')),
      pos_y: parseInt($("#circle_#{Circle.circle_value}").css('top'))
    }

    Circle.dispatcher.trigger('circles.move', values)