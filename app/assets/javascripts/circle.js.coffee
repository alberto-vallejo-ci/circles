@Circle = ->

  initialize: ->
    @dispatcher = new WebSocketRails "#{window.location.host + window.location.pathname}websocket"

    @dispatcher.bind 'circles.index', (circles) ->
      for circle in circles
        element = "<div id='circle_#{circle.token}'
                        class='circle'
                        style='border-color:#{circle.color}; top: #{circle.pos_y}px; left: #{circle.pos_x}px'></div>"

        $('#main-container').append element

    @dispatcher.bind 'circles.create', (circle) ->
      $('#main-container').append "<div id='circle_#{circle.token}' class='circle' style='border-color:#{circle.color}'></div>"

    @dispatcher.bind 'circles.destroy', (circle_value)->
      $("#circle_#{circle_value}").remove()

    @dispatcher.bind 'circles.move', (values)->
      $("#circle_#{values.token}").css(values.dir, values.value)


    @dispatcher.trigger('circles.index')

  dispatchCreate: ->
    token = String(Math.random()).substring(2,12)
    @circle_value = token

    @dispatcher.trigger('circles.create', token)
