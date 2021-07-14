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
}
