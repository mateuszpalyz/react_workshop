React = require 'react'

App = React.createClass
  render: ->
    <h1>Hello World from ReactWorld</h1>

React.render <App/>, document.getElementById('container')
