import React, { Component } from 'react';
import {
  Router,
  Route,
  Switch
} from 'react-router-dom';
import history from './history.js';
import Home from './Home.js';
import RankingsContainer from './RankingsContainer.js';

class App extends Component {
  render() {
    return (
      <Router history={history}>
        <Switch>
          <Route exact path="/" component={Home} />
          <Route path="/:league_name/:season/ranks/:date" component={RankingsContainer} />
        </Switch>
      </Router>
    );
  }
}

export default App;
