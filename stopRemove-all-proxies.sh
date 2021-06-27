for l in $(lp|grep sslproxy|tr ":" " "| awk '// {print $2}'); do dkcrm $l;done
