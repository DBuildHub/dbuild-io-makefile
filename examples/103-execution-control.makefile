# a very simple makefile with one target executing one command
myDir="./my_dir"
create-dir:
  mkdir -p $(myDir)
copy-a-to-b:
  cp $(myDir) ./$(myDir)-copy
list-all-files_in_b: create-dir copy-a-to-b
  ls -la $(myDir)-copy
