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
  
  fetchRankings() {
 	fetch('/api/' + this.props.league_name + '/' + this.props.season + '/latest_rank_date')
		.then(response => response.json())
		.then(data => {
			let latestRankdate = data.rows[0].latest_rank_date;
			if (latestRankdate < this.props.date) {
				history.replace('/'+this.props.league_name+'/'+this.props.season+'/ranks/'+latestRankdate);
			}
		})
		.then(() => {
			fetch('/api/' + this.props.league_name + '/' + this.props.season + '/ranks/' + this.props.date)
			  .then(response => response.json())
			  .then(data => this.setState({ rankings: data.rows}));
		});
  }

  componentDidMount() {
	this.fetchRankings();
  }
  
  componentDidUpdate() {
	this.fetchRankings();
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