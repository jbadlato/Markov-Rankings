# Markov Rankings
Sports team rankings generated using Markov chains.  The algorithm used takes into account the score of each game played, as well as the strength of each team's schedule, but removes the subjectivity introduced in coaches polls.  Rankings are recalculated everday at midnight Pacific time.  

Data is scraped from https://www.masseyratings.com

Hosted on https://markov-rankings.herokuapp.com

Built with: 
* Node.js
* Cron
* PostgreSQL
* Heroku
* Bootstrap