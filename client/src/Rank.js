import React, { Component } from 'react';
import { Link } from 'react-router-dom';

class Rank extends Component {
  render() {
  	let record = '(' + this.props.rank.win_count + '-' + this.props.rank.loss_count;
  	if (this.props.rank.tie_count > 0) {
  		record += '-' + this.props.rank.tie_count;
  	}
  	record += ')';
  	return (
		<Link className="list-group-item w-100 list-group-item-action" to={'/'+this.props.rank.league+'/'+this.props.rank.season+'/'+this.props.rank.team_name+'/schedule'} >
			<div className="container rank-container">
				<div className="row rank-row">
					<div className="col-xs-1">
						{(this.props.rank.rank_change > 0) && 
						<h1 className="down-ranking">
							&#9660;
						</h1>
						}
						{(this.props.rank.rank_change < 0) &&
						<h1 className="up-ranking">
							&#9650;
						</h1>
						}
					</div>
					<div className="col-xs-1">
						<h1>{this.props.rank.rank}</h1>
					</div>
					<div className="col-xs-2">
						<img className="team-logo" src={'/img/teams/' + this.props.rank.team_logo_file} title={this.props.rank.team_name.split('_').join(' ')} alt={this.props.rank.team_name.split('_').join(' ')} />
					</div>
					<div className="col-xs-4">
						<h1>{this.props.rank.team_name.split('_').join(' ')}</h1>
					</div>
					<div className="col-xs-2">
						<h3>{record}</h3>
					</div>
					<div className="col-xs-2 rank-conference-logo-container">
						<img className="conference-logo pull-right" src={'/img/conferences/' + this.props.rank.conference_logo_file} title={this.props.rank.conference_name.split('_').join(' ')} alt={this.props.rank.conference_name} />
					</div>
					</div>
			</div>
		</Link>
  		);
  }
}

export default Rank;