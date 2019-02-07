import React, { Component } from 'react';
import { Link } from 'react-router-dom'

class League extends Component {
  render() {
    return (
      <Link to={'/league/'+this.props.league.id+'/ranks'}>{this.props.league.name}</Link>
    );
  }
}

export default League;