@NumberFrame = React.createClass
  render: ->
    selectedNumbers = @props.selectedNumbers
    selectNumber = @props.selectNumber

    React.DOM.div
      id: 'numbers-frame'
      React.DOM.div
        className: 'well'

        for num in [1..9]
          className = 'number selected-' + (selectedNumbers.indexOf(num) >= 0)
          React.DOM.div
            key: num
            className: className
            onClick: selectNumber.bind(null, num)
            num