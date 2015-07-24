@AnswerFrame = React.createClass
  render: ->
    props = @props
    selectedNumbers =
      props.selectedNumbers.map (num, index) ->
        key = index * 10
        if index is 0
          React.DOM.span
            key: key
            className: 'number'
            onClick: props.unselectNumber.bind(null, num)
            num
        else
          React.DOM.span
            key: index
            className: 'plus-number'
            React.DOM.span
              className: 'glyphicon glyphicon-plus'
            React.DOM.span
              className: 'number'
              onClick: props.unselectNumber.bind(null, num)
              num

    React.DOM.div
      id: 'answer-frame'
      React.DOM.div
        className: 'well'
        selectedNumbers
        React.DOM.span
          onMouseEnter: @props.clickIcon
          className: 'glyphicon glyphicon-info-sign'