from pathlib import Path
import json,ast,hashlib
r=Path('/Volumes/One Touch/SFT v4 Full model LEAN');w=Path('work');old='verification/TURN_560_ATOMICNUMBER_COMPLETION.json';new='verification/TURN_560_ISOTOPE_COMPLETION.json';isotope=json.load(open(r/old));assert isotope['claim_id']=='SFT-CHEM-ELEM-ISOTOPE-001';(r/new).write_text(json.dumps(isotope,indent=2)+'\n')
cfg=json.load(open(w/'atomicnumber560_audit_config.json'));cov=json.load(open(r/'COVERAGE.json'));entry=next(e for e in cov['claims'] if e['claim_id']=='SFT-CHEM-ELEM-ATOMIC-NUMBER-001')
tree=ast.parse((w/'register_atomicnumber560.py').read_text());domains=None
for n in tree.body:
 if isinstance(n,ast.Assign) and any(isinstance(t,ast.Name) and t.id=='domains' for t in n.targets):domains=ast.literal_eval(n.value)
assert domains
atomic=dict(isotope);atomic.update(claim_id=entry['claim_id'],source_component_correspondence=domains,lean_source_sha256={m:hashlib.sha256((r/'SFT/Chemistry'/(m+'.lean')).read_bytes()).hexdigest() for m in cfg['modules']},dependencies={d:'complete' for d in entry['v3_registration']['dependencies']},program_report='verification/TURN_560_atomicnumber_program560_report.json',empirical_report='verification/TURN_560_atomicnumber_validation560_report.json',independent_validator_cases=json.load(open(w/'atomicnumber_independent560_report.json')),audited_declarations=cfg['declarations'],added_registered_theorems=cfg['theorems'],added_audited_definitions_and_theorems=cfg['definitions_and_theorems']);(r/old).write_text(json.dumps(atomic,indent=2)+'\n')
for e in cov['claims']:
 if e['claim_id']=='SFT-CHEM-ELEM-ISOTOPE-001':e['completion_evidence']=new
(r/'COVERAGE.json').write_text(json.dumps(cov,indent=2)+'\n')
p=r/'reference/CORRESPONDENCE.json';d=json.load(open(p))
for key in ['modules','evidence_modules']:
 for e in d[key]:
  if e.get('v3_claim')=='SFT-CHEM-ELEM-ISOTOPE-001':e['completion_evidence']=new
p.write_text(json.dumps(d,indent=2)+'\n')
p=r/'CONTINUATION_STATE.json';d=json.load(open(p));d['scientific_cursor']['receipt']=new;p.write_text(json.dumps(d,indent=2)+'\n')
p=r/'README.md';p.write_text(p.read_text().replace('[latest completion evidence]('+old+')','[latest completion evidence]('+new+')'))
p=w/'register_isotope560.py';p.write_text(p.read_text().replace('TURN_560_ATOMICNUMBER_COMPLETION','TURN_560_ISOTOPE_COMPLETION'))
p=w/'checkpoint560_paths.json';paths=set(json.load(open(p)));paths.add(new);p.write_text(json.dumps(sorted(paths)))
with (r/'TIMELINE.txt').open('a') as f:f.write('\nTurn560 metadata correction: the copied Isotope registrar retained AtomicNumber in its completion-receipt filename and overwrote that receipt. Restored AtomicNumber from its actual unchanged module hashes, audit declarations, source mapping, complete comparison reports and independent-validator cases; saved Isotope under its own receipt name and corrected coverage/correspondence/continuation/README links. No proof or verification rerun, no completion-count change.\n')
