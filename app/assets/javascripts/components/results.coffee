@Results = React.createClass
  getInitialState: ->
    name: 'NoName'
    results: []
    showNameInput: true
    hideThankYou: false

  hideThankYou: ->
    @setState hideThankYou: true

  handleSubmit: (e) ->
    e.preventDefault()
    name = $('input').val()
    @setState showNameInput: false, name: name

  addResult: ->
    results = @state.results.slice()
    result =
      name: @state.name
      time: @props.time
      score: @props.score
    results.push(result)
    results_sorted_by_score = _.sortBy(results, 'score').reverse()
    @setState results: results_sorted_by_score

  render: ->
    React.DOM.div
      className: 'leader-board'
      React.DOM.h2
        className: 'text-center'
        'ScoreBoard'
      React.DOM.div
        className: 'name-input'
        if @state.showNameInput
          React.createElement NameForm, handleSubmit: @handleSubmit, handleChange: @handleChange
        if not @state.showNameInput and not @state.hideThankYou
          thanks =
            React.DOM.h4
              className: 'thanks'
              'Thank you, '
                React.DOM.b null,
                  @state.name[0].toUpperCase() + @state.name.slice(1)
                '! '
              React.DOM.button
                className: 'btn btn-info'
                onClick: @hideThankYou
                'hide'

      React.DOM.div
        className: 'result-table'
        React.DOM.br null
        React.DOM.table
          className: 'table table-bordered table-responsive text-center'
          React.DOM.thead null,
            React.DOM.tr null,
              React.DOM.th className: 'text-center', 'Place'
              React.DOM.th className: 'text-center', 'Name'
              React.DOM.th className: 'text-center', 'Score'
              React.DOM.th className: 'text-center', 'Time'
          React.DOM.tbody null,
            for result, i in @state.results
              React.createElement Result,
                result: result
                key: i
                count: i + 1