import React, { Component } from 'react';
import League from './League';

class LeagueList extends Component {
  render() {
    return (
      <div>
        {this.props.leagues.map(league => <League key={league.id} league={league} onClickFunction={this.props.leagueOnClickFunction}/>)}
      </div>
    );
  }
}

export default LeagueList;