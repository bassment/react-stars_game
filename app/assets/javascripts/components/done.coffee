@DoneFrame = React.createClass
  render: ->
    React.DOM.div
      className: 'well text-center'
      React.DOM.h2 null,
        @props.doneStatus
      React.DOM.h4
        className: 'your-time'
        "\n Your Time is: "
        React.DOM.b
          @props.time
        ' Seconds'
      React.DOM.h4
        className: 'your-score'
        "\n Your Score is: "
          React.DOM.b null,
            @props.score
          ' Points'
      React.DOM.button
        className: 'btn btn-default'
        onClick: @props.resetGame
        'Play Again!'
      if (@props.showAddResult) and (@props.doneStatus is 'You are a winner!')
        React.DOM.button
          className: 'btn btn-success'
          onClick: @props.addResult
          'Add Result!'