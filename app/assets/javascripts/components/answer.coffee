@AnswerFrame = React.createClass
  render: ->
    props = @props
    selectedNumbers =
      props.selectedNumbers.map (num) ->
        React.DOM.span
          key: num
          onClick: props.unselectNumber.bind(null, num)
          num

    React.DOM.div
      id: 'answer-frame'
      React.DOM.div
        className: 'well'
        selectedNumbers