React = require 'react'
$ = require 'jquery'
Row = require('react-bootstrap').Row
Col = require('react-bootstrap').Col
ListGroup = require('react-bootstrap').ListGroup
ListGroupItem = require('react-bootstrap').ListGroupItem
Nav = require('react-bootstrap').Nav
NavItem = require('react-bootstrap').NavItem

App = React.createClass
  render: ->
    <Row>
      <Col md={9}><Stories source='https://fierce-gorge-1132.herokuapp.com/stories'/></Col>
      <Col md={3}>{navMenu}</Col>
    </Row>

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
    <ListGroup>{storiesCollection}</ListGroup>

Story = React.createClass
  render: ->
    <ListGroupItem header=@props.story.title href={@props.story.url}>{@props.story.url}</ListGroupItem>

navMenu = (
  <Nav bsStyle='pills' stacked activeKey={1}>
    <NavItem eventKey={1} href='#'>Recent</NavItem>
    <NavItem eventKey={2} href='#'>Popular</NavItem>
  </Nav>
  )

React.render <App/>, document.getElementById('content')
