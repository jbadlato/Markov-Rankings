import React, { Component } from 'react';
import {
  Router,
  Route,
  Switch
} from 'react-router-dom';
import history from './history.js';
import HomePage from './HomePage.js';
import RankingsContainer from './RankingsContainer.js';

class App extends Component {
  render() {
    return (
      <Router history={history}>
        <Switch>
          <Route exact path="/" component={HomePage} />
          <Route path="/:league_name/:season/ranks/:date" component={RankingsContainer} />
        </Switch>
      </Router>
    );
  }
}

export default App;
