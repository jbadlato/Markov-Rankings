import React, { Component } from 'react';
import Rank from './Rank.js';

class RankList extends Component {
  render() {
  	return (
  		<div>
  			{this.props.rankings.map(rank => <Rank key={rank.rank_id} rank={rank} />)}
  		</div>
  		);
  }
}

export default RankList;