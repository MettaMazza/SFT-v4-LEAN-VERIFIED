"""Rebuild and run current Lean, then compare fresh output to pinned V3 artifacts."""
from pathlib import Path
import json,hashlib
from current_checks import PROJECT as p, OUTPUT, source, run, fresh_audit
info,src=source();audit=fresh_audit()
cor=json.loads((p/'reference/CORRESPONDENCE.json').read_text());expected=[]
for m in cor['modules']:
 assert hashlib.sha256((src/m['source_path']).read_bytes()).hexdigest()==m['source_sha256']
 assert hashlib.sha256((p/m['module']).read_bytes()).hexdigest()==m['lean_source_sha256'],m['module']
 base=src/'claims'/m['v3_claim']
 census=json.loads((base/'candidate_census.json').read_text())
 ds={d['candidate_id']:d for d in json.loads((base/'elimination_receipt.json').read_text())['decisions']}
 for c in census['candidates']:
  d=ds[c['candidate_id']]
  expected.append('\t'.join([Path(m['module']).stem,c['candidate_id'],str(d['survives']).lower(),c['exact_form'],d['reason']]))
actual=run('env','lean','--run','Parity.lean')
assert actual.splitlines()==expected,'Fresh Lean candidate identity, decision, exact form or reason differs'
(OUTPUT/'CANDIDATE_PARITY.tsv').write_text(actual)
result={'status':'PASS','source_commit':info['commit'],'candidate_rows_compared':len(expected),'fields':['order','candidate_id','survives','exact_form','reason'],'fresh_build':True,'fresh_lean_execution':True,**audit,'scope':'Root/One/Count/Part/PartEquivalence/Fold/FoldAssembly/ExactOperations/HalfOne registered finite classifications; not full claim completion'}
(OUTPUT/'PARITY_REPORT.json').write_text(json.dumps(result,indent=2)+'\n');print(json.dumps(result,indent=2))
