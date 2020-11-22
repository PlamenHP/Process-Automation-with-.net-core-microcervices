pipeline {
	agent any
	stages {
		stage ('Verify Branch') {
			steps {
				echo "$GIT_BRANCH"
			}
		}
		stage('Run Unit Tests') {
			steps {	
				sh 'cd Server'
				sh 'dotnet test'
				sh 'cd ..'
			}
		}
		stage('Docker Build') {
			steps {
				sh 'docker-compose build'
				sh 'docker images -a'
			}
		}
		stage('Run Test Application') {
			steps {
				sh 'docker-compose up -d' 
			}
		}
		stage('Run Integration Tests') {
			steps {
				sh './Tests/ContainerTests.ps1'
			}
		}
		stage('Stop Test Application') {
			steps {
				sh 'docker-compose down' 		
			}
			post {
				success {
					echo "Build successfull! You should deploy! :)"
				}
				failure {
					echo "Build failed! You should receive an e-mail! :("
				}
			}
		}
		stage('Push Images') {
			when { branch 'main' }
			steps {
				script {
					docker.withRegistry('https://index.docker.io/v1/', 'DockerHub') {
						def image = docker.image("plamenhp/carrentalsystem-identity-service")
						image.push("1.0.${env.BUILD_ID}")
						image.push('latest')
					}
				}
			}
		}
	}
}