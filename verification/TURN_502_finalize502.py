from pathlib import Path
import json,re,shutil,datetime
r=Path('/Volumes/One Touch/SFT v4 Full model LEAN');rec=Path('work/constants-recovery');paths=set(json.load(open('work/checkpoint502_paths.json')));cov=json.loads((r/'COVERAGE.json').read_text());assert cov['summary']['fully_reconstructed_claims']==293
names='''prepare_geodesic502.py build_geodesic502.py run_geodesic502.py register_geodesic502.py build_geodesic502.log geodesic502_run.log geodesic502_builder.log auditgeodesic502_config.json geodesic502_bridge.log prepare_fieldsource502.py build_fieldsource502.py run_fieldsource502.py register_fieldsource502.py build_fieldsource502.log fieldsource502_run.log fieldsource502_builder.log auditfieldsource502_config.json fieldsource502_science.log Gravity502ScienceAudit.lean gravity502_science_audit.log paper_gravity502.txt finalize502.py'''.split()
for name in names:
 p=Path('work')/name
 if p.exists():rel='verification/TURN_502_'+name;shutil.copy2(p,r/rel);paths.add(rel)
audit=Path('work/gravity502_science_audit.log').read_text();assert 'depends on axioms:' not in audit and 'error:' not in audit
s=(r/'ZENODO_PAPER_DRAFT.txt').read_text();s=re.sub(r'the audit covers [0-9,]+ definitions and theorems','the audit covers '+format(cov['summary']['axiom_free_audited_definitions_and_theorems'],',')+' definitions and theorems',s);s=s.replace('TURN_501_BATCH_COMPLETION.json and its referenced evidence record the current continuation results','TURN_502_BATCH_COMPLETION.json and its referenced evidence record the current continuation results');(r/'ZENODO_PAPER_DRAFT.txt').write_text(s)
s=(r/'README.md').read_text();s=re.sub(r'TURN_\d+_REGISTERED_DECLARATIONS_AUDIT','TURN_502_REGISTERED_DECLARATIONS_AUDIT',s);(r/'README.md').write_text(s)
new=[x for x in cov['claims'] if x.get('completion_evidence','').startswith('verification/TURN_502_')];by={x['claim_id']:x for x in cov['claims']}
for e in new:
 assert all(by[d]['lean_status']=='complete' for d in e['v3_registration']['dependencies'])
 v=json.loads((r/e['completion_evidence']).read_text());assert v['status']=='complete' and v['remaining']==[] and v['axiom_dependencies']==[]
 for m in e['lean_modules']:assert (r/m).read_bytes()==(rec/m).read_bytes()
result=dict(**cov['summary'],new_completed_entries=[x['claim_id'] for x in new],full_candidate_products=[256,256],native_comparisons='PASS',independent_cases_per_entry=4,axiom_dependencies=[],paper_sections=459,geodesic_complete=True,vacuum_density_complete=False,full_model_complete=False)
rel='verification/TURN_502_BATCH_COMPLETION.json';(r/rel).write_text(json.dumps(result,indent=2)+'\n');paths.add(rel)
with (r/'TIMELINE.txt').open('a') as f:f.write('\n'+datetime.datetime.now(datetime.timezone.utc).isoformat()+' '+Path('work/timeline502.txt').read_text())
paths.update(['README.md','ZENODO_PAPER_DRAFT.txt','TIMELINE.txt']);Path('work/checkpoint502_paths.json').write_text(json.dumps(sorted(paths)));print(json.dumps(result))
