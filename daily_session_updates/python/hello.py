import time
import subprocess
# checking current os version 
os_details=subprocess.getoutput('cat /etc/os-release')
while True:
    print("Hello world i am running in container")
    time.sleep(1)
    print("_____________")
    print("container os Libs is ")
    print(os_details)
    print("_____________")
    print("_____________")
    time.sleep(2)
