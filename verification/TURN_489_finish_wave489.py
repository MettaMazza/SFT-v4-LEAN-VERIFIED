from pathlib import Path
import os,time,subprocess,json
while True:
 try:os.kill(43241,0)
 except ProcessLookupError:break
 time.sleep(2)
assert 'Build completed successfully' in Path('work/build_field489.log').read_text()
subprocess.run(['python3','work/build_wave489.py'],check=True)
c=json.loads(Path('/Volumes/One Touch/SFT v4 Full model LEAN/COVERAGE.json').read_text());by={e['claim_id']:e for e in c['claims']}
assert all(by['SFT-PHYS-FIELD-'+key.replace('_','-')+'-001']['lean_status']=='complete' for _,key,_ in json.load(open('work/field489_entries.json')))
subprocess.run(['python3','-u','work/run_wave489.py'],check=True)
print('THREE WAVE ENTRIES CHECKED AND REGISTERED',flush=True)
