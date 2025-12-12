pipeline {
    agent {
        label 'master || built-in'
    }

    stages {
        stage('Build docker image') {
            when {
                branch 'main'
                not {
                    changeRequest()
                }
            }
            steps {
                sh "docker build . -t openitcockpit/mkdocs"
            }
        }
        stage('Build and deploy') {
            when {
                branch 'main'
                not {
                    changeRequest()
                }
            }
            steps {
                sh 'docker run --rm --user 111:116 -v "$PWD":/docs -w /docs/de openitcockpit/mkdocs /usr/bin/mkdocs build'
                sh 'docker run --rm --user 111:116 -v "$PWD":/docs -w /docs/en openitcockpit/mkdocs /usr/bin/mkdocs build'
                sh 'mkdir -p htdocs/en'
                sh 'cp -r de/site/. htdocs/'
                sh 'cp -r en/site/. htdocs/en'

                sh 'rsync -avz -e "ssh -o StrictHostKeyChecking=no -i /var/lib/jenkins/.ssh/id_rsa" --progress --delete ./htdocs/. www-data@srvoitcdocs01.static.itsm.love:/var/www/docs.openitcockpit.io/'
            }
        }
    }

}
