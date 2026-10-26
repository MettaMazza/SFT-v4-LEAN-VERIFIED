"""Compare Lean output to pinned V3 artifacts, without importing SFT modules."""
from pathlib import Path
import json,hashlib,subprocess
p=Path(__file__).resolve().parents[1]
srcinfo=json.loads((p/'reference/SOURCE.json').read_text());src=Path(srcinfo['local_source'])
assert subprocess.check_output(['git','-C',str(src),'rev-parse','HEAD'],text=True).strip()==srcinfo['commit']
cor=json.loads((p/'reference/CORRESPONDENCE.json').read_text())
expected=[]
for m in cor['modules']:
 assert hashlib.sha256((src/m['source_path']).read_bytes()).hexdigest()==m['source_sha256']
 base=src/'claims'/m['v3_claim']
 census=json.loads((base/'candidate_census.json').read_text())
 decisions=json.loads((base/'elimination_receipt.json').read_text())['decisions']
 ds={d['candidate_id']:d for d in decisions}
 for c in census['candidates']:
  d=ds[c['candidate_id']]
  expected.append('\t'.join([Path(m['module']).stem,c['candidate_id'],str(d['survives']).lower(),c['exact_form'],d['reason']]))
actual=(p/'verification/TURN_007_CANDIDATE_PARITY.tsv').read_text().splitlines()
assert actual==expected,'Ordered candidate identity, decision, exact form or reason differs'
log=(p/'verification/TURN_007_BUILD.log').read_text()
assert 'Build completed successfully' in log
assert log.count('does not depend on any axioms')==14
assert 'depends on axioms:' not in log
result={'status':'PASS','source_commit':srcinfo['commit'],'candidate_rows_compared':len(expected),'fields':['order','candidate_id','survives','exact_form','reason'],'native_theorems_audited':14,'axiom_dependencies':0,'scope':'Complete registered Root/One/Count finite candidate classifications; not full source-module or full claim completion.'}
(p/'verification/TURN_007_PARITY_REPORT.json').write_text(json.dumps(result,indent=2)+'\n')
print(json.dumps(result,indent=2))
