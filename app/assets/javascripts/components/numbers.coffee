@NumbersFrame = React.createClass
  render: ->
    selectedNumbers = @props.selectedNumbers
    usedNumbers = @props.usedNumbers
    selectNumber = @props.selectNumber

    React.DOM.div
      id: 'numbers-frame'
      React.DOM.div
        className: 'well'

        for num in [1..9]
          className = 'number selected-' + _.contains(selectedNumbers, num)
          className += ' used-' + _.contains(usedNumbers, num)
          React.DOM.div
            key: num
            className: className
            onClick: selectNumber.bind(null, num)
            num