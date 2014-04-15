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
      action = 'update'
    else if e.keyCode is 67
      action = 'chat'

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

    else if action is 'update'
      new_value = $(e.target).val()
      data = { token: Circle.circle_value, text: new_value  }

      input_classes = $(e.target).attr('class').split(' ')

      if Circle.inputIncludeClass(input_classes, 'circle-label')
        Circle.dispatcher.trigger('circles.update', data)
      else if Circle.inputIncludeClass(input_classes, 'circle-chat')
        Circle.dispatcher.trigger('circles.chat', data)
        Circle.cleanChatBox $(e.target)

    else
      input_chat = $("#circle_#{Circle.circle_value} .circle-chat")
      input_chat.removeClass 'hidden'
      input_chat.addClass 'highlight'
      input_chat.focus()