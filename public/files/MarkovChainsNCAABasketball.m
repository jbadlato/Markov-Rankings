% We want to rank all teams in NCAA Division I Men's Basketball.
% There are many conferences with differing strengths, so we cannot simply
% go by win-loss record.
% We can use a Markov Chain to simulate a random walk to take strength of
% of schedule into account in a systematically & objectively.  
%
% There are 351 teams in Division I Men's Basketball.
% 5,395 games were played in the 2017 season.
% Data obtained from:
% https://www.spreadsheetsports.com/2015-ncaa-basketball-game-data
% Formatted for our purposes in NCAABasketballScores2017.xlsx
%
%
%------------------------Importing Game Data-------------------------------
% Import All Team Names:    (numbered alphabetically)
[TeamNumbers, TeamNames] = xlsread('NCAABasketballScores2017.xlsx','Sheet2','A2:B352');
NameToNum = containers.Map(TeamNames, TeamNumbers); % converts names to numbers
NumToName = containers.Map(linspace(1,351,351), TeamNames); % converts numbers to names
% Import All Game Scores
[Scores,Matchups] = xlsread('NCAABasketballScores2017.xlsx','Sheet1','A2:E10791');
Scores(:,2) = [];   % Deleting Empty Column
Matchups(:,4) = []; % Deleting Empty Column
Matchups(:,2) = []; % Deleting Empty Column

%-----------------------Create Matrix of Scores----------------------------
NumOfMatches = zeros(351); % Number of games between Team i and Team j
ScoresMatrix = zeros(351); % Average points Team i scores against Team j
% Pull scores from raw data & enter into a 351x351 matrix:
for i = 1:length(Matchups)
    Team = NameToNum(char(Matchups(i,1))); 
    Opponent = NameToNum(char(Matchups(i,2)));
    TeamScore = Scores(i,1);
    % Calculate average points scored:
    ScoresMatrix(Team,Opponent) = (ScoresMatrix(Team,Opponent)*NumOfMatches(Team,Opponent) + TeamScore) / (NumOfMatches(Team,Opponent)+1);
    NumOfMatches(Team,Opponent) = NumOfMatches(Team,Opponent) + 1;
end
% Visualize the sparsity of the scores matrix:
spy(ScoresMatrix)
% Each diagonal block is a different conference. Teams play mostly other
% teams in their conference.

%----Sensitivity Test----
% Uncomment to make Alabama A&M beat WVU 100-0.
%ScoresMatrix(67,303) = 0;
%ScoresMatrix(303,67) = 100;
ScoresMatrix = ScoresMatrix';

%------------------Create Random Walk Probability Matrix-------------------
% Divide entire matrix by the Sum of all scores
SumOfScores = sum(sum(ScoresMatrix));
ProbabilityMatrix = ScoresMatrix / SumOfScores;

% Add diagonal elements so that all rows sum to 1
% Interpret as: Probability that random walk stays on Team i.
rowSums = sum(ProbabilityMatrix, 2);
for i = 1:length(ProbabilityMatrix)
    ProbabilityMatrix(i,i) = 1 - rowSums(i);
end

%--------------------------Calculate Team Ratings--------------------------
% Take ProbabilityMatrix and raise it to a high power.
% This finds the probability that you will end up in State j if you start
% at State i.
% (Therefore: Lower Rating = Higher Ranking)
Ratings = ProbabilityMatrix; 
tol = 1e-10;
% (Tolerance must be small since ratings will be on the order of 1e-3.)
% (The sum of all ratings will equal 1.)
while (abs(Ratings(1,1)-Ratings(2,1)) > tol) 
    Ratings = Ratings * Ratings;
end

%--------------------------Other Data of Interest--------------------------
% We are also interested in each teams W-L record, as well as their total
% points scored and total points allowed during the season.  These values
% might give us an idea of how useful our rankings might be. 
%
% Calculating W-L Record:
WLRecords = zeros(351,2);
for i = 1:length(Matchups)
    Team = NameToNum(char(Matchups(i,1))); 
    Outcome = char(Matchups(i,3));
    if (Outcome(1) == 'L')
        WLRecords(Team,2) = WLRecords(Team,2) + 1;
    elseif (Outcome(1) == 'W')
        WLRecords(Team,1) = WLRecords(Team,1) + 1;
    end
end

% Calculating Total Points Scored & Total Points Allowed:
PointsRecords = zeros(351,2);
for i = 1:length(Matchups)
    Team = NameToNum(char(Matchups(i,1)));
    PointsRecords(Team,1) = PointsRecords(Team,1) + Scores(i,1);
    PointsRecords(Team,2) = PointsRecords(Team,2) + Scores(i,2);
end

%----------------------------Print Out Rankings----------------------------
% At this point, each row in the Ratings Matrix is identical. 
% In other words, where we started the random walk does not affect the
% probability that we will end up at State j.
Ratings = Ratings(1,:);
Ratings = Ratings';
TeamIndex = linspace(1,351,351);
TeamIndex = TeamIndex';
TeamsPlusRatings = [Ratings TeamIndex];
Standings = sortrows(TeamsPlusRatings); % Sorts by ascending rating
for i = 1:length(Standings)
    output = NumToName(Standings(length(Standings)-i+1,2));
    lengthOfName = length(output);
    for j = lengthOfName:30
        output = strcat(output,'-');
    end
    Wins = WLRecords(Standings(length(Standings)-i+1,2),1);
    Losses = WLRecords(Standings(length(Standings)-i+1,2),2);
    PointsScored = PointsRecords(Standings(length(Standings)-i+1,2),1);
    PointsAllowed = PointsRecords(Standings(length(Standings)-i+1,2),2);
    fprintf('%i\t%s\t%i-%i\t%i-%i\n', i, output, Wins, Losses, PointsScored, PointsAllowed)
end
