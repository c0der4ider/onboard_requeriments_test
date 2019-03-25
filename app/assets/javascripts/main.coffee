root = exports ? this
root.Main = ( ->

  init = (layout) ->
    if layout == 'application'
      console.log 'testing'
      configure($(document))

  configure = ($element) ->
    true

  {
    init: init,
    configure: configure
  }
)()
