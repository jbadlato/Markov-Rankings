import React, { Component } from 'react';
import Rank from './Rank.js';

class RankList extends Component {
  render() {
  	return (
      <div className="container">
		<div className="row">
			<div className="col-12">
				<div className="list-group d-flex flex-row flex-wrap">
  			{this.props.rankings.map(rank => <Rank key={rank.rank_id} rank={rank} />)}
				</div>
			</div>
		</div>
      </div>
  		);
  }
}

export default RankList;