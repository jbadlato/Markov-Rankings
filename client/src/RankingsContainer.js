import React, { Component } from 'react';
import RankList from './RankList.js';
import history from './history.js';

class RankingsContainer extends Component {
  constructor(props) {
    super(props);
    this.state = {
      rankings: []
    };
  }

  componentDidMount() {
 	fetch('/api/' + this.props.match.params.league_name + '/' + this.props.match.params.season + '/latest_rank_date')
		.then(response => response.json())
		.then(data => {
			let latestRankdate = data.rows[0].latest_rank_date;
			if (latestRankdate < this.props.match.params.date) {
				console.log('Redirecting...');
				history.push('/'+this.props.match.params.league_name+'/'+this.props.match.params.season+'/ranks/'+latestRankdate);
			} else console.log('Did not redirect');
		}
		).then(() => { 
    fetch('/api/' + this.props.match.params.league_name + '/' + this.props.match.params.season + '/ranks/' + this.props.match.params.date)
      .then(response => response.json())
      .then(data => this.setState({ rankings: data.rows}));
		});
  }

  render() {
    return (
      <div id="rankings-container">
        <RankList rankings={this.state.rankings} />
      </div>
    	);
  }
}

export default RankingsContainer;