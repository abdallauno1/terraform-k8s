pipeline {
	agent {label 'vagrant-worker'}
stages{
    stage ('Update machine'){
	 steps {
		sh 'sudo apt-get update'
	    }
	  }
	stage('Install Terraform'){
	  steps{
			script{
				def terraformOK  = fileExists '/usr/bin/terraform'
				if (terraformOK) {
					echo 'Skipping install terraform...already installed'
				}else{
					sh '''#!/bin/bash
				    	sudo apt-get install -y gnupg software-properties-common curl
                  			curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
                 			sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
                  			sudo apt-get update && sudo apt-get install terraform
                  
               			 '''	
			  }
		      }
		}
	    }

		
	stage ('Creating directory for the configuration...'){
		steps{
			script{
		       	  def dirExists  = fileExists '/home/vagrant/terraform'
				  if (dirExists) {
					echo 'Skipping creating directory ...directory present'
				}else{
				    sh 'mkdir ~/terraform/'
				   }			
			   }
    	 }
    	}
	 

	stage('removing previous clone if exists'){
		steps{
		    script{
		      def dirExists  = fileExists '$WORKSPACE/terraform-k8s/'
			   if (dirExists){
				 sh 'rm -rf $WORKSPACE/terraform-k8s/'	    
			       }
	   	     }
		 }		
	   }
  
	
	 stage('Clone github repo terraform-docker-nginx'){
		steps{
			script{
				def repoCloned  = fileExists '$WORKSPACE/terraform-k8s'
				    if (repoCloned){
					  sh 'rm -rf $WORKSPACE/terraform-docker-nginx'
				    }else{
					 					 
					 echo "$JOB_NAME"     
				}
			  	sh 'rm -rf $WORKSPACE/terraform-k8s'
        			sh 'https://github.com/abdallauno1/terraform-k8s.git' 
		   	     }
		      }
	  	}
	
	
	 stage('Moving file to terraform dir'){
		 steps{
			 script{
				def getRepo  = fileExists '~/terraform/terraform-k8s'
				    if (getRepo){
					  sh 'rm -rf ~/terraform/terraform-k8s'
				    } 
				   sh 'rm -rf ~/terraform/terraform-k8s'
				   sh 'mv $WORKSPACE/terraform-k8s ~/terraform/terraform-k8s/'
				}
		   	   }
	            }
	
	
	   stage('Terrafrom init'){
		 steps{
				
			      sh '''
				    set +x
				    cd ~/terraform/terraform-k8s				  
				    terraform init 
				 '''
		  }
	   }

	  stage(' Terrafrom Apply '){
		steps{
			      sh 'terraform apply -auto-approve'
	      	}
	     }


   }
  }