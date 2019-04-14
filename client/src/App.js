import React, { Component } from 'react';
import {
  BrowserRouter as Router,
  Route,
  Switch
} from 'react-router-dom';
import Home from './Home.js';
import RankingsContainer from './RankingsContainer.js';

class App extends Component {
  render() {
    return (
      <Router>
        <Switch>
          <Route exact path="/" component={Home} />
          <Route path="/league/:league_name/ranks" component={RankingsContainer} />
        </Switch>
      </Router>
    );
  }
}

export default App;
