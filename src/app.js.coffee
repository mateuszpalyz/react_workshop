React = require 'react'
$ = require 'jquery'

App = React.createClass
  render: ->
    <div>
      <h1>Hello World from HackerNews</h1>
      <Stories source='https://fierce-gorge-1132.herokuapp.com/stories'/>
    </div>

Stories = React.createClass
  getInitialState: ->
    {
      collection: []
    }

  componentDidMount: ->
    $.get @props.source, ((result) ->
      if @isMounted()
        @setState
          collection: result
      ).bind(this)

  render: ->
    storiesCollection = []
    for story in @state.collection
      storiesCollection.push <Story story={story}/>
    <ul>{storiesCollection}</ul>

Story = React.createClass
  render: ->
    <li>
      {@props.story.title}
      <ul>
        <li>{@props.story.url}</li>
        <li>{@props.story.created_at}</li>
      </ul>
    </li>

React.render <App/>, document.getElementById('container')
