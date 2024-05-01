#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

PROMPT() {

  if [[ -z $1 ]]
  then
    echo Please provide an element as an argument.
  elif [[ $1 =~ ^[0-9]+$ ]]
    then
      ELEMENT_PROPERTIES=$($PSQL "SELECT atomic_number, symbol, name, types.type, atomic_mass, melting_point_celsius, boiling_point_celsius FROM elements INNER JOIN properties USING (atomic_number) INNER JOIN types USING (type_id) WHERE atomic_number='$1'")
      if [[ $ELEMENT_PROPERTIES ]]
      then
        IFS="|" read -r ATOM_NUM SYMBOL NAME TYPE MASS MELT BOIL <<< "$ELEMENT_PROPERTIES"
        echo "The element with atomic number $ATOM_NUM is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELT celsius and a boiling point of $BOIL celsius."
      else
        echo I could not find that element in the database.
      fi
  elif [[ $1 =~ ^[a-zA-Z]{1,2}$ ]]
    then
      ELEMENT_PROPERTIES=$($PSQL "SELECT atomic_number, symbol, name, types.type, atomic_mass, melting_point_celsius, boiling_point_celsius FROM elements INNER JOIN properties USING (atomic_number) INNER JOIN types USING (type_id) WHERE symbol='$1'")
      if [[ $ELEMENT_PROPERTIES ]]
      then
        IFS="|" read -r ATOM_NUM SYMBOL NAME TYPE MASS MELT BOIL <<< "$ELEMENT_PROPERTIES"
        echo "The element with atomic number $ATOM_NUM is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELT celsius and a boiling point of $BOIL celsius."
      else
        echo I could not find that element in the database.
      fi
  else
      ELEMENT_PROPERTIES=$($PSQL "SELECT atomic_number, symbol, name, types.type, atomic_mass, melting_point_celsius, boiling_point_celsius FROM elements INNER JOIN properties USING (atomic_number) INNER JOIN types USING (type_id) WHERE name='$1'")
      if [[ $ELEMENT_PROPERTIES ]]
      then
        IFS="|" read -r ATOM_NUM SYMBOL NAME TYPE MASS MELT BOIL <<< "$ELEMENT_PROPERTIES"
        echo "The element with atomic number $ATOM_NUM is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELT celsius and a boiling point of $BOIL celsius."  
      else
        echo I could not find that element in the database.
      fi
  fi
}

PROMPT $1
