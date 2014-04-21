$ ->
  window.CircleGame ||= {}

  window.onbeforeunload = ->
    Circle.dispatcher.trigger('circles.destroy', Circle.circle_value)
    return