import React, { Component } from 'react';

class League extends Component {
  handleClick = () => {
    this.props.onClickFunction(this.props.league);
  }

  render() {
    return (
      <button onClick={this.handleClick}>{this.props.league.name}</button>
    );
  }
}

export default League;