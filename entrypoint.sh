#!/bin/sh -l

M_LOCAL_DIR=${LOCAL_DIR:-"./"}
M_REMOTE_DIR=${REMOTE_DIR:-"~/"}
M_TMP_DIR=${TMP_DIR:-"~/"}


echo "Creating a zip files..."
cd $M_LOCAL_DIR
zip ~/dist.zip -r ./ -x \*/.git/\* $EXCLUDE
cd ~/
echo "Zip file created."


echo "Deploying files"

if [ -z "$DEPLOY_PASSWORD" ]
then
      SSHCOMMAND="echo $DEPLOY_SECRETKEY | ssh -i /dev/stdin"
      SCPCOMMAND="echo $DEPLOY_SECRETKEY | scp -i /dev/stdin"
else
      SSHCOMMAND="sshpass -p $DEPLOY_PASSWORD scp"
      SCPCOMMAND="sshpass -p $DEPLOY_PASSWORD ssh"
fi

${SCPCOMMAND} -o StrictHostKeyChecking=no dist.zip ${DEPLOY_USERNAME}@${TARGET_SERVER}:${M_TMP_DIR}

${SSHCOMMAND} ${DEPLOY_USERNAME}@${TARGET_SERVER} bash -c "'
cd ${M_TMP_DIR}
rm -rf tmp_zip
mkdir tmp_zip
unzip dist.zip -d tmp_zip
cp -Rpf tmp_zip/. ${M_REMOTE_DIR}
rm -rf tmp_zip
rm dist.zip
'"

echo "Deploy completed"
