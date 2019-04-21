import React, { Component } from 'react';
import {
  Router,
  Route,
  Switch
} from 'react-router-dom';
import history from './history.js';
import HomePage from './HomePage.js';
import RankingsPage from './RankingsPage.js';
import SchedulePage from './SchedulePage.js';

class App extends Component {
  render() {
    return (
      <Router history={history}>
        <Switch>
          <Route exact path="/" component={HomePage} />
          <Route path="/:league_name/:season/ranks/:date" component={RankingsPage} />
		  <Route path="/:league_name/:season/:team_name/schedule" component={SchedulePage} />
        </Switch>
      </Router>
    );
  }
}

export default App;
