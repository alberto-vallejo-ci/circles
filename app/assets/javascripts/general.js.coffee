$ ->
  window.onbeforeunload = ->
    Circle.dispatcher.trigger('circles.destroy', Circle.circle_value)
    return

  $('body').on 'keyup', (e)->

    action = 'move'

    if e.keyCode is 38
      direction = 'top'
      new_value = parseInt($("#circle_#{Circle.circle_value}").css(direction)) - 5
    else if e.keyCode is 40
      direction = 'top'
      new_value = parseInt($("#circle_#{Circle.circle_value}").css(direction)) + 5
    else if e.keyCode is 39
      direction = 'left'
      new_value = parseInt($("#circle_#{Circle.circle_value}").css(direction)) + 5
    else if e.keyCode is 37
      direction = 'left'
      new_value = parseInt($("#circle_#{Circle.circle_value}").css(direction)) - 5
    else if e.keyCode is 13
      action = 'edit'

    if action is 'move'
      $("#circle_#{Circle.circle_value}").css(direction, new_value)

      values = {
        token: Circle.circle_value,
        dir: direction,
        value: new_value,
        pos_x: parseInt($("#circle_#{Circle.circle_value}").css('left')),
        pos_y: parseInt($("#circle_#{Circle.circle_value}").css('top'))
      }

      Circle.dispatcher.trigger('circles.move', values)
    else
      new_value = $("#circle_#{Circle.circle_value} .circle-label").val()
      values = { token: Circle.circle_value, label: new_value  }
      Circle.dispatcher.trigger('circles.update', values) if new_value isnt Circle.circle_label