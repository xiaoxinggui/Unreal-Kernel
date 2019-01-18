import os

print("Please, enter a description for the commit and hit enter when you're done>")
s = input()

os.system("git add *")
c = str("git commit -m \"", s, "\"")
os.system(c)
os.system("git push -u origin master")
