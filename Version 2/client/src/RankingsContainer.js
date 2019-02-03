import React, { Component } from 'react';
import RankList from './RankList.js';

class RankingsContainer extends Component {
  constructor(props) {
    super(props);
    this.state = {
      rankings: []
    };
  }

  componentDidUpdate() {
    if (this.props.league === null) return;
    fetch('./api/league/' + this.props.league.id + '/ranks')
      .then(response => response.json())
      .then(data => this.setState({ rankings: data.rows}));
  }

  render() {
  	if (this.props.league === null) {
  		return (
  			<div>
  				Please select a league from the menu above.
  			</div>
  			);
  	} else {
	    return (
	      <div>
	        Current league: {this.props.league.name}
          <RankList rankings={this.state.rankings} />
	      </div>
	    	);
	}
  }
}

export default RankingsContainer;