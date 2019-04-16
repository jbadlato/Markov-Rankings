import React, { Component } from 'react';
import League from './League';

class LeagueList extends Component {
  render() {
    return (
      <div className="container">
		<div className="row">
			<div className="col-12">
				<div className="list-group d-flex flex-row flex-wrap">
					{this.props.leagues.map(league => <League key={league.id} league={league} />)}
				</div>
			</div>
		</div>
      </div>
    );
  }
}

export default LeagueList;