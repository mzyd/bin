#!/usr/bin/env bash

start=$(date +%s)
if [ "$1" = "dev" ]; then
    echo "It's god damn dev..."
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

else

    echo "It's fucking production..."

    # nb &&
    # ssh ff "rm -rf /home/front-project-prod/*" &&
    # scptoprod &&
    # ssh ff "unzip /home/front-project-prod/application*.zip -d /home/front-project-prod/"

    cd /Users/mzy/work/front/src && mv config.js foo.js && touch config.js && echo "module.exports = { baseURL: \`https://operations.cncqs.cn\` }" > config.js && \
        cd /Users/mzy/work/front && \
        npm run build:prod && \
        rm ./src/config.js && mv ./src/foo.js ./src/config.js && \
        ssh ff "rm -rf /home/front-project-prod/*" && \
        scp -P 60022 ./application_prod_*.zip root@120.209.135.54:/home/front-project-prod/ && \
        ssh ff "unzip /home/front-project-prod/application*.zip -d /home/front-project-prod/" && \
        echo "Finally, It's fucking done!"
fi

end=$(date +%s)
take=$(( end - start ))
toilet -f smblock -F metal "It tooks ${take} seconds."
