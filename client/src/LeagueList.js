import React, { Component } from 'react';
import League from './League';

class LeagueList extends Component {
  render() {
    return (
      <div className="container-fluid">
		<div className="row">
			{this.props.leagues.map(league => <League key={league.id} league={league} />)}
		</div>
      </div>
    );
  }
}

export default LeagueList;