import React, { Component } from 'react';

class Rank extends Component {
  render() {
  	return (
  		<div className="container rank-container">
  			<div className="row">
  				<div className="col-sm-1">
  					<h1>{this.props.rank.rank}</h1>
  				</div>
  				<div className="col-sm-3">
  					<img src={'client/public/img/teams/' + this.props.rank.team_logo_file} alt={this.props.rank.team_name.split('_').join(' ')} />
  				</div>
  				<div className="col-sm-6">
  					<h1>{this.props.rank.team_name.split('_').join(' ')}</h1>
  				</div>
  				<div className="col-sm-2">
  					<img className="conference-logo" src={'client/public/img/conferences/' + this.props.rank.conference_logo_file} alt={this.props.rank.conference_name} />
  				</div>
				</div>
				<div className="row">
  				<div className="col-sm-4">
  					<h3>Rating: {(this.props.rank.rating * 10000).toFixed(2)}</h3>
  				</div>
  				<div className="col-sm-8"></div>
  			</div>
  		</div>
  		);
  }
}

export default Rank;