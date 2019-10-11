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

sshpass -p $DEPLOY_PASSWORD scp -o StrictHostKeyChecking=no dist.zip ${DEPLOY_USERNAME}@${TARGET_SERVER}:${M_TMP_DIR}

sshpass -p $DEPLOY_PASSWORD ssh ${DEPLOY_USERNAME}@${TARGET_SERVER} bash -c "'
cd ${M_TMP_DIR}
rm -rf tmp_zip
mkdir tmp_zip
unzip dist.zip -d tmp_zip
cp -Rpf tmp_zip/. ${M_REMOTE_DIR}
rm -rf tmp_zip
rm dist.zip
'"

echo "Deploy completed"
