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
      
      stage("Build Docker Image"){
           try{
               sh "docker build -t weather-api ."
               }catch (Exception e) {
                       sh "echo Not exist"
                     }          
       }
       stage("Uni test Docker Image"){
           try{
               sh "docker run -it -p 3000:3000 weather-api:latest"
               }catch (Exception e) {
                       sh "echo Not exist"
                     }          
       }
      
}
