#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

if [[ -z $1 ]]
then
  echo "Please provide an element as an argument."
else
  if [[ $1 =~ ^[0-9]+$ ]]
  then
    CONDITION="atomic_number = $1"
  else
    CONDITION="name = '$1' OR symbol = '$1'"
  fi
  IFS="|" read ATOMIC_NUMBER NAME SYMBOL TYPE MASS MELTING_POINT BOILING_POINT < <(echo $($PSQL "\
                SELECT\
                  atomic_number,\
                  name,\
                  symbol,\
                  type,\
                  atomic_mass,\
                  melting_point_celsius,\
                  boiling_point_celsius\
                FROM elements\
                LEFT JOIN properties USING(atomic_number)\
                LEFT JOIN types USING(type_id)\
                WHERE $CONDITION"))
  if [[ -z $ATOMIC_NUMBER ]]
  then
    echo "I could not find that element in the database."
  else
    echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu.\
 $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
  fi
fi