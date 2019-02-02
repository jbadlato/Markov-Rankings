import React, { Component } from 'react';
import LeagueList from './LeagueList.js';
import RankingsContainer from './RankingsContainer.js';

class App extends Component {
  constructor(props) {
    super(props);
    this.state = {
      leagues: [],
      currentLeague: null
    };
  }

  componentDidMount() {
    fetch('./api/leagues')
      .then(response => response.json())
      .then(data => this.setState({ leagues: data.rows}));
  }

  changeLeague = (league) => {
    this.setState({currentLeague: league});
  }

  render() {
    return (
      <div className="App">
        <header>
          <p>
            Welcome to Markov Rankings.
          </p>
        </header>
        <LeagueList leagues={this.state.leagues} leagueOnClickFunction={this.changeLeague}/>
        <RankingsContainer league={this.state.currentLeague}/>
      </div>
    );
  }
}

export default App;
