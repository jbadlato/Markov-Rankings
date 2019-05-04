import React, { Component } from 'react';
import Schedule from './Schedule.js';

class ScheduleContainer extends Component {
  constructor(props) {
    super(props);
    this.state = {
      schedule: []
    };
  }

  componentDidMount() {
 	fetch('/api/' + this.props.league_name + '/' + this.props.season + '/' + this.props.team_name + '/schedule')
		.then(response => response.json())
		.then(data => this.setState({ schedule: data.rows}));
  }

  render() {
    return (
      <div id="schedule-container">
        <Schedule schedule={this.state.schedule} />
      </div>
    	);
  }
}

export default ScheduleContainer;