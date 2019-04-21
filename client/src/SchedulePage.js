import React, { Component } from 'react';
import ScheduleContainer from './ScheduleContainer.js';

class HomePage extends Component {
  render() {
    return (
      <div>
		<div className="container">
			<div className="page-header">
			  <h1>
			  {this.props.match.params.team_name.split('_').join(' ')}
			  </h1>
			</div>
		</div>
        <ScheduleContainer league_name={this.props.match.params.league_name} season={this.props.match.params.season} team_name={this.props.match.params.team_name} />
      </div>
    );
  }
}

export default HomePage;
