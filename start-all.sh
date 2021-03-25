

source _env.sh

for s in custom-start-docker-ast-*.sh ; do
	echo "Launching : $s"
	./$s
done

#./custom-start-docker-ast-kandinsky-v01.sh
#./custom-start-docker-ast-picajgwill-v02.sh
#./custom-start-docker-ast-picajgwill-v03-030ik.sh
#./custom-start-docker-ast-picajgwill-v03-165ik.sh

