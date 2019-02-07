import React, { Component } from 'react';
import RankList from './RankList.js';

class RankingsContainer extends Component {
  constructor(props) {
    super(props);
    this.state = {
      rankings: []
    };
  }

  componentDidMount() {
    fetch('/api/league/' + this.props.match.params.id + '/ranks')
      .then(response => response.json())
      .then(data => this.setState({ rankings: data.rows}));
  }

  render() {
    return (
      <div id="rankings-container">
        <RankList rankings={this.state.rankings} />
      </div>
    	);
  }
}

export default RankingsContainer;