import React, { Component } from 'react';
import LeagueList from './LeagueList.js';

class App extends Component {
  constructor(props) {
    super(props);
    this.state = {
      leagues: []
    };
  }

  componentDidMount() {
    fetch('./api/leagues')
      .then(response => response.json())
      .then(data => this.setState({ leagues: data.rows}));
  }

  render() {
    return (
      <div>
        <LeagueList leagues={this.state.leagues} />
      </div>
    );
  }
}

export default App;
