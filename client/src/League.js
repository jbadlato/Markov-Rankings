import React, { Component } from 'react';
import { Link } from 'react-router-dom';

class League extends Component {
  render() {
	let today = new Date();
	let mm = '' + (today.getMonth()+1);
	let dd = '' + today.getDate();
	let yyyy = today.getFullYear();
	if (mm.length < 2) mm = '0' + mm;
	if (dd.length < 2) dd = '0' + dd;
	today = [yyyy,mm,dd].join('');
    return (
	      <Link className="list-group-item w-50 list-group-item-action league-link" to={'/'+this.props.league.name+'/'+this.props.league.latest_season+'/ranks/'+today}>
			<div className="container">
				<div className="row league-container">
					<img className="col-4 league-logo" src={'/img/leagues/' + this.props.league.logo_file} title={this.props.league.name.split('_').join(' ')} alt={this.props.league.name} />
					<h3 className="col-8 league-name" >{this.props.league.display_name}</h3>
				</div>
			</div>
	      </Link>
    );
  }
}

export default League;