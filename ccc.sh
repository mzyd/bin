#!/usr/bin/env bash

start=$(date +%s)
if [ "$1" = "dev" ]; then
    echo "It's god damn dev... deploy to 63386"
    cd /Users/mzy/work/ccc/src && mv config.js foo.js && touch config.js && echo "module.exports = { baseURL: \`http://120.209.135.54:63386\` }" > config.js && \
        cd /Users/mzy/work/ccc && \
        rm -rf ./dist && \
        # build
        npm run build:prod && \
            cd ./dist && \
            tar -cvf app.tar * && \
            cd .. && \
            rm ./src/config.js && mv ./src/foo.js ./src/config.js && \
            # delete the server's file
            ssh ff "rm -rf /home/projects/control-test/*" && \
                # copy to the server
            scp -P 60022 ./dist/app.tar root@120.209.135.54:/home/projects/control-test && ssh ff "cd /home/projects/control-test && tar -xvf /home/projects/control-test/app.tar" && echo "Finally! It's fucking done!"

else
    echo "It's god damn production... deploy to 63389"
    cd /Users/mzy/work/ccc/src && mv config.js foo.js && touch config.js && echo "module.exports = { baseURL: \`http://120.209.135.54:63389\` }" > config.js && \
        cd /Users/mzy/work/ccc && \
        rm -rf ./dist && \
        # build
        npm run build:prod && \
            cd ./dist && \
            tar -cvf app.tar * && \
            cd .. && \
            rm ./src/config.js && mv ./src/foo.js ./src/config.js && \
            # delete the server's file
            ssh ff "rm -rf /home/projects/control/*" && \
                # copy to the server
            scp -P 60022 ./dist/app.tar root@120.209.135.54:/home/projects/control && ssh ff "cd /home/projects/control && tar -xvf /home/projects/control/app.tar" && echo "Finally! It's fucking done!"

fi

end=$(date +%s)
take=$(( end - start ))
toilet -f smblock -F metal "It tooks ${take} seconds."
