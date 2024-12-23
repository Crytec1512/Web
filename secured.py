import os
import getpass
import time
import hashlib
import stat
import threading

def hash_value(value, algorithm="sha256"):
	hash_obj = hashlib.new(algorithm)
	hash_obj.update(value.encode())
	return hash_obj.hexdigest()
	
if ((os.stat("secured.log").st_size == 0) == True):
	print("Create password!")
	pw = getpass.getpass()
	hash_pass = hash_value(pw, "sha256")
	with open("template.tbl", 'r') as f:
		lines = f.readlines()
	try:
		lines[0] = hash_pass + '\n'
		with open("template.tbl", 'w') as f:
			f.writelines(lines)
	except:
		with open("template.tbl", 'w') as f:
			f.write(hash_pass + '\n')
	with open("secured.log", 'a') as f1:
		f1.write("Password created" + '\n')
else: 	
	for i in range(3,-1,-1):
		if i != 0:
			print("Insert password. Tries left:", i)
			inserted_pass = getpass.getpass()
			with open("template.tbl", 'r') as f2:
				stored = f2.readline().rstrip()
				print(repr(hash_value(inserted_pass)))
				print(repr(stored))
				if repr(hash_value(inserted_pass)) == repr(stored):
					print("Password is correct")
					break
		else:
			print("Your password is incorrect!")
			exit()


with open("template.tbl", 'r') as f:
	objects = []
	for line in f:
		objects.append(line.strip())
		
objects.pop(0)
sysapp = objects[0:3]
other = objects[3::]
current_permissions = []
new_permissions = []
for line in objects:
	info = os.stat(line.strip())
	exact_perm = stat.S_IMODE(info.st_mode)
	current_permissions.append(exact_perm)
print(objects)
for symb in sysapp:
	os.chmod(symb.strip(), 0o700)

running = True
def main_cycle():
	global running
	
	while running:
		for each in os.listdir(os.getcwd()):
			if (each not in other) and (each not in sysapp):
				other.append(each)
				os.chmod(each, 0o700)
				
				with open("template.tbl", 'a') as f:
					f.write(each + '\n')
	

def stopping():
	global running
	
	print("Insert \q to kill the programm")
	while True:
		user_input = input()
		if user_input == r"\q":
			print("Programm is finished. All settings changed to common.")
			running = False
			break
	
	for j in range(len(objects)):
		os.chmod(objects[j].strip(), current_permissions[j])

	
main_thread = threading.Thread(target=main_cycle)
stop_thread = threading.Thread(target=stopping)

main_thread.start()
stop_thread.start()			

main_thread.join()
stop_thread.join()	
    
