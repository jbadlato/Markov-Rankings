import React, { Component } from 'react';

class Team {
	constructor(name, record, logoFile, score, conferenceName, conferenceLogoFile) {
		this.name = name;
		this.record = record;
		this.logoFile = logoFile;
		this.score = score;
		this.conferenceName = conferenceName;
		this.conferenceLogoFile = conferenceLogoFile;
	}
}

function concatenateRecord(winCount, lossCount, tieCount) {
	let record = '(' + winCount + '-' + lossCount;
	if (tieCount > 0) {
		record += '-' + tieCount;
	}
	record += ')';
	return record;
}

class Game extends Component {
  render() {
  	let teamRecord = concatenateRecord(this.props.game.team_win_count, this.props.game.team_loss_count, this.props.game.team_tie_count);
	let opponentRecord = concatenateRecord(this.props.game.opponent_win_count, this.props.game.opponent_loss_count, this.props.game.opponent_tie_count);
	let homeTeam, awayTeam;
	if (this.props.game.home_ind === 1) {
		homeTeam = new Team(this.props.game.team_name, teamRecord, this.props.game.team_logo_file, this.props.game.team_score, this.props.game.team_conference_name, this.props.game.team_conference_logo_file);
		awayTeam = new Team(this.props.game.opponent_name, opponentRecord, this.props.game.opponent_logo_file, this.props.game.opponent_score, this.props.game.opponent_conference_name, this.props.game.opponent_conference_logo);
	} else if (this.props.game.home_ind === -1) {
		homeTeam = new Team(this.props.game.opponent_name, opponentRecord, this.props.game.opponent_logo_file, this.props.game.opponent_score, this.props.game.opponent_conference_name, this.props.game.opponent_conference_logo);
		awayTeam = new Team(this.props.game.team_name, teamRecord, this.props.game.team_logo_file, this.props.game.team_score, this.props.game.team_conference_name, this.props.game.team_conference_logo_file);
	} else {	// TODO: further decision making for which team to display as "home"?
		// (for now, team in URL is homeTeam)
		homeTeam = new Team(this.props.game.team_name, teamRecord, this.props.game.team_logo_file, this.props.game.team_score, this.props.game.team_conference_name, this.props.game.team_conference_logo_file);
		awayTeam = new Team(this.props.game.opponent_name, opponentRecord, this.props.game.opponent_logo_file, this.props.game.opponent_score, this.props.game.opponent_conference_name, this.props.game.opponent_conference_logo);
	}
  	return (
  		<div className="container game-container">
			<div>
				<h1>{this.props.game.game_date}</h1>
			</div>
  			<div className="row away-row">
				<div className="col-xs-3">
					<img className="team-logo" src={'/img/teams/' + awayTeam.logoFile} title={awayTeam.name.split('_').join(' ')} alt={awayTeam.name.split('_').join(' ')} />
				</div>
				<div className="col-xs-5">
					<h1>{awayTeam.name.split('_').join(' ')}</h1>
				</div>
				<div className="col-xs-2">
					<h1>{awayTeam.record}</h1>
				</div>
				<div className="col-xs-1">
					<h1>{awayTeam.score}</h1>
				</div>
			</div>
			<div className="row home-row">
				<div className="col-xs-3">
					<img className="team-logo" src={'/img/teams/' + homeTeam.logoFile} title={homeTeam.name.split('_').join(' ')} alt={homeTeam.name.split('_').join(' ')} />
				</div>
				<div className="col-xs-5">
					<h1>{homeTeam.name.split('_').join(' ')}</h1>
				</div>
				<div className="col-xs-2">
					<h1>{homeTeam.record}</h1>
				</div>
				<div className="col-xs-1">
					<h1>{homeTeam.score}</h1>
				</div>
			</div>
  		</div>
  		);
  }
}

export default Game;