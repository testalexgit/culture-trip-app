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
               sh "sed -i -e '/name/s/Culture Trip EngOps Test/"+service+"/' package-lock.json"
               sh "sed -i -e '/name/s/Culture Trip EngOps Test/"+service+"/' package.json"
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
            
        
           try{
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
  
        stage("Push Docker Image"){
           try{
               sh "docker tag "+imag+" kipkent/"+imag
               sh "docker push kipkent/"+imag
               }catch (Exception e) {
                       sh "echo push Not exist"
                     }          
       }
  
        stage("Create yaml file for Kube"){
           try{
               sh "cp -avr /home/ubuntu/kube/* ."
               sh "sed -i 's/test/"+service+"/' deploy.yaml"
               sh "sed -i -e '/image/s/imhub/"+imag+"/' deploy.yaml"
               sh "sed -i 's/test/"+service+"/' lb.yaml"
               withCredentials([string(credentialsId: 'c906462e-cc63-41ab-be6e-18af085bc996', variable: 'PW1')]) {
               sh "sed -i -e '/value/s/123/${PW1}/' deploy.yaml"
               }
               }catch (Exception e) {
                       sh "echo push Not exist"
                     }          
       }
        stage("Deploy to kube"){
           try{
               sh "kubectl get svc && kubectl get pods"
               sh "kubectl apply -f deploy.yaml"
               sh "kubectl apply -f lb.yaml"
               }catch (Exception e) {
                       sh "echo push Not exist"
                     }          
       } 
        stage("Unitest in kube"){
           try{
               sh "wget http://http://a1a62ff1db6ee4813af9ac6b3fd0e10c-2050991439.eu-west-1.elb.amazonaws.com:3000"
               }catch (Exception e) {
                       sh "echo docker in kube Not exist"
                     }          
       }
}
