from pathlib import Path
import subprocess,sys,types,json,hashlib
root=Path('/Volumes/One Touch/ernos-labs-sft-platform');pin='76f1b34e9e9682989adcbb088797b4ae4ce4fcf1';rel='sft/materials/structural_counts.py'
source=subprocess.check_output(['git','-C',str(root),'show',pin+':'+rel],text=True)
assert source==(root/rel).read_text()
import runpy
ns=runpy.run_path('work/matsystems_spec678.py')['namespace'];m=types.SimpleNamespace(**ns)
expected=[]
for s in m.crystal_system_census():
 for c in m.CENTERING_CLASSES:expected.append('form\t'+s.name+'\t'+c+'\t'+str(m._centering_preserves_system(s.name,c)).lower())
for row in m.bravais_census():expected.append('held\t'+row.crystal_system+'\t'+row.centering)
actual=Path('work/bravais678_output.tsv').read_text().splitlines();assert actual==expected
cfg=json.load(open('work/bravais678_proofs_config.json'));audit=Path('work/bravais678_proofs_audit.log').read_text();assert all("'"+n+"' does not depend on any axioms" in audit for n in cfg['declarations'])
r=dict(status='PASS',source_pin=pin,source_sha256=hashlib.sha256(source.encode()).hexdigest(),full_forms=35,retained_rows=14,rejected_forms=21,audited_declarations=len(cfg['declarations']),lean_source_sha256={m:hashlib.sha256(Path('work/constants-recovery/SFT/Materials/'+m+'.lean').read_bytes()).hexdigest() for m in cfg['modules']},fresh_lean_execution=True,registered=False)
Path('work/bravais678_comparison.json').write_text(json.dumps(r,indent=2));print(json.dumps(r))
