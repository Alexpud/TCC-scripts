--This script was created for the sole purpose of testing the the lua executiong of the bash scripts in this folder.
print(arg[1])
os.execute('. /etc/environment')
os.execute('/home/boss/nginx_scripts/start_che.sh run' .. arg[1])
--io.popen('echo "5">/home/boss/nginx_scripts/data.txt')
print("a")
