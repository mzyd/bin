#!/usr/bin/env bash

# cur_date_time="2021-11-11-00:00"
# end_time="2021-11-11-23:45"

cur_date_time="`date +%Y-%m-%d-00:00`"
end_time="`date +%Y-%m-%d-23:59`"


# get_git_author() {
#     git config --global user.name > info.foo && git_author=$(cat ./info.foo) && \
#         return git_author
# }

# Get the git author
git config --global user.name > info.foo && git_author=$(cat ./info.foo) && \

# echo $cur_date_time
# echo $end_time

git log --since=$cur_date_time \
    --until=$end_time \
    --author=$git_author > abc.foo && \
sed -e /commit/d abc.foo > nocommit.foo && \
sed -e /Author:/d nocommit.foo > noauthor.foo && \
sed -e /Date:/d noauthor.foo > nodate.foo && \
sed '/^\s*$/d' nodate.foo > noblank.foo && \
# 把 /s/^[ \t]*/ 替换为空
sed 's/^[ \t]*//' noblank.foo > target.foo && \
cat target.foo | pbcopy && \
# echo "---------------------------------------"
# echo "The content has clip to your clipboard."
# echo "---------------------------------------"
cat target.foo && \
echo "-------The content has cliped to your clipboard.-------" && \
toilet -f smblock -F metal "done" && \
rm *.foo

# toilet -f smblock -F metal "done"
# toilet -f smmono9 "done" --filter metal

# params g: The Reg expression is going to apply to the source file.
# sed 's/^[ \t]*//g' noblank.foo


# cur_date_time="`date +%Y-%m-%d-%H:%m:%s`"
# cur_date_time="`date +%Y-%m-%d-00:00`"
# end_time="`date +%Y-%m-%d-23:59`"
