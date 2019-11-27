echo "Remove Visual Studio build files"

if [ "$1" = "--help" ]; then
	echo -e "\nThis script will remove /bin and /obj directories inside all projects in a Visual studio solution"
	echo "Run this script at root or inside the /src directory of your project"
	echo "By default, this script only outputs the directories which can be deleted"
	echo "Run script with '-x' to execute permanently remove build files"
	exit 0
else
	echo -e "Use '--help' for instructions\n";
fi

# Make sure there exists directories in the location it's run
numOfDirs="$(ls -l | grep "^d" | wc -l)"

if [ "$numOfDirs" -eq "0" ]; then
   echo "This path contains no directories";
   echo "Make sure you run the script at project root or inside the /src folder of your project"
   exit 1;
fi

if [ "$1" = "-x" ];
then
	echo "Executing removal of build directories";
else
	echo "DRYRUN: Script would remove these directories:";
fi

# Handle running at project root and inside /src directory
projectsDir=$PWD

if [ -d "$PWD/src" ];
then
	projectsDir=$projectsDir"/src/*/"
else
	projectsDir=$projectsDir"/*/"
fi

# Loop over all directories inside /src
for dir in $projectsDir;
do
	objdir=$dir"obj"
	bindir=$dir"bin"
	if [ "$1" = "-x" ];
	then
		if [ -d "$objdir" ] && [ -d "$bindir" ];
		then
			echo "Deleting: $objdir";
			echo "Deleting: $bindir";
			rm -r $objdir $bindir;
		fi
	else
		if [ -d "$objdir" ] && [ -d "$bindir" ];
		then
			echo "$objdir";
			echo "$bindir";
		fi
	fi
done

if [ "$1" = "-x" ];
then
	echo -e "\nSuccess: Build files deleted";
else
	echo -e "\nRun the script with '-x' to permanently remove listed directories";
fi
