import React, { Component } from 'react';
import { Link } from 'react-router-dom'

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
    	<div className="league-container container">
	      <Link className="league-link" to={'/'+this.props.league.name+'/'+this.props.league.latest_season+'/ranks/'+today}>
	      	<img className="league-logo" src={'/img/leagues/' + this.props.league.logo_file} title={this.props.league.name.split('_').join(' ')} alt={this.props.league.name} />
	      </Link>
      </div>
    );
  }
}

export default League;