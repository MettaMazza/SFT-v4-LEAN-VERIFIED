from pathlib import Path
import json,time,subprocess,hashlib
w=Path('work');r=Path('/Volumes/One Touch/SFT v4 Full model LEAN')
required=['composite1019_program_report.json','composite1019_fresh_report.json','composite_independent1019_report.json']
while not all((w/f).exists() for f in required):time.sleep(3)
for name in required[:2]:assert json.loads((w/name).read_text())['status']=='PASS'
cases=json.loads((w/required[2]).read_text());assert len(cases)==4 and all(x['expected']==x['actual']['passed'] for x in cases)
cfg=json.loads((w/'composite1020_proofs_config.json').read_text())
for mod,h in cfg['source_sha256'].items():assert hashlib.sha256((r/f'SFT/Physics/{mod}.lean').read_bytes()).hexdigest()==h
subprocess.run(['python3','work/register_composite1020.py'],check=True)
