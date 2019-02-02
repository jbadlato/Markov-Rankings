import React, { Component } from 'react';
import League from './League';

class LeagueList extends Component {
  render() {
    return (
      <div>
        {this.props.leagues.map(league => <League key={league.id} league={{name: league.name}} onClickFunction={this.props.leagueOnClickFunction}/>)}
      </div>
    );
  }
}

export default LeagueList;