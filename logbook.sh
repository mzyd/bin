#!/usr/bin/env bash

cur_date_time="2021-11-05"
end_time="2021-11-05"

# echo $cur_date_time
# echo $end_time

git log --since=$cur_date_time \
    --until=end_time --author="Seabiscuit" > abc.log && \
    sed -e /commit/d abc.log > nocommit.log && \
    sed -e /Author/d nocommit.log > noauthor.log && \
    sed -e /Date/d noauthor.log > nodate.log && \
    sed '/^\s*$/d' nodate.log > noblank.log && \
    # 把 /s/^[ \t]*/ 替换为空
    sed 's/^[ \t]*//' noblank.log > target.log && \
        cat target.log | pbcopy && \
        # echo "---------------------------------------"
        # echo "The content has clip to your clipboard."
        # echo "---------------------------------------"
        cat target.log && \
            echo "-------The content has cliped to your clipboard.-------" && \
            toilet -f smblock -F metal "done"

# toilet -f smblock -F metal "done"
# toilet -f smmono9 "done" --filter metal

# params g: The Reg expression is going to apply to the source file.
# sed 's/^[ \t]*//g' noblank.log


# cur_date_time="`date +%Y-%m-%d-%H:%m:%s`"
# cur_date_time="`date +%Y-%m-%d-00:00`"
# end_time="`date +%Y-%m-%d-23:59`"

