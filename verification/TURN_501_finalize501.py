from pathlib import Path
import json,re,shutil,datetime
r=Path('/Volumes/One Touch/SFT v4 Full model LEAN');rec=Path('work/constants-recovery');paths=set(json.load(open('work/checkpoint501_paths.json')));cov=json.loads((r/'COVERAGE.json').read_text());assert cov['summary']['fully_reconstructed_claims']==291
names='''prepare_gravity501.py build_gravity501.py run_gravity501.py register_gravity501.py build_gravity501.log gravity501_run.log gravity501_builder.log auditgravity501_config.json Gravity501ScienceAudit.lean gravity501_science_audit.log SpacetimeLengthRelation501_science.log GravityEquivalence501_science.log GravityCurvature501_science.log geodesic501_science.log paper_gravity501.txt paper_geodesic501.txt finalize501.py'''.split()
for name in names:
 p=Path('work')/name
 if p.exists():rel='verification/TURN_501_'+name;shutil.copy2(p,r/rel);paths.add(rel)
rel='verification/TURN_501_STAGED/SFT/Physics/GravityGeodesic.lean';(r/rel).parent.mkdir(parents=True,exist_ok=True);shutil.copy2(rec/'SFT/Physics/GravityGeodesic.lean',r/rel);paths.add(rel)
audit=Path('work/gravity501_science_audit.log').read_text();assert 'depends on axioms:' not in audit and 'error:' not in audit
for n in re.findall(r'^(?:def|theorem|structure|inductive) (\w+)',(rec/'SFT/Physics/GravityGeodesic.lean').read_text(),re.M):assert "'SFT.Physics.GravityGeodesic."+n+"' does not depend on any axioms" in audit,n
s=(r/'ZENODO_PAPER_DRAFT.txt').read_text();s=re.sub(r'the audit covers [0-9,]+ definitions and theorems','the audit covers '+format(cov['summary']['axiom_free_audited_definitions_and_theorems'],',')+' definitions and theorems',s);s=s.replace('TURN_500_BATCH_COMPLETION.json and its referenced evidence record the current continuation results','TURN_501_BATCH_COMPLETION.json and its referenced evidence record the current continuation results');(r/'ZENODO_PAPER_DRAFT.txt').write_text(s)
s=(r/'README.md').read_text();s=re.sub(r'TURN_\d+_REGISTERED_DECLARATIONS_AUDIT','TURN_501_REGISTERED_DECLARATIONS_AUDIT',s);(r/'README.md').write_text(s)
new=[x for x in cov['claims'] if x.get('completion_evidence','').startswith('verification/TURN_501_')];by={x['claim_id']:x for x in cov['claims']}
for e in new:
 assert all(by[d]['lean_status']=='complete' for d in e['v3_registration']['dependencies'])
 v=json.loads((r/e['completion_evidence']).read_text());assert v['status']=='complete' and v['remaining']==[] and v['axiom_dependencies']==[]
 for m in e['lean_modules']:assert (r/m).read_bytes()==(rec/m).read_bytes()
result=dict(**cov['summary'],new_completed_entries=[x['claim_id'] for x in new],full_candidate_products=[256,256,256],native_comparisons='PASS',independent_cases_per_entry=4,axiom_dependencies=[],paper_sections=457,geodesic_complete=False,vacuum_density_complete=False,full_model_complete=False)
rel='verification/TURN_501_BATCH_COMPLETION.json';(r/rel).write_text(json.dumps(result,indent=2)+'\n');paths.add(rel)
with (r/'TIMELINE.txt').open('a') as f:f.write('\n'+datetime.datetime.now(datetime.timezone.utc).isoformat()+' '+Path('work/timeline501.txt').read_text())
paths.update(['README.md','ZENODO_PAPER_DRAFT.txt','TIMELINE.txt']);Path('work/checkpoint501_paths.json').write_text(json.dumps(sorted(paths)));print(json.dumps(result))
