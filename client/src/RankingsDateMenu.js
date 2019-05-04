import React, { Component } from 'react';
import DropdownButton from 'react-bootstrap/DropdownButton';
import DropdownItem from 'react-bootstrap/DropdownItem';
import { LinkContainer } from 'react-router-bootstrap';
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
	<DropdownButton id="rankings-date-dropdown" title="Select Another Date">
	    {this.state.dates.map(date => 
			<LinkContainer key={date.date} to={'/'+this.props.league_name+'/'+this.props.season+'/ranks/'+date.date}>
				<DropdownItem>
					{date.date.replace(/(\d{4})(\d{2})(\d{2})/g, '$1-$2-$3')}
				</DropdownItem>
			</LinkContainer>
			)}
	</DropdownButton>
	);
  }
	
}

export default RankingsDateMenu;