#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"

echo -e "\nEnter your username:"
read USERNAME

IFS="|" read USER_ID GAMES_PLAYED BEST_GAME < <(echo $($PSQL "SELECT user_id, games_played, best_game FROM users WHERE username = '$USERNAME'"))
if [[ -z $USER_ID ]]
then
  INSERT_USER_RESULT=$($PSQL "INSERT INTO users(username) VALUES('$USERNAME')")
  USER_ID=$($PSQL "SELECT user_id FROM users WHERE username = '$USERNAME'")
  echo -e "\nWelcome, $USERNAME! It looks like this is your first time here."
else
  echo -e "\nWelcome back, $USERNAME! You have played $GAMES_PLAYED games, and your best game took $BEST_GAME guesses."
fi

(( SECRET_NUMBER = 1 + RANDOM % 1000 ))
GUESSES=0

echo -e "\nGuess the secret number between 1 and 1000:"
while : ; do
  read GUESS
  (( GUESSES++ ))
  if [[ ! $GUESS =~ ^[0-9]+$ ]]
  then
    echo -e "\nThat is not an integer, guess again:"
  elif [[ $GUESS -eq $SECRET_NUMBER ]]
  then
    echo -e "\nYou guessed it in $GUESSES tries. The secret number was $SECRET_NUMBER. Nice job!"
    break
  elif [[ $GUESS -lt $SECRET_NUMBER ]]
  then
    echo -e "\nIt's higher than that, guess again:"
  else
    echo -e "\nIt's lower than that, guess again:"
  fi
done

UPDATE_GAMES_PLAYED_RESULT=$($PSQL "UPDATE users SET games_played = games_played + 1 WHERE user_id = $USER_ID")
UPDATE_BEST_GAME_RESULT=$($PSQL "UPDATE users SET best_game = $GUESSES WHERE user_id = $USER_ID AND (best_game IS NULL OR best_game > $GUESSES)")