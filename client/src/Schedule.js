import React, { Component } from 'react';
import Game from './Game.js';

class RankList extends Component {
  render() {
  	return (
  		<div id="schedule">
  			{this.props.schedule.map(game => <Game key={game.game_date + game.opponent_name} game={game} />)}
  		</div>
  		);
  }
}

export default RankList;