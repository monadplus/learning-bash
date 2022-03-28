#!/usr/bin/env bash

langRegex='(..)_(..)'
if [[ $LANG =~ $langRegex ]]
then
    echo "Your country code (ISO 3166-1-alpha-2) is ${BASH_REMATCH[2]}."
    echo "Your language code (ISO 639-1) is ${BASH_REMATCH[1]}."
else
    echo "Your locale was not recognised"
fi

################# Loops

# while true; do
#     echo "Infinite loop"
# done

# while ! ping -c 1 -W 1 1.1.1.1; do
#   echo "still waiting for 1.1.1.1"
#   sleep 1
# done

(( i=10 )); while (( i > 0 )); do
  echo "$i empty cans of beer."
  (( i-- ))
done

for (( i=10; i > 0; i-- ))
  do echo "$i empty cans of beer."
done

10 9 8 7 6 5 4 3 2 1
for i in {10..1}
  do echo "$i empty cans of beer."
done

for i in 10 9 8 7 6 5 4 3 2 1; do
    echo "$i empty cans of beer."
done

# for file in $(ls *.mp3); do # Bogus
# for file in "$(ls *.mp3)"; do # Bogus
for file in "$(ls *.bash)"; do
    echo "$file"
done

# while read -p $'The sweet machine.\nInsert 20c and enter your name: ' name
# do echo "The machine spits out three lollipops at $name."
# done

# while sleep 300
# do kmail --check
# done

# $ # Wait for a host to come back online.
# $ while ! ping -c 1 -W 1 "$host"
# > do echo "$host is still unavailable."
# > done; echo -e "$host is available again.\a"

case $LANG in
    en*) echo 'Hello!' ;;
    fr*) echo 'Salut!' ;;
    de*) echo 'Guten Tag!' ;;
    nl*) echo 'Hallo!' ;;
    it*) echo 'Ciao!' ;;
    es*) echo 'Hola!' ;;
    C|POSIX) echo 'hello world' ;;
    *)   echo 'I do not speak your language.' ;;
esac

echo "Which of these does not belong in the group?"; \
select choice in Apples Pears Crisps Lemons Kiwis; do
if [[ $choice = Crisps ]]; then
    echo "Correct!  Crisps are not fruit."
    break
fi
echo "Errr... no.  Try again."
done

PS3="Which of these does not belong in the group (#)? "; \
select choice in Apples Pears Crisps Lemons Kiwis; do
if [[ $choice = Crisps ]]; then
    echo "Correct!  Crisps are not fruit."
    break
fi
echo "Errr... no.  Try again."
done

while true; do
    echo "Welcome to the Menu"
    echo "  1. Say hello"
    echo "  2. Say good-bye"
    read -p "-> " response
    case $response in
        1) echo 'Hello there!' ;;
        2) echo 'See you later!'; break ;;
        *) echo 'What was that?' ;;
    esac
done

quit=
while test -z "$quit"; do
    echo "Welcome to the Menu"
    echo "  1. Say hello"
    echo "  2. Say good-bye"
    read -p "-> " response
    case $response in
        1) echo 'Hello there!' ;;
        2) echo 'See you later!'; quit=y ;;
        *) echo 'What was that?' ;;
    esac
done

# $ foo "hello world" y
function foo {
    # Bogus
    for param in "$*"; do
        echo "$param"
    done
    # Ok
    for param in "$@"; do
        echo "$param"
    done
}

############################ Array

# This does NOT work in the general case
# $ files=$(ls ~/*.jpg); cp $files /backups/

# This DOES work in the general case
# $ files=(~/*.jpg); cp "${files[@]}" /backups/

# Example
files=$(ls ~/*rc); for file in "$files"; do echo "$file"; done # Not recommended
files=(~/*rc); echo "${files[@]}" # Recommended
# Same example with for (including hidden files)
for file in ~/{.,[^.]}*rc; do
    echo "$file"
done

# array
names=("Bob" "Peter" "$USER" "Big Bad John")
names=([0]="Bob" [1]="Peter" [20]="$USER" [21]="Big Bad John")
photos=(~/"My Photos"/*.jpg)

# $ files=$(ls)    # BAD, BAD, BAD!
# $ files=($(ls))  # STILL BAD!
# $ files=(*)      # Good!

# Here we use IFS with the value . to cut the given IP address into array elements wherever there's a .
# $ IFS=. read -ra ip_elements <<< "127.0.0.1"

myfiles=([0]="/home/wooledg/.bashrc" [1]="billing codes.xlsx" [2]="hello.c")
declare -p myfiles # print content of variable
printf '%s\n' "${myfiles[@]}"

for file in "${myfiles[@]}"; do
    cp "$file" /backups/
done

names=("Bob" "Peter" "$USER" "Big Bad John")
for name in "${names[@]}"; do echo "$name"; done

for name in "Bob" "Peter" "$USER" "Big Bad John"; do echo "$name"; done

myfiles=(db.sql home.tbz2 etc.tbz2)
cp "${myfiles[@]}" /backups/ # cp "db.sql" "home.tbz2" "etc.tbz2" /backups/

echo "The first name is: ${names[0]}"
echo "The second name is: ${names[1]}"

# ${names[*]} concatenate array into single string
names=("Bob" "Peter" "$USER" "Big Bad John")
echo "Today's contestants are: ${names[*]}"
# Today's contestants are: Bob Peter lhunath Big Bad John

names=("Bob" "Peter" "$USER" "Big Bad John")
( IFS=,; echo "Today's contestants are: ${names[*]}" ) # Be careful to ( IFS=...), otherwise it will overwrite the default.
# Today's contestants are: Bob,Peter,lhunath,Big Bad John

array=(a b c)
echo ${#array[@]} # 3

first=(Jessica Sue Peter)
last=(Jones Storm Parker)
for i in "${!first[@]}"; do
  echo "${first[i]} ${last[i]}"
done

# arithmetic expressions inside array index
a=(a b c q w x y z)
for ((i=0; i<${#a[@]}; i+=2)); do
  echo "${a[i]} and ${a[i+1]}"
done

################## Sparse Arrays

nums=(zero one two three four)
nums[70]="seventy"
unset 'nums[3]'
declare -p nums

################## Associative Arrays

declare -A fullNames
fullNames=( ["arnau"]="Arnau Arnau" ["greycat"]="Greg Wooledge" )
echo "Current user is: $USER.  Full name: ${fullNames[$USER]}."
for user in "${!fullNames[@]}"; do
    echo "User: $user, full name: ${fullNames[$user]}."
done

declare -A dict
dict[astro]="Foo Bar"
declare -p dict

indexedArray=( "one" "two" )
declare -A associativeArray=( ["foo"]="bar" ["alpha"]="omega" )
index=0 key="foo"
echo "${indexedArray[$index]}"
echo "${indexedArray[index]}"
echo "${indexedArray[index + 1]}"
echo "${associativeArray[$key]}"
echo "${associativeArray[key]}" # BOGUS
echo "${associativeArray[key + 1]}" # BOGUS
