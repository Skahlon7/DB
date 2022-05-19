CREATE SCHEMA Basketball_db;
USE Basketball_db;

#Create Tables + Relationships
CREATE TABLE Front_Office
(CorpID			INT				NOT NULL,
Fname 			VARCHAR(20) 	NOT NULL,
Lname			VARCHAR(20)		NOT NULL,
Race			VARCHAR(15),
Sex				VARCHAR(1)		CHECK(Sex IN('M','F')),
Age				INT,
Rank_			INT,
DateHired		DATETIME,
Years_Worked	INT,
Emp_type		VARCHAR(1)		CHECK(Emp_type IN('S','E')),

CONSTRAINT Front_pk	PRIMARY KEY (CorpID))
;

CREATE TABLE SalesManager
(ScorpID		INT 		NOT NULL,
Territory 		VARCHAR(1)	CHECK(Territory IN('W','E')),
Country			VARCHAR(20),
Monthly_Rate	INT,
Passport_Exp	DATE,
Contract_length	INT,

CONSTRAINT	SalesManager_pk	PRIMARY KEY(ScorpID),
CONSTRAINT 	SalesManager_fk FOREIGN KEY(ScorpID) REFERENCES Front_Office(CorpID))
;

CREATE TABLE Executive
(EcorpID		INT 		NOT NULL,
Position		VARCHAR(10)	CHECK(Position IN('GM','CEO')),
Bonus			INT,
Yearly_Salary	INT,
Branch			VARCHAR(15) CHECK(Branch IN('Local','International')),
Hometown		VARCHAR(15),

CONSTRAINT	Executive_pk PRIMARY KEY(EcorpID),
CONSTRAINT Executive_fk FOREIGN KEY(EcorpID) REFERENCES Front_Office(CorpID))
;

#Optional has FOREIGN KEY
CREATE TABLE Team
(TeamID			INT			NOT NULL,
EcorpID			INT 		NOT NULL,
Team_Name		VARCHAR(15),
Home_Color		VARCHAR(10),
Away_Color		VARCHAR(10),
Record			VARCHAR(5),
City			VARCHAR(15),
Division		VARCHAR(1)	CHECK(Division IN('W','E')),

CONSTRAINT Team_pk PRIMARY KEY(TeamID),
CONSTRAINT Team_fk FOREIGN KEY(EcorpID) REFERENCES Executive(EcorpID))
;

CREATE TABLE Player
(PlayerID		INT		NOT NULL,
TeamID			INT		NOT NULL,
Fname 			VARCHAR(20),
Lname			VARCHAR(20),
Height			DECIMAL(4,2),
Weight			INT,
Age				INT,
Race			Varchar(15),
Position 		VARCHAR(2) CHECK(Position IN('PG','SG','SF','PF','C')),
Free_Agent		VARCHAR(1) CHECK(Free_Agent IN('Y','N')),

CONSTRAINT Player_pk PRIMARY KEY(PlayerID),
CONSTRAINT Player_fk FOREIGN KEY(TeamID) REFERENCES Team(TeamID))
;

CREATE TABLE Sponsor
(SponsorID		INT			NOT NULL,
SponsorName		VARCHAR(20),
City			VARCHAR(15),
State			VARCHAR(2),
Phone			VARCHAR(12),
Email			VARCHAR(35),
Valuation 		INT,

CONSTRAINT Sponsor_pk PRIMARY KEY(SponsorID))
;

CREATE TABLE Contract
(ContractID		INT 		NOT NULL,
TeamID			INT			NOT NULL,
SponsorID		INT			NOT NULL,

CONSTRAINT Contract_pk PRIMARY KEY(ContractID),
CONSTRAINT Contract_fk FOREIGN KEY(TeamID) REFERENCES Team(TeamID),
CONSTRAINT Contract_fk1 FOREIGN KEY(SponsorID) REFERENCES Sponsor(SponsorID))
;

