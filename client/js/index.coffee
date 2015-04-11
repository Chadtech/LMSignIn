# Libraries
React = require 'react'
Parse = require('parse').Parse
Parse.initialize "bzEYMWqWutpWDhEvB685fCRz0fUK3JsMkLReTqBY", "qypViWvMr1iABNmED1Mvdj3Z3S4LXIAoK4tDe7y0"

# DOM Elements
{p, a, div, input, img} = React.DOM


IndexClass = React.createClass


  getInitialState: ->
    firstName: ''
    lastName:  ''
    thanks:    false


  firstNameHandle: (event) ->
    @setState firstName: event.target.value


  lastNameHandle: (event) ->
    @setState lastName: event.target.value


  signIn: ->

    unsetThanks = =>
      @setState thanks:     false
      @setState firstName:  ''
      @setState lastName:   ''
    
    setThanks = =>
      @setState thanks: true, =>
        setTimeout unsetThanks, 4000

    SignIn = Parse.Object.extend 'SignIn'
    SignIn = new SignIn()

    now = new Date()

    SignIn.set 'firstName', @state.firstName
    SignIn.set 'lastName',  @state.lastName
    SignIn.set 'year',      (now.getFullYear() + '')
    SignIn.set 'month',     ((now.getMonth() + 1) + '')
    SignIn.set 'day',       (now.getDate() + '')
    SignIn.set 'hour',      ((now.getHours() + 1) + '')

    SignIn.save null, 
      success: setThanks
      error: (error, object) ->
        console.log 'Did not worked :( ', error, object


  render: ->
    if @state.thanks

      div
        style:
          width:            450
          marginLeft:       'auto'
          marginRight:      'auto'
          marginTop:        '10%'
          backgroundColor:  '#ffffff'
          boxShadow:        '2px 2px 1px #59595b'
          padding:          '1em'


        p
          className: 'point'
          'Thanks! You are signed in'

    else

      div
        style:
          width:            450
          marginLeft:       'auto'
          marginRight:      'auto'
          marginTop:        '10%'
          backgroundColor:  '#ffffff'
          boxShadow:        '2px 2px 1px #59595b'
          padding:          '1em'


        input
          className:      'input'
          style:
            display:      'table'
            marginBottom: '1em'
          placeholder:    'first name'
          value:          @state.firstName
          onChange:       @firstNameHandle

        input
          className:      'input'
          style:
            display:      'table'
            marginBottom: '1em'
          placeholder:    'last name'
          value:          @state.lastName
          onChange:       @lastNameHandle

        input
          className:      'submit'
          style:
            display:      'table'
            marginBottom: '1em'
          type:           'submit'
          value:          'Sign In'
          onClick:        @signIn


App = React.createElement IndexClass

React.render App, (document.getElementById 'content')


