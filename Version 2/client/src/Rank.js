import React, { Component } from 'react';

class Rank extends Component {
  render() {
  	let record = '(' + this.props.rank.win_count + '-' + this.props.rank.loss_count;
  	if (this.props.rank.tie_count > 0) {
  		record += '-' + this.props.rank.tie_count;
  	}
  	record += ')';
  	return (
  		<div className="container rank-container">
  			<div className="row rank-row">
  				<div className="col-xs-1">
  					<h1>{this.props.rank.rank}</h1>
  				</div>
  				<div className="col-xs-3">
  					<img className="team-logo" src={'/client/public/img/teams/' + this.props.rank.team_logo_file} alt={this.props.rank.team_name.split('_').join(' ')} />
  				</div>
  				<div className="col-xs-4">
  					<h1>{this.props.rank.team_name.split('_').join(' ')}</h1>
  				</div>
  				<div className="col-xs-2">
  					<h3>{record}</h3>
  				</div>
  				<div className="col-xs-2 rank-conference-logo-container">
  					<img className="conference-logo pull-right" src={'/client/public/img/conferences/' + this.props.rank.conference_logo_file} alt={this.props.rank.conference_name} />
  				</div>
				</div>
  		</div>
  		);
  }
}

export default Rank;