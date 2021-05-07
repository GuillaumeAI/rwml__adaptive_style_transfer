

source _env.sh
# Pulling docker images
docker pull $containertag
docker pull $compocontainertag

if [ "$1" != "--skip" ];then
	for s in custom-start-docker-ast-*.sh ; do
		echo "Launching/Installing : $s"
		./$s
	done
fi

if [ "$1" == "--httpd" ] || [ "$2" == "--httpd" ]; then
	echo "Launching/Installing WebApp..."
	./install-httpd-container.sh
else 
	echo "HTTP Was skipped"
	echo "use $0 --skip --httpd"
	echo "  to start it"
fi

#./custom-start-docker-ast-kandinsky-v01.sh
#./custom-start-docker-ast-picajgwill-v02.sh
#./custom-start-docker-ast-picajgwill-v03-030ik.sh
#./custom-start-docker-ast-picajgwill-v03-165ik.sh