CREATE TABLE Stadium
(StadiumID	    INT			NOT NULL,
Stadium_name	VARCHAR(15),
City			VARCHAR(15),
State			VARCHAR(2),
Capacity		INT,

CONSTRAINT Stadium_pk PRIMARY KEY(StadiumID))
;

CREATE TABLE Matches
(MatchID		INT			NOT NULL,
StadiumID	    INT			NOT NULL,
Date_			DATE,
Home_team		VARCHAR(20),
Away_team		VARCHAR(20),
Attendance		INT,

CONSTRAINT Matches_pk PRIMARY KEY(MatchID),
CONSTRAINT Matches_fk FOREIGN KEY(StadiumID) REFERENCES Stadium(StadiumID))
;

CREATE TABLE StatsLog
(StatlogID		INT 		NOT NULL,
TeamID			INT			NOT NULL,
MatchID			INT			NOT NULL,
Two_attempted	INT,
Three_attempted INT,
Ft_attempted	INT,
Two_scored		INT,
Three_scored	INT,
Ft_scored		INT,
Steals			INT,
Blocks			INT,
Win_Score		INT,
Lose_score		INT,

CONSTRAINT StatsLog_pk PRIMARY KEY(StatlogID),
CONSTRAINT StatsLog_fk FOREIGN KEY(TeamID) REFERENCES Team(TeamID),
CONSTRAINT StatsLog_fk1 FOREIGN KEY(MatchID) REFERENCES Matches(MatchID))
;

INSERT INTO Front_Office VALUES
(1, "Ima", "Runner", "Asian", "F", 25, 1, "2010-11-12", 10, "S"),
(2,"Joseph", "Mann", "Hispanic", "M", 30, 3, "2012-10-03", 19, "E"),
(3,"Mark", "Hade", "American", "M", 40, 4, "2008-09-09,13", 9, "E"),
(4,"David", "Stern", "American", "M", 35, 2, "2014-08-08,8", 14, "E"),
(5,"Sam", "Lamb", "Asian", "M", 29, 3, "2014-07-12",10,"S"),
(6, "Vivek", "Erkel", "Indian", "M", 35, 2, "2015-07-11", 7, "E")
;

INSERT INTO SalesManager VALUES
(5,"E", "America", 135000, "2025-08-12", 11),
(1, "W", "America", 120000, "2025-07-07", 15)
;

INSERT INTO Executive VALUES
(3, "CEO", 15000, 500000, "International", "Chicago"),
(2, "GM", 5000, 350000, "Local", "Los Angeles"),
(4, "GM", 10000, 400000, "International", "New York"),
(6, "GM", 8000, 350000, "Local", "Houston")
;

INSERT INTO Team VALUES
(1, 3, "Lakers", "White", "Purple", "28-49", "Los Angeles", "W"),
(2, 2, "Celtics", "White", "Green", "49-20", "Boston", "E"),
(3, 4, "Miami", "Black", "Red", "60-15", "Miami", "E"),
(4, 6, "Knicks", "White", "Blue", "35-32", "New York", "E")
;

INSERT INTO Player VALUES
(001, 1, "Russell", "Westbrook", 6.30, 200, 33, "African", "PG", "N"),
(002, 2, "Luke", "Kornet", 7.21, 250, 26, "Caucasian", "C", "Y"),
(003, 3, "Jimmy", "Butler", 6.71, 235, 32, "African", "SF", "N"),
(004, 3, "Shaquille", "O'neal", 7.10, 275, 33, "African", "C", "N")
; 

INSERT INTO Stadium VALUES
(1, "Staples Center", "Los Angeles", "CA", 19000),
(2, "TD Garden", "Boston", "MA", 9000),
(3, "FTX Arena", "Miami", "FL", 18000),
(4, "Madison Square", "New York City", "NY", 17000)
;

