import React, { Component } from 'react';
import RankingsContainer from './RankingsContainer.js';
import RankingsDateMenu from './RankingsDateMenu.js';

class HomePage extends Component {
  render() {
    return (
      <div>
        <header>
          <h1>
		  {this.props.match.params.league_name} {this.props.match.params.season}
          </h1>
		  <p>Showing rankings calculated on: {this.props.match.params.date}</p>
        </header>
		<RankingsDateMenu league_name={this.props.match.params.league_name} season={this.props.match.params.season} />
        <RankingsContainer league_name={this.props.match.params.league_name} season={this.props.match.params.season} date={this.props.match.params.date} />
      </div>
    );
  }
}

export default HomePage;
