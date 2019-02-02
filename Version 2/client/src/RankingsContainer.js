import React, { Component } from 'react';

class RankingsContainer extends Component {
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
	      </div>
	    	);
	}
  }
}

export default RankingsContainer;