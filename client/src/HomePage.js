import React, { Component } from 'react';
import LeaguesContainer from './LeaguesContainer.js';

class HomePage extends Component {
  render() {
    return (
      <div className="container">
        <div className="page-header">
          <h1>
            Welcome to Markov Rankings.
          </h1>
        </div>
        <LeaguesContainer />
      </div>
    );
  }
}

export default HomePage;
