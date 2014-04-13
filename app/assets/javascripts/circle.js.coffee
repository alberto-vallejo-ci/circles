@Circle = ->

  initialize: ->
    @dispatcher = new WebSocketRails "#{window.location.host + window.location.pathname}websocket"
    @circle_label = ''

    @dispatcher.bind 'circles.index', (circles) ->
      for circle in circles
        $('#main-container').append Circle.drawCircle circle

    @dispatcher.bind 'circles.create', (circle) ->
      $('#main-container').append Circle.drawCircle circle
      Circle.circle_label = circle.label

    @dispatcher.bind 'circles.destroy', (circle_value)->
      $("#circle_#{circle_value}").remove()

    @dispatcher.bind 'circles.move', (values)->
      $("#circle_#{values.token}").css(values.dir, values.value)

    @dispatcher.bind 'circles.update', (circle) ->
      $("#circle_#{circle.token} .circle-label").val circle.label
      Circle.circle_label = circle.label

    @dispatcher.trigger('circles.index')

  dispatchCreate: ->
    token = String(Math.random()).substring(2,12)
    @circle_value = token

    @dispatcher.trigger('circles.create', token)

  drawCircle: (values) ->
    "<div id='circle_#{values.token}'
          class='circle'
          style='border-color:#{values.color}; top: #{values.pos_y}px; left: #{values.pos_x}px'>
      <input type='text' class='circle-label' value='#{values.label}' #{Circle.disableInput(values.token)} />
    </div>"

  disableInput: (token)->
    'disabled' unless Circle.isCircleOwner(token)

  isCircleOwner: (token)->
    Circle.circle_value == token

