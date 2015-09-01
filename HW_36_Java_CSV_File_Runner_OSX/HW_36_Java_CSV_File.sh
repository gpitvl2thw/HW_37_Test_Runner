#!/bin/sh

# ========================================
GITHUB_ACCOUNT=$1
REPO_NAME=$2
APP_VERSION=$3
MAIN_CLASS=$4
ARGS_01=$5
# ========================================

if [ "$1" == "" ]; then echo "No arguments"; return; fi
if [ $# -lt 4 ]; then echo "Should be 4 arguments"; return; fi

# if ! which java >/dev/null 2>&1 ; then echo Java not installed; return; fi
# if ! which mvn >/dev/null 2>&1 ; then echo Maven not installed; return; fi
# if ! which git >/dev/null 2>&1 ; then echo Git not installed; return; fi

# java -version &>jv.txt;grep "java version" jv.txt | awk '{print $1,$3}'; 
if which java >/dev/null 2>&1 ; then java -version; else echo Java not installed; return; fi
# mvn --version &>mv.txt; grep "Apache Maven" mv.txt | awk '{print $2,$3}';
if which mvn >/dev/null 2>&1 ; then mvn --version; else echo Maven not installed; return; fi
# git --version &>gv.txt; grep "git version" gv.txt | awk '{print $1,$3}';
if which git >/dev/null 2>&1 ; then git --version; else echo Git not instlled; return; fi

# if [ -d "$WS_DIR" ] ; then cd ~/$WS_DIR; else echo $WS_DIR directory is not exist; return; fi
if [ -d "$REPO_NAME" ]; then rm -rf $REPO_NAME; fi
if [ "$REPO_NAME"".txt" ]; then rm "$REPO_NAME"".txt"; fi

git clone https://github.com/$GITHUB_ACCOUNT/$REPO_NAME.git
cd ./$REPO_NAME

mvn clean package -Dversion=$APP_VERSION
echo "Executing Java programm ..."
# java -cp ./target/$REPO_NAME-$APP_VERSION-jar-with-dependencies.jar $MAIN_CLASS >> ../$REPO_NAME.txt
java -jar ./target/$REPO_NAME-$APP_VERSION-jar-with-dependencies.jar >> ../$REPO_NAME.txt

cd ..
# if [ -d "$HOME/$WS_DIR/$REPO_NAME" ]; then rm -rf $HOME/$WS_DIR/$REPO_NAME; fi
if [ -d "$REPO_NAME" ]; then rm -rf $REPO_NAME; fi
