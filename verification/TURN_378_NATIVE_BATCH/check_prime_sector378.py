from pathlib import Path
import runpy,ast,json
# Execute only unchanged pinned pure definitions, as an independent output oracle.
import subprocess,types
from fractions import Fraction
pin='76f1b34e9e9682989adcbb088797b4ae4ce4fcf1';repo='/Volumes/One Touch/ernos-labs-sft-platform'
# The verification oracle calls the unchanged pinned source functions using the
# source-only loader retained with Turn377; native Lean never invokes Python.
core=runpy.run_path('work/check_cosmic_sources.py');ns=dict(core['ns'])
raw=subprocess.check_output(['git','-C',repo,'show',pin+':sft/physics/lineage_particle_laws.py']).decode();tree=ast.parse(raw)
nodes=[n for n in tree.body if isinstance(n,ast.FunctionDef)]
exec(compile(ast.fix_missing_locations(ast.Module(body=[ast.ImportFrom(module='__future__',names=[ast.alias(name='annotations')],level=0)]+nodes,type_ignores=[])),'pinned-lineage','exec'),ns)
ps=ns['prime_sector_ladder']();cs=[ns['sector_coupling'](p) for p in ps]
expected=[list(ps),[ns['mediator_count'](p) for p in ps],[(q.numerator,q.denominator) for q in cs],[int(ns['is_prime_count'](n)) for n in range(34)]]
actual=[ast.literal_eval(line) for line in Path('work/prime_sector378_native.txt').read_text().splitlines()]
assert actual==expected,(actual,expected)
report=dict(status='PASS',source_commit='76f1b34e9e9682989adcbb088797b4ae4ce4fcf1',source='sft/physics/lineage_particle_laws.py',scope='Fresh native complete ladder, all mediator and coupling values, and34 prime-count decisions match pinned original functions.',axiom_dependencies=0)
Path('work/prime_sector378_report.json').write_text(json.dumps(report,indent=2)+'\n');print(report)
