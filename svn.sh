#!/bin/bash
clear;

# Variables
DATE=`date +%Y`;
SVN_SERVER=https://subversion.assembla.com/svn/platform/trunk;
SVN_USERNAME=impixel;
SVN_PASSWORD=askme;

# List of websites (Paths to Platform Directory)
websites=(	"/var/www/vhosts/domain.co.uk/httpdocs/YourPlatform/"
			"/var/www/vhosts/domain.co.uk/httpdocs/YourPlatform/"
		 );


# Welcome Message
echo -e "\033[32m
*********************************************************************

	Welcome to Cube Platform Automatic/Manual Update Software					
	Author: Hadi Tajallaei <hadi@impixel.com>					
	Copyright © $DATE IMPIXEL. All rights reserved.
	Release Date: 1st Jun 2015

*********************************************************************";

echo -n -e "\033[91mDo you wish to do automatic update on all websites? (y/n): ";
read answer
if [[ "$answer" == "y" ]]; then

	   	for i in "${websites[@]}"
			do
			   :
			   	echo -e "\033[0m-----------------------------------------------------------";
			   	echo "Changing directories to $i";
				cd $i;
				#pwd;
			   	echo "Checking the server revision...";
				SERVER_REVISION=`svn info --username $SVN_USERNAME --password $SVN_PASSWORD $SVN_SERVER | grep Revision: | sed 's .\{10\}  '`;
				echo "Server at revision $SERVER_REVISION";
				echo "Checking the working copy revision...";
				LOCAL_REVISION=`svn info | grep Revision: | sed 's .\{10\}  '`;
				echo "Working copy at revision $LOCAL_REVISION";
				
				# compares server revision (SVN) to installed version
				if [[ "$SERVER_REVISION" == "$LOCAL_REVISION" ]]; then
				    echo -e "\033[32mWebsite is up to date. Nothing to do.";
				else
				    echo -e "\033[33mRunning SVN update. Please wait...";
			    	svn update --username $SVN_USERNAME --password $SVN_PASSWORD;
				fi
			done

	else
		for i in "${websites[@]}"
			do
			   :
			   	echo -e "\033[0m-----------------------------------------------------------";
			   	echo "Changing directories to $i";
				cd $i;
				#pwd;
			   	echo "Checking the server revision...";
				SERVER_REVISION=`svn info --username $SVN_USERNAME --password $SVN_PASSWORD $SVN_SERVER | grep Revision: | sed 's .\{10\}  '`;
				echo "Server at revision $SERVER_REVISION";
				echo "Checking the working copy revision...";
				LOCAL_REVISION=`svn info | grep Revision: | sed 's .\{10\}  '`;
				echo "Working copy at revision $LOCAL_REVISION";
				
				# compares server revision (SVN) to installed version
				if [[ "$SERVER_REVISION" == "$LOCAL_REVISION" ]]; then
				    echo -e "\033[32mWebsite is up to date. Nothing to do.";
				else
				    echo -n "Do you want to update $i (y/n): ";
					read text
					if [[ "$text" == "y" ]]; then
					   	echo -e "\033[33mRunning SVN update. Please wait...";
				    	svn update --username $SVN_USERNAME --password $SVN_PASSWORD; 
					fi
				fi
			   	

			done
fi


echo -e "\033[32m
---------------------------------------------------------------------
			Process is now finished
---------------------------------------------------------------------";
echo -e "\033[0m";
exit