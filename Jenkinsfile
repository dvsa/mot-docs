node ('builder') {
   stage 'Checkout'
   git url: 'https://github.com/dvsa/mot-docs.git'

   stage 'Install dependencies'
   sh 'sudo gem install bundler'
   
   stage 'Bundle install'
   sh 'bundle install'
   
   stage 'Middleman build'
   sh 'middleman build --verbose'
   
   if ("${env.BRANCH_NAME}" == "master") {
      stage 'Publish'
      publishHTML(target: [allowMissing: false, alwaysLinkToLastBuild: false, keepAll: false, reportDir: 'build', reportFiles: 'index.html', reportName: 'Mot docs' ])
   }
}
