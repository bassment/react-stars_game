@DoneFrame = React.createClass
  render: ->
    React.DOM.div
      className: 'well text-center'
      React.DOM.h2 null,
        @props.doneStatus
      React.DOM.button
        className: 'btn btn-default'
        onClick: @props.resetGame
        'Play Again!'