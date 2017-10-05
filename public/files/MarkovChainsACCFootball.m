% We want to rank all teams in ACC Football. However, simply looking at
% their win-loss record neglects two important things:
% -Strength of Schedule
% -Score of Games
% We can use a Markov Chain to simulate a random walk to take these factors
% into account when generating a ranking.
% There are 14 Teams, so we put their scores into a matrix:
              %BC CL DK FS GT LV UM NC NS PB SU VA VT WF
ScoreMatrix = [ 0 10  0  7 14  7  0  0 21  0 20  0  0 17; %Boston College
               56  0  0 37 26 42  0  0 24 42 54  0 42 35; %Clemson
                0  0  0  0 35 14 21 28  0 14  0 20 21 14; %Duke
               45 34  0  0  0 20 20 35 24  0 45  0  0 17; %Florida State
               17  7 38  0  0  0 21 20  0 34  0 31 30  0; %Georgia Tech
               52 36 24 63  0  0  0  0 54  0 62 32  0 44; %Louisville
                0  0 40 19 35  0  0 13 27 51  0 34 16  0; %Miami
                0  0 27 37 48  0 20  0 21 37  0 35  3  0; %UNC
               14 17  0 20  0 13 13 28  0  0 35  0  0 33; %NC State
                0 43 56  0 37  0 28 36  0  0 76 45 36  0; %Pittsburgh
               28  0  0 14  0 28  0  0 20 61  0  0 31  9; %Syracuse
                0  0 34  0 17 25 14 14  0 31  0  0 10 20; %UVA
               49 35 24  0 20  0 37 34  0 39 17 52  0  0; %Virginia Tech
               14 13 24  6  0 12  0  0 16  0 28 27  0  0];%Wake Forest

           
% Normalize scores into probabilities:
sumOfScores = sum(sum(ScoreMatrix));
ProbabilityMatrix = ScoreMatrix / sumOfScores;
rowSums = sum(ProbabilityMatrix, 2);
for i = 1:14
    ProbabilityMatrix(i,i) = 1 - rowSums(i);
end
% Calculate Ratings: (Lower rating = higher ranking)
ProbabilityMatrix = ProbabilityMatrix ^ 1000;

% The rankings we obtain are:
%
%  1. Clemson (7-1)
%  2. Louisville (7-1)
%  3. Virginia Tech (6-2)
%  4. Florida State (5-3)
%  5. Miami (5-3)
%  6. Pittsburgh (5-3)
%  7. UNC (5-3)
%  8. NC State (3-5)
%  9. Georgia Tech (4-4)
%  10. Wake Forest (3-5)
%  11. Syracuse (2-6)
%  12. UVA (1-7)
%  13. Duke (1-7)
%  14. Boston College (2-6)
%
% We see a few discrepancies between win-loss record and our ranking.
% Namely, NC State (3-5) is ranked higher than Georgia Tech (4-4), and
% Boston College (2-6) is ranked lower than both UVA (1-7) and Duke (1-7).
%
% To understand this, consider that Boston College was shutout by VT 49-0,
% and also had numerous other big losses (56-10, 45-7, 54-7). They also
% scored the least points all season (96). UVA and Duke scored 165 and 167
% points, respectively, during the season.
% 
% Also, NC State played 3 of the top 4 teams, whereas Georgia Tech only
% played 2 of 4.  Georgia Tech also had close games with both Duke &
% Boston College, the bottom two teams (38-35 and 17-14, respectively.)
%
%
%