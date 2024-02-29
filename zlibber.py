import zlib, sys

zlib_file = sys.argv[1]

print ("----------------------------------------")
print (f"Trying to unpack ${zlib_file}")

try:
  with open(zlib_file, "rb") as file:
      compressedData = file.read()

  uncompressedData = zlib.decompress(compressedData)
  print("Great Success!")
except:
  sys.exit("Failed miserably!")

print (f"Saving unpacked zlib to {zlib_file}_result")
try:
  with open(zlib_file+"_result", "wb") as file:
      file.write(uncompressedData)
except:
  sys.exit("Save failed miserably!")

print ("-----------------[DONE]-----------------")
