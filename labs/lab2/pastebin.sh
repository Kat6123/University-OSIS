#!/bin/bash

MODE=0                # 0 - input, 1 - output
TYPE=""           # choose type of file
OUTPUT="/dev/stdout"
INPUT="/dev/stdin"
DIR="$HOME/.pastebin/"
ID=''
ID_LENGTH=8

function help {
  cat <<END_HELP
Usage: $1 [-f FILE] [-o FILE] [-l FILE_EXTENSION] [-h]
  -f, --file        Input file else stdin
  -t, --type        File extension (ex. -l py) to use for higlited output
  -o, --output      File to input elde stdout is used.
  -h, --help        This help
END_HELP
}

function list {
  ls $DIR
}

function generate_id() {
  cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w $ID_LENGTH | head -n 1
}

function check() {
  if [[ ! -d $DIR ]]; then
    mkdir $DIR
  fi


  if [[ $MODE -eq 1 ]]; then
    if [[ $INPUT != "/dev/stdin" ]]; then
      echo "Error: -f and -o exclusive parametrs"
      exit 1
    fi
    if [[ -z $ID ]]; then
      echo "Thera are no id for output"
      exit 1
    fi
  else
    if [[ ! -f "$INPUT" ]]; then
      echo "There are no such file"
      exit 1
    fi
  fi
}

function create_new() {
  if [[ -z $TYPE ]]
  then
    ext=${INPUT##*.}                # Get extension by using Parametr expansion
    [[ $ext == $INPUT ]] && TYPE="text" || TYPE=$ext
  fi

  local NEW_UUID=`generate_id`
  local file_name=$DIR$NEW_UUID

  echo "$TYPE" >> "$file_name"
  while read line
  do
    echo "$line" >> "$file_name"
  done < "$INPUT"
  echo $NEW_UUID
}

function output() {
  local file_name=$DIR$ID

  if [[ ! -f "$file_name" ]]; then
    echo "There are no such file"
    exit 1
  fi

  local type="-l $TYPE"
  [[ -z $TYPE ]] && type="-l $(head -n 1 $file_name)"

  [[ $OUTPUT == "/dev/stdout" ]] &&
  pygmentize $type < <(tail -n "+2" $file_name) ||
  pygmentize -f html -O full -o $OUTPUT < <(tail -n "+2" $file_name)
}

function main() {
  if [[ $MODE -eq 0 ]]; then
    create_new
  else
    output
  fi
}

TEMP=`getopt -o lhf:t:o: --long list,help,file:,type:,output: -n 'test.sh' -- "$@"`
if [ $? != 0 ] ; then echo "Failed parsing options." >&2 ; exit 1 ; fi

eval set -- "$TEMP"
while true ; do
    case "$1" in
        -f|--file) INPUT=$2 ; shift 2 ;;
        -t|--type) TYPE=$2 ; shift 2 ;;
        -o|--output)OUTPUT=$2; shift 2 ;;
        -h|--help) help $0; exit 0;;
        -l|--list) list; exit 0;;
        --)
          case "$2" in
              "") shift ; break ;;
              *) MODE=1; ID=$2; shift ; break ;;
          esac;;
        *) echo "Internal error!" ; exit 1 ;;
    esac
done

check
main
