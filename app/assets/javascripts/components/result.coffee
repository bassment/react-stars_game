@Result = React.createClass
  render: ->
    React.DOM.tr null,
      React.DOM.td null,
        React.DOM.b null,
          @props.count
      React.DOM.td null, @props.result.name
      React.DOM.td null,
        React.DOM.b null,
          @props.result.score
        ' Points'
      React.DOM.td null, @props.result.time + ' Seconds'