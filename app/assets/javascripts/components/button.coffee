@ButtonFrame = React.createClass
  render: ->
    correct = @props.correct

    switch correct
      when true
        button =
          React.DOM.button
            className: 'btn btn-success btn-lg'
            React.DOM.span
              className: 'glyphicon glyphicon-ok'

      when false
        button =
          React.DOM.button
            className: 'btn btn-danger btn-lg'
            React.DOM.span
              className: 'glyphicon glyphicon-remove'
      else
        disabled = _.isEmpty(@props.selectedNumbers)
        button =
          React.DOM.button
            className: 'btn btn-primary btn-lg'
            disabled: disabled
            onClick: @props.checkAnswer
            '='

    React.DOM.div
      id: 'button-frame'
      button
