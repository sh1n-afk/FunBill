# Credentials Folder

## The purpose of this folder is to store all credentials needed to log into your server and databases. This is important for many reasons. But the two most important reasons is
    1. Grading , servers and databases will be logged into to check code and functionality of application. Not changes will be unless directed and coordinated with the team.
    2. Help. If a class TA or class CTO needs to help a team with an issue, this folder will help facilitate this giving the TA or CTO all needed info AND instructions for logging into your team's server. 


# Below is a list of items required. Missing items will causes points to be deducted from multiple milestone submissions.

1. Server IP: `54.215.245.137`
2. SSH username: `ubuntu`
3. SSH password or key: `WebApp.pem`
    <br> If a ssh key is used please upload the key to the credentials folder.
4. Database IP and port used: `funbill-database.cbzocgpmqohp.us-west-1.rds.amazonaws.com` port `3306`
    <br><strong> NOTE THIS DOES NOT MEAN YOUR DATABASE NEEDS A PUBLIC FACING PORT.</strong> But knowing the IP and port number will help with SSH tunneling into the database. The default port is more than sufficient for this class.
5. Database username: `admin`
6. Database password: `funbill123`
7. Database name (basically the name that contains all your tables): `webapp`
8. Clear instructions with examples on how to use all the above information:
    
    ## STEPS TO PREPARE AND THEN SSH INTO EC2 INSTANCE THEN START THE WEBAPP
    
    1. Before accessing the ec2 instance, download the `WebApp.pem` that is in this credentials directory, then place it in it's own folder
        <br> You may need to edit the properties of this file if the steps following this throw an error says:
        <br> `@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@`
        <br> `@         WARNING: UNPROTECTED PRIVATE KEY FILE!          @`
        <br> `@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@`
        <br><br> If you are on windows follow these steps: 
        <br>![step 0](ExampleScreenshots/step0.JPG)
        <br><br> If you are on Linux or Mac, follow these steps in the terminal:
        <br>![step 0-1](ExampleScreenshots/step0-1.JPG)
        <br>replace the path after `600` with the path to the `WebApp.pem` that was downloaded
        <br><br>![step 0-2](ExampleScreenshots/step0-2.JPG)
        <br>replace the path after `755` with the path to the folder that contains `WebApp.pem` that was downloaded
        <br><br><br>
    
    2. Open command prompt or terminal and input 
        <br>`ssh -i secret/WebApp.pem ubuntu@e54.215.245.137`
        <br>and replace `secret/WebApp.pem` with the path to the WebApp.pem that was downloaded previously
        <br>![step 1](ExampleScreenshots/step1.JPG)
        <br><br>This should be displayed
        <br>![step 1-1](ExampleScreenshots/step1-1.JPG)
        <br><br><strong>IF ALL YOU NEED TO DO IS SSH INTO THE EC2 INSTANCE STOP HERE</strong><br><br><br>
   
    3. Type `cd horizontalprototype` to open the projects directory
        <br>![step 2](ExampleScreenshots/step2.JPG)
        <br><br>
        
    4. Type `npm start` to start the web application
        <br>![step 3](ExampleScreenshots/step3.JPG)
        <br><br>This should display:
        <br>![step 3-1](ExampleScreenshots/step3-1.JPG)
        <br><br><br>
    
    5. Open a internet browser and type `54.215.245.137:3000` into the address bar
        <br><br>A website similar to this should display:
        <br>![step 4](ExampleScreenshots/step4.JPG)
        <br><br><br><br><br><br>
    
    ## STEPS TO SET UP AND CONNECT TO THE MYSQL DATABASE THROUGH MYSQL WORKBENCH
    
    1. Open up mysql workbench
        <br>![dbstep 1](ExampleScreenshots/dbstep1.JPG)
        <br>Click on the <strong> plus </strong> sign: ![dbstep 1-1](ExampleScreenshots/dbstep1-1.JPG) to add a connection
        <br><br><br>
        
    2. This window will display:
        <br>![dbstep 2](ExampleScreenshots/dbstep2.JPG)
        <br><br><br>Open the `Connection Method` drop down menu and select `Standard TCP/IP over SSH`:
        <br>![dbstep 2-1](ExampleScreenshots/dbstep2-1.jpg)
        <br><br>Fill out the parameters accordingly:
        <br>![dbstep 2-2](ExampleScreenshots/dbstep2-2.jpg)
        <br> SSH Hostname: `54.215.245.137`
        <br> SSH Username: `ubuntu`
        <br> SSH Key File: Click the button on the right and select the path to `WebApp.pem`
        <br> MYSQL Hostname: `funbill-database.cbzocgpmqohp.us-west-1.rds.amazonaws.com`
        <br> MySQL Server Port:`3306`
        <br> Username:`admin`
        <br><br><br>
        
    3. Click `Test Connection` at the bottom:
        <br><br>This window will display:
        <br>![dbstep 3](ExampleScreenshots/dbstep3.jpg)
        <br><br> Enter the password: `funbill123`
        <br><br><br> <strong> IF THIS WINDOW DID NOT POP UP AND A ERROR SHOWS THEN ONE OF THE PREVIOUS FIELDS IS WRONG </strong>
        <br><br><br>
        
    4. Click `OK` in the `Setup New Connection` window then the connection to webapp has been successfully created:
        <br>![dbstep 4](ExampleScreenshots/dbstep4.JPG)
        

# Most important things to Remember
## These values need to kept update to date throughout the semester. <br>
## <strong>Failure to do so will result it points be deducted from milestone submissions.</strong><br>
## You may store the most of the above in this README.md file. DO NOT Store the SSH key or any keys in this README.md file.
