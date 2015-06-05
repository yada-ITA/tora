class Dashing.Perform extends Dashing.Widget

  ready: ->
    @set_quality_graph()
    @set_progress_graph()
    
  
  onData: (data) ->
    @set_quality_graph()
    @set_progress_graph()


  set_progress_graph: ->
    yotei = @get('complete');
    zan = @get('zan')
    progress = [
        {
            value: yotei,
            color:'#cc33cc'
        },
        {
            value: zan,
            color: '#333333'
        }
    ]
    ctx_progress = $(@node).find('#perform_cv_progress')[0].getContext('2d')
    new Chart(ctx_progress).Doughnut(progress)

  set_quality_graph: ->
    ok = @get('ok');
    ng = @get('ng')
    quality = [
        {
            value: ok,
            color:"#aaf2fb"
        },
        {
            value: ng,
            color: "#ffb6b9"
        }
    ]
    ctx_quality = $(@node).find('#perform_cv_quality')[0].getContext('2d')
    new Chart(ctx_quality).Doughnut(quality)
