@StarsFrame = React.createClass
  render: ->
    React.DOM.div
      id: 'stars-frame'
      React.DOM.div
        className: 'well'
        for num in [1..@props.numberOfStars]
          React.DOM.span
            key: num
            className: 'glyphicon glyphicon-star'