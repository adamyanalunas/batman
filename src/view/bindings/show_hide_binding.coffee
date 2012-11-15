#= require ./abstract_binding

class Batman.DOM.ShowHideBinding extends Batman.DOM.AbstractBinding
  onlyObserve: 'data'

  constructor: (definition) ->
    display = definition.node.style.display
    display = '' if not display or display is 'none'
    @originalDisplay = display

    super

  dataChange: (value) ->
    view = Batman._data @node, 'view'
    if !!value is not @invert
      view?.fire 'beforeAppear', @node

      Batman.data(@node, 'show')?.call(@node)
      @node.style.display = @originalDisplay

      view?.fire 'appear', @node
    else
      view?.fire 'beforeDisappear', @node

      if typeof (hide = Batman.data(@node, 'hide')) is 'function'
        hide.call @node
      else
        Batman.DOM.setStyleProperty(@node, 'display', 'none', 'important')

      view?.fire 'disappear', @node
