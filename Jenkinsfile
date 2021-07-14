node("master"){

  println env.JOB_NAME
  println env.BUILD_ID

  def name=env.JOB_NAME.tokenize('.')[0]
  service=name.toLowerCase()
  println service
  
  def branch=env.JOB_NAME.tokenize('.')[1]
  println branch
      
  def imag="${service}:v"+env.BUILD_ID
  println imag
      stage('Clean up Workspace')      {
          deleteDir()
      }
      stage ('checkout')      {
          checkout scm
          sh "pwd;ls"
      }

      stage("Build"){
           try{
               sh "npm install --silent --progress=false"
               }catch (Exception e) {
                       sh "echo Not exist"
                     }          
       }
      
      stage("Kill_Delete Containers,Images"){
           try{
               sh "docker rm -f \$(docker ps -aq)"
               sh "docker rmi -f \$(docker images -q)"
               }catch (Exception e) {
                       sh "echo Kill_Delete Not exist"
                     }          
       }
      stage("Build Docker Image"){
            withCredentials([string(credentialsId: 'c906462e-cc63-41ab-be6e-18af085bc996', variable: 'PW1')]) {
            sh "sed -i -e '/API_KEY/s/123/${PW1}/' Dockerfile"
            }
        
           try{
               sh "sed -i -e '/name/s/Culture Trip EngOps Test/"+service+"/' package-lock.json"
               sh "sed -i -e '/name/s/Culture Trip EngOps Test/"+service+"/' package.json"
               sh "docker build -t "+imag+" ."
               sh "docker tag branch_"+branch+" "+imag
               }catch (Exception e) {
                       sh "echo Not exist"
                     }          
       }
       stage("Uni test Docker Image"){
           try{
               sh "docker run -d -p 3000:3000 --detach --name unitest-"+service+" "+imag
               sh "sleep 10"
               sh "docker stop unitest-"+service
               sh "docker rm unitest-"+service
               }catch (Exception e) {
                       sh "echo docker Not exist"
                     }          
       }
      
}
