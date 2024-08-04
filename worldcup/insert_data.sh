#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.

# Clear DB
echo "$($PSQL "TRUNCATE TABLE games, teams")"
echo "$($PSQL "ALTER SEQUENCE teams_team_id_seq RESTART WITH 1")"
echo "$($PSQL "ALTER SEQUENCE games_game_id_seq RESTART WITH 1")"

# Loop through games.csv
cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
do
  if [[ $YEAR != year ]]
  then
    # Get team_id for winner
    WINNER_ID="$($PSQL "SELECT team_id FROM teams WHERE name = '$WINNER'")"
    # If team_id DNE
    if [[ -z $WINNER_ID ]]
    then
      # Insert new team
      INSERT_WINNER_RESULT="$($PSQL "INSERT INTO teams(name) VALUES('$WINNER')")"
      # Check for successful insertion and echo result
      if [[ $INSERT_WINNER_RESULT == "INSERT 0 1" ]]
      then
        echo Inserted into teams: $WINNER
      fi
      # Get new team_id for winner
      WINNER_ID="$($PSQL "SELECT team_id FROM teams WHERE name = '$WINNER'")"
    fi
    # Repeat above steps for opponent
    OPPONENT_ID="$($PSQL "SELECT team_id FROM teams WHERE name = '$OPPONENT'")"
    if [[ -z $OPPONENT_ID ]]
    then
      INSERT_OPPONENT_RESULT="$($PSQL "INSERT INTO teams(name) VALUES('$OPPONENT')")"
      if [[ $INSERT_OPPONENT_RESULT == "INSERT 0 1" ]]
      then
        echo Inserted into teams: $OPPONENT
      fi
      OPPONENT_ID="$($PSQL "SELECT team_id FROM teams WHERE name = '$OPPONENT'")"
    fi
    # Insert new game
    INSERT_GAME_RESULT="$($PSQL "INSERT INTO games(year, round, winner_id, opponent_id, winner_goals, opponent_goals) VALUES($YEAR, '$ROUND', $WINNER_ID, $OPPONENT_ID, $WINNER_GOALS, $OPPONENT_GOALS)")"
    # Check for successful insertion and echo result
    if [[ $INSERT_GAME_RESULT == "INSERT 0 1" ]]
    then
      echo Inserted into games: $WINNER v $OPPONENT $YEAR
    fi
  fi
done