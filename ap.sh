#!/usr/bin/env bash
# 90 - 前端; 91 - 管理系统
# 访问 http://120.209.135.54:63390/ 是前端
# 访问 http://120.209.135.54:63390/admin/ 在 nginx
# 会指向 http://120.209.135.54:63391
start=$(date +%s)
if [ "$1" = "dev" ]; then
    echo "It's god damn dev..."
    cd /Users/mzy/work/algorithm-platform/src/config && mv index.js foo.js && touch index.js && echo "export const baseURL = \`http://120.209.135.54:63390/dev-api\`" > index.js && \
        cd /Users/mzy/work/algorithm-platform && \
        # build
        npm run build && \
            rm ./app.tar && \
            tar -cvf app.tar ./dist && \
            rm ./src/config/index.js && mv ./src/config/foo.js ./src/config/index.js && \
            # delete the server's file
            ssh ff "rm -rf /home/algorithm-web/*" && \
                # copy to the server
            scp -P 60022 ./app.tar root@120.209.135.54:/home/algorithm-web && \
                ssh ff "tar -xvf /home/algorithm-web/app.tar -C /home/algorithm-web && mv /home/algorithm-web/dist/* /home/algorithm-web" && echo "Finally! It's fucking done!"

else

    # echo "It's fucking production..."
    echo "It's fucking mange..."

    cd /Users/mzy/work/ap-manage/src/config && mv index.js foo.js && touch index.js && echo "export const baseURL = \`http://120.209.135.54:63390/dev-api\`" > index.js && \
        cd /Users/mzy/work/ap-manage && \
        # build
        npm run build && \
            rm ./app.tar && \
            tar -cvf app.tar ./dist && \
            rm ./src/config/index.js && mv ./src/config/foo.js ./src/config/index.js && \
            # delete the server's file
            ssh ff "rm -rf /home/algorithm-manage/*" && \
                # copy to the server
            scp -P 60022 ./app.tar root@120.209.135.54:/home/algorithm-manage && \
                ssh ff "tar -xvf /home/algorithm-manage/app.tar -C /home/algorithm-manage && mv /home/algorithm-manage/dist/* /home/algorithm-manage" && echo "Finally! It's fucking done!"

fi

end=$(date +%s)
take=$(( end - start ))
toilet -f smblock -F metal "It tooks ${take} seconds."
