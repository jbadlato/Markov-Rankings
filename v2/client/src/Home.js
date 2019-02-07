import React, { Component } from 'react';
import LeaguesContainer from './LeaguesContainer.js';

class Home extends Component {
  render() {
    return (
      <div>
        <header>
          <p>
            Welcome to Markov Rankings.
          </p>
        </header>
        <LeaguesContainer />
      </div>
    );
  }
}

export default Home;
