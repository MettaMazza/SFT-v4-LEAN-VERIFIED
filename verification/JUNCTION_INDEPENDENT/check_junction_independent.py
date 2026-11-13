from pathlib import Path
import copy, json, subprocess, sys, io, contextlib, hashlib, os, re

repo='/Volumes/One Touch/ernos-labs-sft-platform'
pin='76f1b34e9e9682989adcbb088797b4ae4ce4fcf1'
prefix='claims/SFT-MAT-SEMI-JUNCTION-001/'
def source(name):return subprocess.check_output(['git','-C',repo,'show',pin+':'+prefix+name])
receipt=json.loads(source('elimination_receipt.json'))
census=json.loads(source('candidate_census.json'))
controls=json.loads(source('controls.json'))
if 'census' in census:census=census['census']
if isinstance(controls,dict):controls=controls['controls']
base={**receipt,'census':census,'controls':controls,'seal_hash':'original-validator-comparison'}
survivor=next(x['candidate_id'] for x in base['decisions'] if x['survives'])
false={'candidate_id':survivor,'survives':False}
true={'candidate_id':survivor,'survives':True}
cases={'original':copy.deepcopy(base)}
def case(name,change):
 value=copy.deepcopy(base);change(value);cases[name]=value
case('wrong-claim',lambda s:s.update(claim_id='wrong'))
case('reversed-census',lambda s:s['census']['candidates'].reverse())
case('missing-candidate',lambda s:s['census']['candidates'].pop(0))
case('duplicate-candidate',lambda s:s['census']['candidates'].append(s['census']['candidates'][0]))
case('wrong-cardinality',lambda s:s['census'].update(expected_cardinality=255))
case('negative-cardinality',lambda s:s['census'].update(expected_cardinality=-1))
case('missing-decision',lambda s:s['decisions'].pop(0))
case('foreign-decision',lambda s:s['decisions'].append({'candidate_id':'outside-original-domain','survives':False}))
case('reversed-decisions',lambda s:s['decisions'].reverse())
case('earlier-false-overwritten',lambda s:s['decisions'].insert(0,false))
case('later-false-retained',lambda s:s['decisions'].append(false))
case('later-true-overwrites-false',lambda s:s['decisions'].extend([false,true]))
case('finite-closure',lambda s:s['closure'].update(scope='finite_complete'))
case('conditional-closure',lambda s:s['closure'].update(scope='conditional_grammar'))
case('failed-minimality',lambda s:s['closure'].update(minimality_passed=False))
case('failed-uniqueness',lambda s:s['closure'].update(named_shape_uniqueness_passed=False))
case('missing-control',lambda s:s['controls'].pop(0))
case('duplicate-control',lambda s:s['controls'].append(s['controls'][0]))
case('failed-control',lambda s:s['controls'].append({'kind':'boundary','passed':False}))
case('reversed-controls',lambda s:s['controls'].reverse())
case('seal-identity',lambda s:s.update(seal_hash='different-seal'))
native=[json.loads(x) for x in Path('work/junction_independent_native.jsonl').read_text().splitlines()]
assert native[0]==[x['candidate_id'] for x in census['candidates']]
actual={x['case']:x['result'] for x in native[1:]}
assert set(actual)==set(cases)
script=source('independent_validator.py'); env={'__name__':'source_validator'}
exec(compile(script,prefix+'independent_validator.py','exec'),env)
directory=Path('work/junction-independent-cases');directory.mkdir(exist_ok=True)
results=[]
for name,sealed in cases.items():
 path=directory/(name+'.json');path.write_text(json.dumps(sealed))
 saved=sys.argv;sys.argv=['original_validator',str(path)];capture=io.StringIO()
 try:
  with contextlib.redirect_stdout(capture):env['main']()
 finally:sys.argv=saved
 expected=json.loads(capture.getvalue());assert actual[name]==expected,(name,actual[name],expected)
 results.append({'case':name,'passed':expected['passed'],'native_matches_original':True})
module=Path('work/constants-recovery/SFT/Materials/JunctionIndependentValidator.lean')
names=re.findall(r'^(?:def|theorem|structure) (\w+)',module.read_text(),re.M)
audit=Path('work/AuditJunctionIndependent.lean')
audit.write_text('import SFT.Materials.JunctionIndependentValidator\n'+''.join('#print axioms SFT.Materials.JunctionIndependentValidator.'+n+'\n' for n in names))
check=subprocess.run(['/Users/dolltrading/.elan/bin/lean',str(audit)],env=dict(os.environ,LEAN_PATH=str(Path('work/constants-recovery/.lake/build/lib/lean').resolve())+':/Volumes/One Touch/SFT v4 Full model LEAN/.lake/build/lib/lean'),capture_output=True,text=True)
Path('work/junction_independent_axioms.log').write_text(check.stdout+check.stderr)
assert check.returncode==0,check.stdout+check.stderr
assert all("'SFT.Materials.JunctionIndependentValidator."+n+"' does not depend on any axioms" in check.stdout for n in names),check.stdout
report={'source_commit':pin,'source_path':prefix+'independent_validator.py','source_sha256':hashlib.sha256(script).hexdigest(),'lean_sha256':hashlib.sha256(module.read_bytes()).hexdigest(),'generated_census_matches_all_256_ordered_source_ids':True,'cases':results,'declarations':names,'axiom_dependencies':[],'scope':'Typed original engine sealed records; not a proof of the junction scientific balance clause.'}
Path('work/junction_independent_check.json').write_text(json.dumps(report,indent=2)+'\n')
print('PASS: ordered 256-source census; all',len(cases),'original/native validator comparisons;',len(names),'declarations with empty axiom dependencies.')
