#!/usr/bin/env bash

start=$(date +%s)
if [ "$1" = "dev" ]; then
    echo "It's god damn dev for front..."
    cd /Users/mzy/work/front/src && mv config.js foo.js && touch config.js && echo "module.exports = { baseURL: \`http://120.209.135.54:63384\` }" > config.js && \
        cd /Users/mzy/work/front && \
        # build
        npm run build:prod && \
            rm ./src/config.js && mv ./src/foo.js ./src/config.js && \
            # delete the server's file
            ssh ff "rm -rf /home/projects/operation-html/*" && \
                # copy to the server
            scp -P 60022 ./application_prod_*.zip root@120.209.135.54:/home/projects/operation-html && \
                ssh ff "unzip /home/projects/operation-html/application*.zip -d /home/projects/operation-html/" && echo "Finally! It's fucking done!"

elif [ "$1" = "co" ]
then
    echo "It's community dev project..."
    cd /Users/mzy/work/community-operation && npm run build:prod && \
        tar -cvf app.tar ./dist && \
        ssh coo "rm -rf /home/cncqs/nginx/frontend/estate/*" && \
        scp -P 10025 /Users/mzy/work/community-operation/app.tar root@120.209.135.54:/home/cncqs/nginx/frontend/estate && \
        ssh coo "cd /home/cncqs/nginx/frontend/estate && tar -xvf app.tar && mv dist/* ./" && \
        echo "It's fucking done."

elif [ "$1" = "testco" ]
then
    echo "It's test for community project..."
    cd /Users/mzy/work/community-operation && npm run build:prod && \
        tar -cvf app.tar ./dist && \
        ssh co "rm -rf /home/cncqs/c-front/dist && rm /home/cncqs/c-front/app.tar"
    scp app.tar root@192.168.1.62:/home/cncqs/c-front/ && \
        ssh co "cd /home/cncqs/c-front/ && tar -xvf app.tar" && \
        # cd dist && \
        # ssh co "bash ~/bin/kill-8080.sh" && \
        ssh co "cd /home/cncqs/c-front/dist && nohup http-server 1>/dev/null 2>/dev/null &" &&
        echo "It's fucking done."


elif [ "$1" = "prod" ]
then
    echo "It's fucking production for project front..."
    cd /Users/mzy/work/front/src && mv config.js foo.js && touch config.js && echo "module.exports = { baseURL: \`https://operations.cncqs.cn\` }" > config.js && \
        cd /Users/mzy/work/front && \
        npm run build:prod && \
        rm ./src/config.js && mv ./src/foo.js ./src/config.js && \
        ssh ff "rm -rf /home/front-project-prod/*" && \
        scp -P 60022 ./application_prod_*.zip root@120.209.135.54:/home/front-project-prod/ && \
        ssh ff "unzip /home/front-project-prod/application*.zip -d /home/front-project-prod/" && \
        echo "Finally, It's fucking done!"
else
    toilet -f smblock -F metal "No params!"
fi

end=$(date +%s)
take=$(( end - start ))
toilet -f smblock -F metal "It tooks ${take} seconds."
