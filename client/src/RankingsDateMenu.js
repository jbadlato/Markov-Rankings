import React, { Component } from 'react';
import DropdownButton from 'react-bootstrap/DropdownButton';
import Dropdown from 'react-bootstrap/Dropdown';
import 'bootstrap';
import 'bootstrap/dist/css/bootstrap.css';
import 'bootstrap/dist/js/bootstrap.js';

class RankingsDateMenu extends Component {
  constructor(props) {
    super(props);
	this.state = {
		dates: []
	};
  }

  componentDidMount() {
	  fetch('/api/'+this.props.league_name+'/'+this.props.season+'/all_rank_dates')
		.then(response => response.json())
		.then(data => this.setState({ dates: data.rows }));
  }
  
  render() {
	return (
	<DropdownButton id="rankings-date-dropdown" title="Date">
	    {this.state.dates.map(date => <Dropdown.Item key={date.date} href={'/'+this.props.league_name+'/'+this.props.season+'/ranks/'+date.date} >{date.date}</Dropdown.Item>)}
	</DropdownButton>
	);
  }
	
}

export default RankingsDateMenu;