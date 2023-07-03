import subprocess
from os import listdir
from os.path import isfile, join

path = "puzzles_4/"
# path = "testes-takuzu/"
onlyfiles = [f for f in listdir(path) if isfile(join(path, f))]

times = {}
passed = {}

for file in onlyfiles:
    if "input" not in file: continue

    output_file = path + file.replace("input", "output")

    p = subprocess.run(f"python takuzu.py < {path}{file}", shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    result = [x.replace("\r", "") for x in p.stdout.decode("utf-8").split("\n")]

    with open(output_file) as f:
        expected = f.read().split("\n")

    time = result.pop(-2)

    passed_f = result == expected
    print("." if passed_f else "F", end="", flush=True)
    times[file] = float(time)
    passed[file] = passed_f

print("\n\n--- TIME: ---")
for k in times:
    print(k, times[k], passed[k])