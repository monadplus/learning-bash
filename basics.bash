#!/usr/bin/env bash

{
names=("a" "b" "c")
select name in "${names[@]}"; do
    echo "$name"
    if [[ "$name" =~ [bc] ]]; then
        {echo "Exit"; break}
    fi
done
}

# parameter expansion
for file in *.JPG *.jpeg
do mv -- "$file" "${file%.*}.jpg"
done

# removes extension
${filename%.*}

langRegex='(..)_(..)'
if [[ $LANG =~ $langRegex ]]
then
    echo "Your country code (ISO 3166-1-alpha-2) is ${BASH_REMATCH[2]}."
    echo "Your language code (ISO 639-1) is ${BASH_REMATCH[1]}."
else
    echo "Your locale was not recognised"
fi

X=aabbc
REGEX='aa[^c]+c$'
if [[ "$X" =~ "$REGEX" ]]; then echo "OK"; else echo "KO"; fi

# REGEX='aa[^c]*b'
# ^^^ This is incorrect because [^c]* matches the empty string
# and then b matches aa(b)bc and returns OK.

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

############### Input & Output

# for arg in "$*"; do # BOGUS
# for arg in $@; do # BOGUS
for arg in "$@"; do
    echo "$arg"
done

echo "$1"; shift; echo "$1"

# exaple argument parsing: http://mywiki.wooledge.org/BashFAQ/035

# If you want to put information into the environment for your child processes to inherit
export MYVAR=something

# Standard Input (stdin): File Descriptor 0
# Standard Output (stdout): File Descriptor 1
# Standard Error (stderr): File Descriptor 2
read -p "What is your name? " name; echo "Good day, $name.  Would you like some tea?"

# stderr is also connected to your terminal's output device, just like stdout.
# As a result, error messages display on your monitor just like the messages on stdout.
# However, the distinction between stdout and stderr makes it easy to keep
# errors separated from the application's normal messages.

# custom errors to stderr
echo "Uh oh.  Something went really bad.." >&2

cat < README.md