INSERT INTO Matches VALUES
(1, 1, "2021-10-12", "Lakers", "Celtics", 19000),
(2, 3, "2021-11-15", "Miami", "Lakers", 16000),
(3, 4, "2021-12-30", "Knicks", "Miami", 9000)
;

INSERT INTO StatsLog VALUES
(1, 1, 1, 88, 55, 18, 37, 22, 13, 5, 7, 103, 99),
(2, 3, 2, 90, 40, 15, 41, 19, 9, 1, 10, 88, 77),
(3, 4, 3, 86, 43, 19, 40, 13, 10, 5, 8, 110, 105)
#(4, 3, 4, 87, 42, 19, 51, 14, 12, 7, 6, "W")
;

INSERT INTO Sponsor VALUES
(1, "Nike", "San Francisco", "CA", "916-412-1130", "bestfranchsie@gmail.com", 100000),
(2, "Adidas", "San Leandro", "CA", "654-333-2111", "NBAballers@gmail.com", 200000),
(3, "Mega Marketing", "Los Angeles", "CA", "453-411-1999", "bestwinners@gmail.com", 250000),
(4, "MGM Grand", "Las Vegas", "NV", "213-464-5380", "kingman007@gmail.com", 300300)
;

INSERT INTO Contract VALUES
(1, 1, 3),
(2, 3, 4),
(3, 4, 2)
; 

#QUERY 1 --- DISPLAY MATCHES IN MOST RECENT ORDER ALONG WITH DETAILS
-- REGARDING THE TEAMS, THE NUMBER OF FANS, AND THE STADIUM.

SELECT M.Date_ AS Date, St.Stadium_Name, M.Attendance, M.Home_team, M.Away_team, 
Sl.Win_Score, Sl.Lose_Score, T.Team_Name AS Winning_Team #, S.Two_Scored,
FROM ((Matches M INNER JOIN Stadium St ON M.StadiumID = St.StadiumID) 
INNER JOIN StatsLog Sl ON Sl.MatchID = M.MatchID)
INNER JOIN Team T ON T.TeamID = Sl.TeamID
ORDER BY M.Date_ DESC;


#QUERY 2 --- DISPLAY AVG FG%, 3PT%, AND FT% OF TEAMS FROM THE EASTERN CONFERENCE

SELECT T.Team_Name, AVG(S.Two_scored/S.Two_attempted) AS fg_percent, 
AVG(S.Ft_scored/S.Ft_attempted) AS ft_percent,
AVG(S.Three_scored/S.Three_attempted) AS three_percent
FROM StatsLog S INNER JOIN Team T ON S.TeamID = T.TeamID  
WHERE T.Division = "E"
GROUP BY T.TeamID;


#QUERY 3 -- DETERMINE THE NAMES AND YEARLY SALARY OF EXECUTIVE MEMBERS WHO GET PAID AVERAGE OR HIGHER
-- WITH RESPECT TO THEIR JOB TITLE.

SELECT F.Fname, F.Lname, E.Yearly_Salary
FROM Front_Office F INNER JOIN Executive E ON 
F.CorpID = E.ECorpID
WHERE E.Yearly_Salary >= (
SELECT AVG(Yearly_Salary)
FROM Executive);
 
#QUERY 4 -- LIST AVERAGE WEIGHT AND HEIGHT OF Centers WHO PLAY IN THE EASTERN CONFERENCE

SELECT AVG(P.Height) Avg_Height, AVG(P.Weight) Avg_Weight, T.Division Conference
FROM Player P INNER JOIN Team T on P.TeamID = T.TeamID
WHERE T.Division = "E" AND P.Position = "C"
GROUP BY T.Division;

#QUERY 5 -- Select the Team and Sponsor that is headquartered in CA

SELECT T.Team_Name, S.SponsorName AS CA_Sponsor 
FROM (Contract C INNER JOIN Team T ON C.TeamID=T.TeamID)
INNER JOIN Sponsor S ON S.SponsorID = C.SponsorID
WHERE S.State = "CA"
;