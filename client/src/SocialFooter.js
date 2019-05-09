import React, { Component } from 'react';

class SocialFooter extends Component {
  render() {
    return (
<div className="box">
    <div className="container">
     	<div className="row">
			<div className="col-lg-4"></div>
			<a href="https://twitter.com/markovrankings" className="col-lg-2 col-md-2 col-sm-2 col-xs-12">
				<div className="box-part text-center box-twitter">
					<i className="fa fa-twitter fa-5x" aria-hidden="true"></i>
				 </div>
			</a>	 
			<a href="https://github.com/jbadlato/Markov-Rankings" className="col-lg-2 col-md-2 col-sm-2 col-xs-12">
				<div className="box-part text-center box-github">
					<i className="fa fa-github fa-5x" aria-hidden="true"></i>
				 </div>
			</a>
			<div className="col-lg-4"></div>
		</div>		
    </div>
</div>
    );
  }
}

export default SocialFooter;
