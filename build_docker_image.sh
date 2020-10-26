docker login -u iosifnicolae2 docker.pkg.github.com
docker build -t docker.pkg.github.com/mailo-dev/minback-mongo/miniback-mongo:latest .
docker push docker.pkg.github.com/mailo-dev/minback-mongo/miniback-mongo:latest

