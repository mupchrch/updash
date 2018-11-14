class Dashing.Clock extends Dashing.Widget

  ready: ->
    setInterval(@startTime, 500)

  startTime: =>
    today = new Date()

    hoursMinutesAmPm = today.toLocaleString('en-US', { hour: 'numeric', minute: 'numeric', hour12: true })

    @set('time', hoursMinutesAmPm)
    @set('date', today.toDateString())
