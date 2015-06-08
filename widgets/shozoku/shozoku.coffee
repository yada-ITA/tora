class Dashing.Shozoku extends Dashing.Widget

  ready: ->
    @set_okng_graph()
    @set_complete_graph()
    # This is fired when the widget is done being rendered

  onData: (data) ->
    @set_okng_graph()
    @set_complete_graph()
    # Handle incoming data
    # You can access the html node of this widget with `@node`
    # Example: $(@node).fadeOut().fadeIn() will make the node flash each time data comes in.
  
  set_okng_graph: ->
    header = @get('header')
    ok_count = @get('ok')
    ng_count = @get('ng')
    okng  = {
      labels : header,
      datasets : [
        {
          fillColor : "#aaf2fb",
          strokeColor : "#eeeeee",
          data : ok_count
        },
        {
          fillColor : "#ffb6b9",
          strokeColor : "#eeeeee",
          data : ng_count
        }
      ]
    }
    options = {
      scaleLineColor : "#eeeeee",
      scaleFontColor : "#eeeeee"
    }
    ctx_okng = $(@node).find('#shozoku_cv_okng')[0].getContext('2d')
    new Chart(ctx_okng).Bar(okng, options)
    
  set_complete_graph: ->
    header = @get('header')
    complete = @get('complete')
    wait = @get('wait')
    complete_wait  = {
        labels : header,
        datasets : [
          {
          fillColor : "#cc33cc",
          strokeColor : "#eeeeee",
          data : complete
          },
          {
          fillColor : "#333333",
          strokeColor : "#eeeeee",
          data : wait
          }
        ]
      }
    options = {
      scaleLineColor : "#eeeeee",
      scaleFontColor : "#eeeeee"
    }
    ctx_complete = $(@node).find('#shozoku_cv_complete')[0].getContext('2d')
    new Chart(ctx_complete).Bar(complete_wait, options)
