@Game = React.createClass
  getInitialState: ->
    numberOfStars: @randomNumber()
    selectedNumbers: []
    usedNumbers: []
    redraws: 5
    correct: null
    doneStatus: null

  resetGame: ->
    @replaceState @getInitialState()

  randomNumber: ->
    _.random(1, 9)

  selectNumber: (clickedNumber) ->
    if clickedNumber not in @state.selectedNumbers
      @setState
        selectedNumbers: @state.selectedNumbers.concat(clickedNumber)
        correct: null

  unselectNumber: (clickedNumber) ->
    @setState
      selectedNumbers: _.without(@state.selectedNumbers, clickedNumber)
      correct: null

  sumOfSelectedNumbers: ->
    @state.selectedNumbers.reduce (memo, num) ->
      memo + num
    , 0

  checkAnswer: ->
    correct = @state.numberOfStars is @sumOfSelectedNumbers()
    @setState correct: correct

  acceptAnswer: ->
    usedNumbers = @state.usedNumbers.concat(@state.selectedNumbers)
    @setState
      selectedNumbers: []
      usedNumbers: usedNumbers
      correct: null
      numberOfStars: @randomNumber()
    , @updateDoneStatus

  redraw: ->
    if @state.redraws > 0
      @setState
        numberOfStars: @randomNumber()
        correct: null
        selectedNumbers: []
        redraws: @state.redraws - 1
      , @updateDoneStatus

  updateDoneStatus: ->
    if @state.usedNumbers.length is 9
      @setState doneStatus: 'You are a winner!'
    if (not @possibleSolutions()) and (@state.redraws is 0)
      @setState doneStatus: 'Game Over!'

  possibleSolutions: ->
    numberOfStars = @state.numberOfStars
    possibleNumbers = []

    for num in [1..9]
      if _.contains(@state.usedNumbers, num)
        possibleNumbers.push(num)

    possibleCombinationSum(possibleNumbers, numberOfStars)

  render: ->
    doneStatus = @state.doneStatus
    if doneStatus
      bottomFrame = React.createElement DoneFrame,
        doneStatus: @state.doneStatus
        resetGame: @resetGame
    else
      bottomFrame = React.createElement NumbersFrame,
        selectedNumbers: @state.selectedNumbers
        usedNumbers: @state.usedNumbers
        selectNumber: @selectNumber

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
          redraws: @state.redraws
          checkAnswer: @checkAnswer
          acceptAnswer: @acceptAnswer
          redraw: @redraw
        React.createElement AnswerFrame,
          selectedNumbers: @state.selectedNumbers
          unselectNumber: @unselectNumber

      bottomFrame