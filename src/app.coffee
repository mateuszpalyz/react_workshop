React = require 'react'
$ = require 'jquery'
Router = require('react-router')
NavItemLink = require('react-router-bootstrap').NavItemLink
{Row, Col, ListGroup, ListGroupItem, Nav, Panel} = require('react-bootstrap')
{Route, Redirect, NotFoundRoute, RouteHandler} = Router

App = React.createClass
  render: ->
    <Row>
      <Col md={9}><RouteHandler/></Col>
      <Col md={3}><NavMenu/></Col>
    </Row>

PopularStories = React.createClass
  render: ->
    <Stories source='https://fierce-gorge-1132.herokuapp.com/stories'/>

RecentStories = React.createClass
  render: ->
    <Stories source='https://fierce-gorge-1132.herokuapp.com/stories/recent'/>

Stories = React.createClass
  getInitialState: ->
    collection: []

  componentDidMount: ->
    $.get @props.source, (result) =>
      if @isMounted()
        @setState
          collection: result

  render: ->
    <ListGroup>{<Story story={story}/> for story in @state.collection}</ListGroup>

Story = React.createClass
  render: ->
    <ListGroupItem header=@props.story.title href={@props.story.url}>{@props.story.url}</ListGroupItem>

NavMenu = React.createClass
  render: ->
    <Nav bsStyle='pills' stacked>
      <NavItemLink to='popular'>Popular</NavItemLink>
      <NavItemLink to='recent'>Recent</NavItemLink>
    </Nav>

NotFound = React.createClass
  render: ->
    <Panel header={errorTitle}>
      The page you were looking for doesn't exist.
    </Panel>

errorTitle = <h3>Error</h3>

routes =
  <Route handler={App}>
    <Route name='popular' path='popular' handler={PopularStories}/>
    <Route name='recent' path='recent' handler={RecentStories}/>
    <Redirect from='/' to='popular'/>
    <NotFoundRoute handler={NotFound}/>
  </Route>

Router.run routes, (Handler) ->
  React.render <Handler/>, document.getElementById('content')
