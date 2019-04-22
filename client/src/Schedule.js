import React, { Component } from 'react';
import Game from './Game.js';

class RankList extends Component {
  render() {
  	return (
      <div className="container">
		<div className="row">
			<div className="col-12">
				<div className="list-group d-flex flex-row flex-wrap">
					{this.props.schedule.map(game => <Game key={game.game_date + game.opponent_name} game={game} />)}
				</div>
			</div>
		</div>
      </div>
  		);
  }
}

export default RankList;