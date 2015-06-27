#!/bin/bash

FILES=$HOME/Project/Zippia/Data/Resumes/documents-export-2015-06-26/*.csv

USERNAME=`whoami`
HOME_DIR=$(getent passwd $USERNAME | cut -d: -f6)

# Get directory in which this script is running,
# and where its support scripts therefore live:
currScriptsDir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# If the home dir has a readable file called mysql in its .ssh
# subdir, then pull the pwd from there:
if test -f $HOME_DIR/.ssh/mysql && test -r $HOME_DIR/.ssh/mysql
then
    MYSQL_PWD=`cat $HOME_DIR/.ssh/mysql`
else
    echo "Could not find MySQL password."
    exit -1
fi

# Drop, and recreate the resume table:
echo echo `date`":Dropping and recreating resume table..."
mysql -u $USERNAME -p$MYSQL_PWD < ${currScriptsDir}/createResumeTbl.sql

for resumeFile in $FILES
do
  echo echo `date`":Loading $resumeFile resumes into MySQL..."
  mysqlLoadCmd="LOAD DATA LOCAL INFILE '"$resumeFile"' 
		INTO TABLE Resumes
		FIELDS TERMINATED BY ',' 
		OPTIONALLY ENCLOSED BY '\"'
		LINES TERMINATED BY '\n' 
                IGNORE 1 LINES 
                (ID, 
		 SourceURL,
		 ContactName,
		 CoverLetterObjective,
		 City,
		 State,
		 CoverLetterParagraphs,
		 VisaStatus,
		 W1Title,
		 W1Organization,
		 W1City,
		 W1State,
		 W1Duration_To,
		 W1Duration_From,
		 W1Description,
		 W2Title,
		 W2Organization,
		 W2City,
		 W2State,
		 W2Duration_To,
		 W2Duration_From,
		 W2Description,
		 W3Title,
		 W3Organization,
		 W3City,
		 W3State,
		 W3Duration_To,
		 W3Duration_From,
		 W3Description,
		 W4Title,
		 W4Organization,
		 W4City,
		 W4State,
		 W4Duration_To,
		 W4Duration_From,
		 W4Description,
		 W5Title,
		 W5Organization,
		 W5City,
		 W5State,
		 W5Duration_To,
		 W5Duration_From,
		 W5Description,
		 W6Title,
		 W6Organization,
		 W6City,
		 W6State,
		 W6Duration_To,
		 W6Duration_From,
		 W6Description,
		 W7Title,
		 W7Organization,
		 W7City,
		 W7State,
		 W7Duration_To,
		 W7Duration_From,
		 W7Description,
		 W8Title,
		 W8Organization,
		 W8City,
		 W8State,
		 W8Duration_To,
		 W8Duration_From,
		 W8Description,
		 W9Title,
		 W9Organization,
		 W9City,
		 W9State,
		 W9Duration_To,
		 W9Duration_From,
		 W9Description,
		 W10Title,
		 W10Organization,
		 W10City,
		 W10State,
		 W10Duration_To,
		 W10Duration_From,
		 W10Description,
		 W11Title,
		 W11Organization,
		 W11City,
		 W11State,
		 W11Duration_To,
		 W11Duration_From,
		 W11Description,
		 W12Title,
		 W12Organization,
		 W12City,
		 W12State,
		 W12Duration_To,
		 W12Duration_From,
		 W12Description,
		 W13Title,
		 W13Organization,
		 W13City,
		 W13State,
		 W13Duration_To,
		 W13Duration_From,
		 W13Description,
		 W14Title,
		 W14Organization,
		 W14City,
		 W14State,
		 W14Duration_To,
		 W14Duration_From,
		 W14Description,
		 W15Title,
		 W15Organization,
		 W15City,
		 W15State,
		 W15Duration_To,
		 W15Duration_From,
		 W15Description,
		 E1Course,
		 E1School_University,
		 E1City,
		 E1State,
		 E1Duration_To,
		 E1Duration_From,
		 E2Course,
		 E2School_University,
		 E2City,
		 E2State,
		 E2Duration_To,
		 E2Duration_From,
		 E3Course,
		 E3School_University,
		 E3City,
		 E3State,
		 E3Duration_To,
		 E3Duration_From,
		 E4Course,
		 E4School_University,
		 E4City,
		 E4State,
		 E4Duration_To,
		 E4Duration_From,
		 E5Course,
		 E5School_University,
		 E5City,
		 E5State,
		 E5Duration_To,
		 E5Duration_From,
		 E6Course,
		 E6School_University,
		 E6City,
		 E6State,
		 E6Duration_To,
		 E6Duration_From,
		 E7Course,
		 E7School_University,
		 E7City,
		 E7State,
		 E7Duration_To,
		 E7Duration_From,
		 E8Course,
		 E8School_University,
		 E8City,
		 E8State,
		 E8Duration_To,
		 E8Duration_From,
		 Skill,
		 A1Title,
		 A1Year,
		 A1Description,
		 A2Title,
		 A2Year,
		 A2Description,
		 A3Title,
		 A3Year,
		 A3Description,
		 A4Title,
		 A4Year,
		 A4Description,
		 A5Title,
		 A5Year,
		 A5Description,
		 Link1,
		 Link2,
		 Link3,
		 Link4,
		 Link5,
		 Link6,
		 Link7,
		 Link8,
		 AdditionalInformation
		 );"

#echo "mysqlLoadCmd: ${mysqlLoadCmd}"
  mysql -u $USERNAME -p$MYSQL_PWD Zippia -e "${mysqlLoadCmd}"
  echo `date`": Done loading resume file "$resumeFile"."
done

echo `date`":Indexing resumes..."

mysql -u $USERNAME -p$MYSQL_PWD < ${currScriptsDir}/indexResumes.sql

echo `date`":Done indexing resumes."