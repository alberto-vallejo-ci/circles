$ ->
  window.CircleGame ||= {}

  class CircleGame.Circle
    constructor: ->
      @bindEvents()
      @loadCircles()
      @createCircle()
      @

    bindEvents: ->
      @dispatcher = new WebSocketRails "#{window.location.host + window.location.pathname}websocket"
      @circle_label = ''

      @dispatcher.bind 'circles.index', (circles) =>
        for circle in circles
          $('.play-area').append @draw_circle circle

      @dispatcher.bind 'circles.create', (circle) =>
        $('#main-container').append @draw_circle circle
        @circle_label = circle.label
        @bindChat()

      @dispatcher.bind 'circles.destroy', (circle_value)->
        $("#circle_#{circle_value}").remove()

      @dispatcher.bind 'circles.move', (values)=>
        $("#circle_#{values.token}").css(values.dir, values.value)
        Utils.validateTouch(@circle_value, values.token) unless  @circle_value is values.token

      @dispatcher.bind 'circles.update', (circle) ->
        $("#circle_#{circle.token} .circle-label").val circle.label
        @circle_label = circle.label

      @dispatcher.bind 'circles.chat', (data) =>
        label_chat = $("#circle_#{data['token']} .label-chat")
        label_chat.html data['text']
        setTimeout (=>
          @cleanLabelBox(label_chat)
          return
        ), 3000

      @dispatcher.bind 'circles.touch', (circle) ->
        $("#circle_#{circle.token}").addClass 'touched'

    loadCircles: ->
      @dispatcher.trigger('circles.index')

    createCircle: ->
      token = String(Math.random()).substring(2,12)
      @circle_value = token

      @dispatcher.trigger('circles.create', token)

    draw_circle: (circle) ->
      "<div id='circle_#{circle.token}'
            class='circle #{circle.state}'
            style='border-color:#{circle.color}; top: #{circle.pos_y}px; left: #{circle.pos_x}px'>
        <label class='label-chat'></label>
        <input type='text' class='circle-chat hidden' value='' />
        <input type='text' class='circle-label' value='#{circle.label}' #{@disableInput(circle.token)} />
      </div>"

    disableInput: (token)->
      'disabled' unless @isCircleOwner(token)

    isCircleOwner: (token)->
      @circle_value == token

    bindChat: =>
      $("#circle_#{@circle_value} .circle-chat").on 'blur', (e)=>
        @cleanChatBox $(e.target)

    cleanChatBox: (input_chat)->
      input_chat.val ''
      input_chat.removeClass 'highligth'
      input_chat.addClass 'hidden'

    cleanLabelBox: (label_chat) ->
      label_chat.html ''

