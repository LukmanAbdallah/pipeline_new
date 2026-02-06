pipeline {
    agent any

    environment {
        WAR_FILE = 'target/linkpay.war'
        MAVEN_TOOL = 'maven3.9.12'
    }

    stages {

        stage('1. Git Build') {
            steps {
                git branch: 'main', url: 'https://github.com/code9Bruno/pipeline1.git'
            }
        }

        stage('2. Maven Build') {
            steps {
                withMaven(maven: "${MAVEN_TOOL}") {
                    sh "mvn clean package -Dmaven.test.skip=true"
                }
            }
        }

        stage('3. SonarQube Analysis') {
            steps {
                echo "⏩ Skipping SonarQube analysis for now..."
            }
        }

        stage('4. Deploy to Nexus') {
            steps {
                echo "⏩ Skipping Nexus deployment for now..."
            }
        }

        stage('5. Deploy to Test Tomcat') {
            steps {
                echo "🚀 Deploying WAR to TEST Tomcat server..."
                deploy adapters: [
                    tomcat9(
                        credentialsId: 'tomcat-cred',
                        url: 'http://tomcat-dev:8080'
                    )
                ],
                contextPath: 'linkpay-test',
                war: "${WAR_FILE}"
            }
        }

        stage('6. Manual Approval Before Production') {
            steps {
                timeout(time: 10, unit: 'MINUTES') {
                    input message: "✅ Approve deployment to PRODUCTION Tomcat?"
                }
            }
        }

        stage('7. Deploy to Production Tomcat') {
            steps {
                echo "🚀 Deploying WAR to PRODUCTION Tomcat server..."
                deploy adapters: [
                    tomcat9(
                        credentialsId: 'tomcat-cred',
                        url: 'http://tomcat-prod:8080'
                    )
                ],
                contextPath: 'linkpay',
                war: "${WAR_FILE}"
            }
        }

    }
}
