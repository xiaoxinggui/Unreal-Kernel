import sys
import hashlib as hs

md5 = hs.md5()
sha1 = hs.sha1()

filename = ""
result_file = "../../checksums.txt"
chunk_size = 65536

if len(sys.argv) > 1:
    filename = sys.argv[1]
    print("Calculating checksums of", filename)
else:
    print("Please, enter a filename")
    exit()

with open(filename, "rb") as _file:
    while True:
        # print("Reading data...")
        dat = _file.read(chunk_size)
        if not dat:
            print("End of data.")
            break
        md5.update(dat)
        sha1.update(dat)

print("MD5: {0}".format(md5.hexdigest()))
print("SHA1: {0}".format(sha1.hexdigest()))
print("Writing result...")

r = open(result_file, "w+")
r.write(format(md5.hexdigest()))
r.write("\r\n")
r.write(format(sha1.hexdigest()))

print("File written! Bye!")