for homedir in /home/*
do rm "$homedir/secret"
done 2> errors

for homedir in /home/*
do rm "$homedir/secret"
done 2> /dev/null

for homedir in /home/*
do rm "$homedir/secret"
done 2>> errors

grep "$HOSTNAME" /etc/*
# grep proud file 'not a file' > proud.log 2> proud.log # BOGUS
grep proud file 'not a file' > proud.log 2>&1

##### Heredocs (Here document)

grep proud <<EOF # EOF, END, whatever keyword
I am a proud sentence.
EOF
# everything between EOF becomes stdin for the command

# Does no substitution
cat <<'XYZ'
My home directory is $HOME
XYZ

usage() {
    cat <<EOF
usage: foobar [-x] [-v] [-z] [file ...]
A short explanation of the operation goes here.
It might be a few lines long, but shouldn't be excessive.
EOF
}

cat <<EOF > file
My home dir is $HOME
EOF

##### Herestrings
grep proud <<<"$USER sits proudly on his throne in $HOSTNAME."

echo 'Wrap this silly sentence.' | fmt -t -w 20 # Worse
fmt -t -w 20 <<< 'Wrap this silly sentence.' # Better

######## Pipes

mkfifo myfifo # aka named pipes
grep bea myfifo &
echo "rat
cow
deer
bear
snake" > myfifo

echo "rat
cow
deer
bear
snake" | grep bea

# The pipe operator creates a subshell environment for each command.
# This is important to know because any variables that you modify
# or initialize inside the second command will appear unmodified outside of it
message=Test
echo 'Salut, le monde!' | read message
echo "The message is: $message"
# The message is: Test
echo 'Salut, le monde!' | { read message; echo "The message is: $message"; }
# The message is: Salut, le monde!


################ Compound Commands

### Subshells

(cd /tmp || exit 1; date > timestamp) # moves only inside subshell
pwd

### Command grouping

# Commands may be grouped together using curly braces.
# Command groups allow a collection of commands to be considered as a whole with regards to redirection and control flow

{ echo "Starting at $(date)"; rsync -av . /backup; echo "Finishing at $(date)"; } >backup.log 2>&1

# for behave like a command grouping
echo "cat
mouse
dog" > inputfile
for var in {a..c}; do read -r "$var"; done < inputfile
echo "$b"

[[ -f $CONFIGFILE ]] || { echo "Config file $CONFIGFILE not found" >&2; exit 1; }

### Arithmetic Evaluation
unset a; a=4+5 # 4+5
let a=4+5 # 9
let a='(5+2)*3' # 21
if [[(($a == 21))]]; then echo 'Blackjack!'; fi

echo "There are $(($rows * $columns)) cells"

## ternary operator
((abs = (a >= 0) ? a : -a))

# Note that we used variables inside ((...)) without prefixing them with $-signs.
# This is a special syntactic shortcut that Bash allows inside arithmetic evaluations and arithmetic expressions.
(flag=1; if ((flag)); then echo "uh oh, our flag is up"; fi)
(flag=0; if ((flag)); then echo "uh oh, our flag is up"; fi)

#### Functions

open() {
    case "$1" in
        *.mp3|*.ogg|*.wav|*.flac|*.wma) xmms "$1";;
        *.jpg|*.gif|*.png|*.bmp)        display "$1";;
        *.avi|*.mpg|*.mp4|*.wmv)        mplayer "$1";;
    esac
}

# Recall 'for file' is equivalent to 'for file in "$@"'
for file; do
    open "$file"
done

# Functions may also have local variables, declared with the local or declare keywords
count() {
    local i # declare i
    for ((i=1; i<=$1; i++)); do echo $i; done
    echo 'Ah, ah, ah!'
}
for ((i=1; i<=3; i++)); do count $i; done


#### Alias

# Do not work on scripts

#### Destroying

unset -f myfunction
unset -v 'myArray[2]'


##################### Sourcing

# When you call one script from another, the new script inherits the environment of the original script.
# When the script that you ran (or any other program, for that matter) finishes executing, its environment is discarded.

# dotting
. ./myscript # your shell will keep the state of myscript

##################### Job Control

# $ jobs
# $ Ctrl-z  # suspend
# $ fg # bring background job to the foreground
# $ bg # run a suspended job in the background
# $ suspend

files=(*.ogg)
for i in "${!files[@]}"; do
  if ...; then
    unset 'files[i]'
  fi
done
mplayer "${files[@]}"

# Parse a file like:
# Smith    Beatrice   1970-01-01 123456789
# Jackson  Paul          1980-02-02   987654321
# O'Leary  Sheamus 1977-07-07 7777777
while read -r last first birth ssn; do
  ...
done < "$file"

# Parse /etc/group
while IFS=: read -r group pass gid users; do
  ...
done < "$file"


##### Remove the IPs in my blocklist file, from my logfile

declare -A bad  # associative array
while IFS=: read -r ip _; do
  bad["$ip"]=1
done < blocklist

unset tmp
trap '[[ $tmp ]] && rm -f "$tmp"' EXIT # captures the EXIT signal and removes the temporal file.
tmp=$(mktemp) || exit # creates a temporal file.

while read -r ip rest; do
  [[ ${bad["$ip"]} ]] && continue
  printf '%s %s\n' "$ip" "$rest"
done < logfile > "$tmp"

mv "$tmp" logfile

#### Find duplicate files in a directory hierarchy

# Usage: finddups [directory]
declare -A seen # associative array
while read -r -d '' md5 file; do
  if [[ ${seen["$md5"]} ]]; then
    printf 'Matching MD5: "%s" and "%s"\n' "${seen["$md5"]}" "$file"
  fi
  seen["$md5"]=$file
done < <(find "${1:-.}" -type f -exec md5sum -z {} +)

##### Example 1: Modifying a config file

# File format:

# options => {
#   log_stats => 86400
#   tcp_timeout => 15 ; zonefile-style comment
#   include_optional_ns => true
#   listen => [ 0.0.0.0 ]
# }

# plugins => {
#   weighted => {
#     multi = false # default
#     service_types = up
#     up_thresh => 0.1 # default

#     xlaunch => {
#       server1 = [ 1.1.1.1, 50 ]
#       server2 = [ 2.2.2.2, 50 ]
#       server3 = [ 3.3.3.3, 50 ]
#      }
#   }
# }

changed=0
# server1 = [ IP, nn ]
#    # server2 = [ 192.0.0.1, 8080 ]
s='[[:space:]]*'
re="^($s)(#?)$s(server[[:alnum:]]*)$s=$s\[$s([[:digit:].]*)$s,$s([[:digit:]]*)$s\]$s\$"

while IFS= read -r line; do
    if [[ "$line" =~ $re ]]; then
        # This is a server line.  Use simple names for the extracted pieces.
        white=${BASH_REMATCH[1]}
        wascomment=${BASH_REMATCH[2]}
        host=${BASH_REMATCH[3]}
        ip=${BASH_REMATCH[4]}
        number=${BASH_REMATCH[5]}

        # Perform a ping test of the IP.  Linux ping syntax.
        if ping -c 1 "$ip" >/dev/null 2>&1; then
            comment=
        else
            comment="#"
        fi
        if [[ "$comment" != "$wascomment" ]]; then
            changed=1
        fi

        # Construct and write output server line.
        printf '%s%s%s = [ %s, %s ]\n' "$white" "$comment" "$host" "$ip" "$number"
    else
        # Not a server line.
        printf '%s\n' "$line"
    fi
done < inputfile > outputfile &&
mv outputfile inputfile

if ((changed)); then
    # restart service because a comment service now works or an uncommented service does no longer work.
fi
