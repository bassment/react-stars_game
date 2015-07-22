@Game = React.createClass
  getInitialState: ->
    selectedNumbers: []
    numberOfStars: _.random(1, 9)
    correct: null

  selectNumber: (clickedNumber) ->
    if clickedNumber not in @state.selectedNumbers
      @setState
        selectedNumbers: @state.selectedNumbers.concat(clickedNumber)

  unselectNumber: (clickedNumber) ->
    @setState selectedNumbers: _.without(@state.selectedNumbers, clickedNumber)

  sumOfSelectedNumbers: ->
    @state.selectedNumbers.reduce (memo, num) ->
      memo + num
    , 0

  checkAnswer: ->
    correct = @state.numberOfStars is @sumOfSelectedNumbers()
    @setState correct: correct

  render: ->
    React.DOM.div
      className: 'game'
      React.DOM.h2 null,
        'Play Nice'
        React.DOM.hr null,

      React.DOM.div
        className: 'clearfix'
        React.createElement StarsFrame, numberOfStars: @state.numberOfStars
        React.createElement ButtonFrame,
          selectedNumbers: @state.selectedNumbers
          correct: @state.correct
          checkAnswer: @checkAnswer
        React.createElement AnswerFrame,
          selectedNumbers: @state.selectedNumbers
          unselectNumber: @unselectNumber

      React.createElement NumberFrame,
        selectedNumbers: @state.selectedNumbers
        selectNumber: @selectNumber