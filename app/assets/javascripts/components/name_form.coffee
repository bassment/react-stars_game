@NameForm = React.createClass
  getInitialState: ->
    name: ''

  valid: ->
    @state.name

  handleChange: (e) ->
    @setState name: e.target.value

  render: ->
    React.DOM.form
      className: 'form-inline'
      onSubmit: @props.handleSubmit
      React.DOM.div
        className: 'form-group'
        React.DOM.input
          type: 'text'
          className: 'form-control'
          placeholder: 'Enter your name...'
          name: 'name'
          value: @state.name
          onChange: @handleChange
        React.DOM.button
          type: 'submit'
          className: 'btn btn-primary'
          disabled: not @valid()
          'Submit'
