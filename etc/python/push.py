import os

print("Please, enter a description for the commit and hit enter when you're done>")
s = input()

os.system("git add *")
os.system("git commit -m \"%s\"")
os.system("git push -u origin master")
