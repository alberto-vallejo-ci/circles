$ ->
  window.CircleGame ||= {}

  class CircleGame.Utils
    includeClass: (array, value) ->
      if $.inArray(value, array) >= 0 then true else false