node ('builder') {
   stage 'Checkout'
   git url: 'https://github.com/dvsa/mot-docs.git', branch: env.BRANCH_NAME

   stage 'Install dependencies'
   sh ''' echo "gem 'therubyracer'" >> Gemfile'''
   sh 'sudo gem install bundler'
   
   stage 'Bundle install'
   sh 'bundle install'
   
   stage 'Middleman build'
   sh 'middleman build --verbose'
   
   stage 'Publish'
   publishHTML(target: [allowMissing: false, alwaysLinkToLastBuild: false, keepAll: false, reportDir: 'build', reportFiles: 'index.html', reportName: 'Mot docs' ])
}
