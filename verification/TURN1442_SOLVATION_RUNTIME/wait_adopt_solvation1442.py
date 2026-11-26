from pathlib import Path
import time,subprocess
p=Path("work/solvation1342_chunked1442_report.json")
while not p.exists():time.sleep(10)
subprocess.run(["python3","work/adopt_solvation_chunked1442.py"],check=True)
