#!/bin/sh

THIS_FILE_PATH=$(cd $(dirname $0);pwd)
THIS_FILE_NAME=$(basename $0)

function AorBQ(){
  read -p "$1" -n 5 ANSWER
  ANSWER=$(echo $ANSWER | sed "s/^ +//g"|sed "s/ +$//g")
  [ -z "$ANSWER" ] && ANSWER=0
  [[ $ANSWER =~ ^(a|A|y|Y|0) ]] && echo "$2"
  [[ $ANSWER =~ ^(b|B|n|N|1) ]] && echo "$3"
  #^[0-9]+$
}
#AorBQ "1 YOUR LIKE IT ? A. YES B. NO ! " "A" "B"


function lang_get(){
  local lang_desc=
  [ "$2" ] && lang_desc="$2"
  [ -z "$lang_desc" ] && lang_desc=""
  #lang_desc=$(val_ini "$2" "")
  echo "$lang_desc" | grep "^$1"
}
#lang_get "1"
#lang_get "4"

function node_add(){
  local id=
  local a=
  local b=
  [ "$1" ] && id="$1"
  [ -z "$id" ] && id=1
  [ "$2" ] && a="$2"
  [ -z "$a" ] && a=""
  [ "$3" ] && b="$3"
  [ -z "$b" ] && b=""
  node=$(cat <<EOF
$node
$id:$a:$b
EOF
)
}

function sample_node_ini(){
  node=
  node_add "1" "2" "4"
  node_add "2" "3" "GPL"
  node_add "3" "LGPL" "mozila"
  node_add "4" "5" "apache"
  node_add "5" "BSD" "MIT"
  node=$(echo "$node" | sed "/^ *$/d")
}
# sample_node_ini
# echo "$node"

function node_to_question(){
  local id=
  local no=
  local ok=
  local an=

  local list=
  list=$(echo "$node" | sed "/^$/d")
  list=$(echo "$node" | sed "s/,/:/g")
  id=1
  an=1
  answers="$an"
  while [ -n "$id" ]
  do
    no=$(echo "$list"| grep "^$an"|cut -d ":" -f 2);
    ok=$(echo "$list"| grep "^$an"|cut -d ":" -f 3);
    #echo "an:$an,id:$id,no:$no,ok:$ok"
    desc=$(lang_get $id "$lang_desc");
    an=$(AorBQ "$desc" "$ok" "$no");
    id=$(echo "$list"| grep "^$an"|cut -d ":" -f 1);
    answers="$answers:$an"
    #sleep 1 ;
  done
}
#node_to_question

function sample_question_ini(){
  node_to_question
}
function sample_licence_get(){
  echo "$answers"|sed "s/.*://g"
}
function sample_order_note(){
  local history=
  history=$(cat <<EOF
1.1->2.1->3.1->LGPL
1.1->2.1->3.0->mozila
1.1->2.0->GPL
1.0->4.1->5.1->BSD
1.0->4.1->5.0->MIT
1.0->4.0->apache
EOF
)
  echo "$history" | sed "s/[0-9]\.//g"
}
#sample_order_note
lang_desc=$(cat<<EOF
1 他人改后，可否闭源？A. 可以 B. 不可 !
2 新增代码，同许可证？A. 可以 B. 不可 !
3 所改之处，提供说明？A. 必须 B. 不必 !
4 每一文件，提供说明？A. 必须 B. 不必 !
5 软件广告，用你的名？A. 可以 B. 不可 !
EOF
)
node=
answers=

sample_node_ini
sample_question_ini
sample_licence_get



## file-usage
# ./src/license.sh
