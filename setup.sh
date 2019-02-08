setup_problems()
{
	# Creates a list of filenames of the Problems
	filelist=()
	for file in *
	do
	    tempf=$(echo $file | grep "Problem[[:space:]][0-9]\{2\}\.")
	    [ -z "$tempf" ] && : || filelist[${#filelist[@]}+1]=$(echo "$tempf")
	done

	sleep 1
        echo "Setting up..."
	# Creates a directory for each of the problem file and moves it respectively
	newarray=()
	for ((i=1; i<= ${#filelist[@]}; i++ ));
	do
	    tempdir=$(echo "${filelist[i]}"| cut -d'.' -f 1)
	    ext=$(echo "${filelist[i]}"| cut -d'.' -f 2)

	    echo
	    echo "Creating directory for ${tempdir}"
	    mkdir "$tempdir"
            echo "Moving ${filelist[i]}"
	    mv "${filelist[i]}" "$tempdir"

	    # If the file is a C++ program then it compiles and creates the output file within the directory
	    # Make sure to compile and eliminate any individual file before running this script
	    if [ "$ext" = "cpp" ]; then
                 echo "C++ file detected"
		 echo "Compiling the file..."
	         g++ "${tempdir}/${filelist[i]}" -o "${tempdir}/${tempdir}.out"
	    fi
	done
	echo
}

echo "Setup start..."
setup_problems
echo "Setup end..."

