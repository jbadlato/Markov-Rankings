import React, { Component } from 'react';
import League from './League';

class LeagueList extends Component {
  render() {
    return (
      <div className="container">
        {this.props.leagues.map(league => <League key={league.id} league={league} />)}
      </div>
    );
  }
}

export default LeagueList;