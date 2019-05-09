import React, { Component } from 'react';

class RankingsHeader extends Component {
  constructor(props) {
    super(props);
    this.state = {
      displayName: ''
    };
  }
  
  fetchRankings() {
 	fetch('/api/' + this.props.league_name + '/display_name')
		.then(response => response.json())
		.then(data => {
			let displayName = data.rows[0].display_name;
			this.setState({displayName: displayName});
		});
  }
  
  componentDidMount() {
	this.fetchRankings();
  }
	
  render() {
    return (
		<div className="page-header">
		  <h1>
		  {this.state.displayName} {this.props.season}
		  </h1>
		</div>
    );
  }
}

export default RankingsHeader;
