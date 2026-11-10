from pathlib import Path
import json,re,copy,subprocess,textwrap
r=Path('work/constants-recovery').resolve();stem='Lattice';component='CollectiveLattice';auditcfg={};source=Path('work/run_collective545.py').read_text();a=source.index(' modules=[stem+t');b=source.index('\n p=Path(',a);exec(textwrap.dedent(source[a:b]))
audit=Path('work/auditcollective545_Lattice.log').read_text();assert all("'"+n+"' does not depend on any axioms" in audit for n in auditcfg[stem]['declarations'])
for part in ['program','validation']:assert json.loads(Path(f'work/lattice_{part}545_report.json').read_text())['status']=='PASS'
a=source.index(' actual=json.load');b=source.index('\nPath(\'work/auditcollective545_config',a);exec(textwrap.dedent(source[a:b]));Path('work/auditcollective545_config.json').write_text(json.dumps(auditcfg,indent=2));print('Recovered passing current audit and program checks; validation and independent cases passed')
