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

      stage("Check"){
           try{
               sh "echo bob"
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
           try{
               sh "docker build -t "+imag+" ."
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
