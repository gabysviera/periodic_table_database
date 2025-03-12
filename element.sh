#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

INPUT=$1

BODY_PROGRAM() {
if [[ -z $INPUT ]]
then
echo Please provide an element as an argument.
#get elements
else
#check if the input is a number. GET THE ATOMIC NUMBER
if [[ $INPUT =~ [0-9]+ ]]
then
 #get atomic number and check if that number is in the database
 GET_ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE atomic_number = '$INPUT'")
 if [[ -z $GET_ATOMIC_NUMBER ]]
 then
 echo The number is not in the database
 else
 : '
 DESPUES DE HABER OBTENIDO EL NUM ATOMICO, NECESITAMOS OBTENER EL SYMBOL Y EL NOMBRE, y no con un else porque es si es que la entrada fue
 un numero
 '
 GET_SYMBOL_A=$($PSQL "SELECT symbol FROM elements WHERE atomic_number = '$GET_ATOMIC_NUMBER'")
 GET_NAME_A=$($PSQL "SELECT name FROM elements WHERE atomic_number = '$GET_ATOMIC_NUMBER'") 
 #get properties
  ATOMIC_MASS=$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number = '$GET_ATOMIC_NUMBER'")

  MELTING_CELSIUS=$($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number = '$GET_ATOMIC_NUMBER'")

  BOILING_CELSIUS=$($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number = '$GET_ATOMIC_NUMBER'")

  #get type
  GET_TYPE=$($PSQL "SELECT type FROM types INNER JOIN properties USING(type_id) WHERE atomic_number = '$GET_ATOMIC_NUMBER'")

  TEXT="The element with atomic number $GET_ATOMIC_NUMBER is $GET_NAME_A ($GET_SYMBOL_A). It's a $GET_TYPE, with a mass of $ATOMIC_MASS amu. $GET_NAME_A has a melting point of $MELTING_CELSIUS celsius and a boiling point of $BOILING_CELSIUS celsius."
  echo $TEXT
 fi # [[ -z $GET_ATOMIC_NUMBER ]]
 
 else # [[ $INPUT =~ [0-9]+ ]]
 #get the symbol and check if is in the database
 GET_SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE symbol = '$INPUT'")
 if [[ -z $GET_SYMBOL ]]
 then
  #check if the input is a name and not a symbol
  GET_NAME=$($PSQL "SELECT name FROM elements WHERE name = '$INPUT'")
  if [[ -z $GET_NAME ]]
  then
  echo I could not find that element in the database.
  else #name
  GET_ATOMIC_NUMBER_C=$($PSQL "SELECT atomic_number FROM elements WHERE name = '$GET_NAME'")
  GET_SYMBOL_C=$($PSQL "SELECT symbol FROM elements WHERE name = '$GET_NAME'")
  #get properties
    ATOMIC_MASS=$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number = '$GET_ATOMIC_NUMBER_C'")

    MELTING_CELSIUS=$($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number = '$GET_ATOMIC_NUMBER_C'")

    BOILING_CELSIUS=$($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number = '$GET_ATOMIC_NUMBER_C'")

    #get type
   GET_TYPE=$($PSQL "SELECT type FROM types INNER JOIN properties USING(type_id) WHERE atomic_number = '$GET_ATOMIC_NUMBER_C'")

   TEXT="The element with atomic number $GET_ATOMIC_NUMBER_C is $GET_NAME ($GET_SYMBOL_C). It's a $GET_TYPE, with a mass of $ATOMIC_MASS amu. $GET_NAME has a melting point of $MELTING_CELSIUS celsius and a boiling point of $BOILING_CELSIUS celsius."
   echo $TEXT
  fi # [[ -z $GET_NAME ]]
 else #symbol
 GET_ATOMIC_NUMBER_B=$($PSQL "SELECT atomic_number FROM elements WHERE symbol = '$GET_SYMBOL'")
 GET_NAME_B=$($PSQL "SELECT name FROM elements WHERE symbol = '$GET_SYMBOL'")
 #get properties
   ATOMIC_MASS=$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number = '$GET_ATOMIC_NUMBER_B'")

   MELTING_CELSIUS=$($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number = '$GET_ATOMIC_NUMBER_B'")

   BOILING_CELSIUS=$($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number = '$GET_ATOMIC_NUMBER_B'")

   #get type
   GET_TYPE=$($PSQL "SELECT type FROM types INNER JOIN properties USING(type_id) WHERE atomic_number = '$GET_ATOMIC_NUMBER_B'")

   TEXT="The element with atomic number $GET_ATOMIC_NUMBER_B is $GET_NAME_B ($GET_SYMBOL). It's a $GET_TYPE, with a mass of $ATOMIC_MASS amu. $GET_NAME_B has a melting point of $MELTING_CELSIUS celsius and a boiling point of $BOILING_CELSIUS celsius."
   echo $TEXT
fi #[[ $INPUT =~ [0-9]+ ]]
fi # [[ -z $input ($1)]]
fi #if [[ -z $GET_SYMBOL ]]
}

BODY_PROGRAM

#hecho por Gabriela Viera