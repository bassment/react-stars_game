@Game = React.createClass
  getInitialState: ->
    numberOfStars: @randomNumber()
    selectedNumbers: []
    usedNumbers: []
    redraws: 25
    correct: null
    doneStatus: null
    clock: {}
    showTimer: true
    showAddResult: false
    time: 0
    score: 0

  addResult: ->
    @refs.results.addResult()
    @setState showAddResult: false

  calculateLooserScore: ->
    score = 0
    @setState score: score

  calculateWinnerScore: (time) ->
    score = (12345 * @state.redraws) - (85 * time)
    if score < 0
      score = 0
    @setState score: score

  stopTheClockCalculateWinner: ->
    clock = @state.clock
    clock.stop ->
        this._destroyTimer()
    time = clock.getTime().time
    @removeTimer()
    @setState time: time
    @calculateWinnerScore(time)

  stopTheClockCalculateLooser: ->
    clock = @state.clock
    clock.stop ->
        this._destroyTimer()
    time = clock.getTime().time
    @removeTimer()
    @calculateLooserScore
    @setState time: time

  resetGame: ->
    @replaceState @getInitialState()

  removeTimer: ->
    @setState showTimer: false

  randomNumber: ->
    _.random(1, 9)

  selectNumber: (clickedNumber) ->
    if (clickedNumber not in @state.selectedNumbers) \
        and (clickedNumber not in @state.usedNumbers)
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

  acceptAnswerAndStartTimer: ->
    @timer() if _.isEmpty(@state.usedNumbers)
    @acceptAnswer()

  acceptAnswer: ->
    usedNumbers = @state.usedNumbers.concat(@state.selectedNumbers)
    @setState
      selectedNumbers: []
      usedNumbers: usedNumbers
      correct: null
      numberOfStars: @randomNumber()
    , @updateDoneStatus

  timer: ->
    clock = $('#timer').FlipClock
      clockFace: 'Counter'
      minimumDigits: 3
    setTimeout ->
      setInterval ->
        clock.increment() if clock.running
      , 1000
    @setState clock: clock

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
      @setState doneStatus: 'You are a winner!', showAddResult: true
      @stopTheClockCalculateWinner()
    if (not @possibleSolutions()) and (@state.redraws is 0)
      @setState doneStatus: 'Game Over!'
      @stopTheClockCalculateLooser() if not _.isEmpty(@state.clock)

  possibleSolutions: ->
    numberOfStars = @state.numberOfStars
    possibleNumbers = []

    for num in [1..9]
      if _.contains(@state.usedNumbers, num)
        possibleNumbers.push(num)

    possibleCombinationSum(possibleNumbers, numberOfStars)

  clickAnswerInfo: ->
    tooltip = $('.glyphicon-info-sign').qtip
      content:
        title: 'Answer Field'
        text: 'In this field you can store your answers. ' +
          'If you store multiple answers, ' +
          'the addition will calculate a sum of your numbers. ' +
          'Click equality button in the middle to check if your guess is right. ' +
          'Note: You can diselect number by clicking on it. '
      style:
        classes: 'qtip-bootstrap'

  clickNumbersInfo: ->
    tooltip = $('.glyphicon-info-sign').qtip
      content:
        title: 'Numbers Field'
        text: 'Pick a number from this field ' +
          'which match with the number of Stars in the field above. ' +
          'You can pick several numbers to provide addition in answers field. ' +
          'Note: If your guess was right the number becomes green. ' +
          'Your Goal: Is to make all numbers green! Good luck!'
      style:
        classes: 'qtip-bootstrap'

  clickStarsInfo: ->
    tooltip = $('.glyphicon-info-sign').qtip
      content:
        title: 'Stars Field'
        text: 'Count the Stars! ' +
          'If you run out possible combinations in Numbers Field just press ' +
          'Yellow refresh button in the middle to refresh the stars. ' +
          'Note: You have only 7 refresh possibilities. ' +
          'After that you loose your game ;( '
      style:
        classes: 'qtip-bootstrap'


  render: ->
    doneStatus = @state.doneStatus
    if doneStatus
      bottomFrame = React.createElement DoneFrame,
        doneStatus: @state.doneStatus
        time: @state.time
        score: @state.score
        resetGame: @resetGame
        showAddResult: @state.showAddResult
        addResult: @addResult
    else
      bottomFrame = React.createElement NumbersFrame,
        selectedNumbers: @state.selectedNumbers
        usedNumbers: @state.usedNumbers
        selectNumber: @selectNumber
        clickIcon: @clickNumbersInfo

    React.DOM.div
      className: 'game'
      React.DOM.h1
        className: 'text-center'
        'Play Fast!'
      React.DOM.br null
      if @state.showTimer
        React.createElement Timer
      else
        ''

      React.DOM.div
        className: 'clearfix'
        React.createElement StarsFrame,
          numberOfStars: @state.numberOfStars
          clickIcon: @clickStarsInfo
        React.createElement ButtonFrame,
          selectedNumbers: @state.selectedNumbers
          correct: @state.correct
          redraws: @state.redraws
          checkAnswer: @checkAnswer
          acceptAnswerAndStartTimer: @acceptAnswerAndStartTimer
          redraw: @redraw
        React.createElement AnswerFrame,
          selectedNumbers: @state.selectedNumbers
          unselectNumber: @unselectNumber
          clickIcon: @clickAnswerInfo
      bottomFrame

      React.DOM.br null

      React.createElement Results,
        time: @state.time
        score: @state.score
        ref: 'results'