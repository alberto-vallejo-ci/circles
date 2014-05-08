$ ->
  window.CircleGame ||= {}

  class CircleGame.Utils
    validateTouch: (localCircle, externalCircle) ->
      localTop = @getPosition(localCircle, 'top')
      localLeft = @getPosition(localCircle, 'left')

      externalTop = @getPosition(externalCircle, 'top')
      externalLeft = @getPosition(externalCircle, 'left')

      localVerLimits = [localTop, localTop + 40]        #[100, 140]
      localHorLimits = [localLeft, localLeft + 40]      #[100, 140]

      externalVerLimits = [externalTop, externalTop + 40]       #[100, 140]
      externalHorLimits = [externalLeft, externalLeft + 40]     #[100, 140]

      if @insideRange(localVerLimits, externalVerLimits) and @insideRange(localHorLimits, externalHorLimits)
        data = { token: localCircle }
        Circle.dispatcher.trigger('circles.touch', data)

    getPosition: (token, position)->
      parseInt($("#circle_#{token}").css(position))

    between: (value, range) ->
      value >= range[0] && value <= range[1]

    insideRange: (local_range, external_range) ->
      @between(external_range[0], local_range) or @between(external_range[1], local_range)
