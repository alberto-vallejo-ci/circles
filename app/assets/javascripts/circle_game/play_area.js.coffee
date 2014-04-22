$ ->
  window.CircleGame ||= {}

  class CircleGame.PlayArea
    constructor: ->
      @draw()
      @bindEvents()
      @

    draw: ->
      $('#main-container').addClass('play-area')

    bindEvents: ->
      $('body').on 'keydown', (e)->
        if e.keyCode is 38
          direction = 'top'
          new_value = parseInt($("#circle_#{Circle.circle_value}").css(direction)) - 10
        else if e.keyCode is 40
          direction = 'top'
          new_value = parseInt($("#circle_#{Circle.circle_value}").css(direction)) + 10
        else if e.keyCode is 39
          direction = 'left'
          new_value = parseInt($("#circle_#{Circle.circle_value}").css(direction)) + 10
        else if e.keyCode is 37
          direction = 'left'
          new_value = parseInt($("#circle_#{Circle.circle_value}").css(direction)) - 10

        $("#circle_#{Circle.circle_value}").css(direction, new_value)

        values = {
          token: Circle.circle_value,
          dir: direction,
          value: new_value,
          pos_x: parseInt($("#circle_#{Circle.circle_value}").css('left')),
          pos_y: parseInt($("#circle_#{Circle.circle_value}").css('top'))
        }

        Circle.dispatcher.trigger('circles.move', values)

      $('body').on 'keypress', (e) ->
        if e.keyCode is 13
          token = Circle.circle_value
          chat_input = $("#circle_#{token} .circle-chat")[0]
          name_input = $("#circle_#{token} .circle-label")[0]

          if e.target == chat_input
            data = { token: token, text: $(e.target).val()  }

            Circle.dispatcher.trigger('circles.chat', data)
            Circle.cleanChatBox $(e.target)

          else if e.target == name_input
            data = { token: token, text: $(e.target).val()  }

            Circle.dispatcher.trigger('circles.update', data)
            name_input.blur()
          else
            input_chat = $("#circle_#{token} .circle-chat")
            input_chat.removeClass 'hidden'
            input_chat.addClass 'highlight'
            input_chat.focus()