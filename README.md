# sh app license choose

## desc

a simple sh app to choose license

## deps

### test

- [ ] xxx

### prod

- [ ] xxx

## apis

- [x] AorBQ
- [x] lang_get
- [x] node_add
- [x] sample_node_ini
- [x] node_to_question
- [x] sample_question_ini
- [x] sample_licence_get
- [x] sample_order_note

```sh
cat src/index.sh |  grep "function " | sed "s/function */- [x] /g"  | sed "s/(.*) *{//g"
```

## feats

- [x] lang support zh

## usage

### how to use for poduction?

```sh
# get the code

# run the index file
# ./src/index.sh

# or import to your sh file
# source /path/to/the/index file

# simple usage
bin/index.sh
```

### how to use for developer?

```sh
# get the code

# run test
#./test/index.sh
#2 get some fail test
#./test/index.sh | grep "it is false"
```

## author

yemiancheng <ymc.github@gmail.com>

## license

MIT
