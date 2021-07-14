node("master"){

//    println env_name

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
               sh "docker rm -f $(docker ps -aq)"
               sh "docker rmi -f $(docker images -q)"
               }catch (Exception e) {
                       sh "echo Kill_Delete Not exist"
                     }          
       }
      stage("Build Docker Image"){
           try{
               sh "docker build -t weather-api ."
               }catch (Exception e) {
                       sh "echo Not exist"
                     }          
       }
       stage("Uni test Docker Image"){
           try{
               sh "docker run -d -p 3000:3000 --detach --name unitest-weather-api weather-api:latest"
               sh "sleep 10"
               sh "docker stop unitest-weather-api"
               sh "docker rm unitest-weather-api"
               }catch (Exception e) {
                       sh "echo docker Not exist"
                     }          
       }
      
}
