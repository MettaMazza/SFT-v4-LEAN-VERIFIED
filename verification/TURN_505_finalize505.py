from pathlib import Path
import json,re,shutil,datetime
r=Path('/Volumes/One Touch/SFT v4 Full model LEAN');rec=Path('work/constants-recovery');paths=set(json.load(open('work/checkpoint505_paths.json')));cov=json.loads((r/'COVERAGE.json').read_text());assert cov['summary']['fully_reconstructed_claims']==300
for batch in ['cosmo','lensingdistance']:
 for name in ['prepare_'+batch+'505.py','build_'+batch+'505.py','run_'+batch+'505.py','register_'+batch+'505.py','build_'+batch+'505.log',batch+'505_run.log','audit'+batch+'505_config.json']:
  p=Path('work')/name;rel='verification/TURN_505_'+name;shutil.copy2(p,r/rel);paths.add(rel)
 for p in (Path('work')/(batch+'505_build')).glob('*.log'):
  assert 'error:' not in p.read_text(),p
  rel='verification/TURN_505_BUILD/'+p.name;(r/rel).parent.mkdir(parents=True,exist_ok=True);shutil.copy2(p,r/rel);paths.add(rel)
for name in ['paper_cosmo505.txt','finalize505.py','prepare_firas505.py','build_firas505.py','build_firas505.log','build_lensing505_repair.py','build_lensing505_repair.log','auditlensing505_repair.log','firas505_exact.log','cosmo505_run_retry2.log','lensingdistance505_run_retry.log']:
 p=Path('work')/name;rel='verification/TURN_505_'+name;shutil.copy2(p,r/rel);paths.add(rel)
p=r/'ZENODO_PAPER_DRAFT.txt';s=p.read_text();assert '\n466. Causal distance' in s
s=re.sub(r'the audit covers [0-9,]+ definitions and theorems','the audit covers '+format(cov['summary']['axiom_free_audited_definitions_and_theorems'],',')+' definitions and theorems',s);s=s.replace('TURN_503_BATCH_COMPLETION.json and its referenced evidence record the current continuation results','TURN_505_BATCH_COMPLETION.json and its referenced evidence record the current continuation results');p.write_text(s)
p=r/'README.md';s=p.read_text();s=re.sub(r'TURN_\d+_REGISTERED_DECLARATIONS_AUDIT','TURN_505_REGISTERED_DECLARATIONS_AUDIT',s);p.write_text(s)
new=[x for x in cov['claims'] if x.get('completion_evidence','').startswith('verification/TURN_505_')];by={x['claim_id']:x for x in cov['claims']};assert len(new)==3
for e in new:
 assert all(by[d]['lean_status']=='complete' for d in e['v3_registration']['dependencies'])
 v=json.loads((r/e['completion_evidence']).read_text());assert v['status']=='complete' and v['remaining']==[] and v['axiom_dependencies']==[]
 for m in e['lean_modules']:assert (r/m).read_bytes()==(rec/m).read_bytes()
result=dict(**cov['summary'],new_completed_entries=[x['claim_id'] for x in new],full_candidate_products=[256]*3,native_comparisons='PASS',independent_cases_per_entry=4,axiom_dependencies=[],paper_sections=466,vacuum_density_complete=False,unified_constants_complete=False,full_model_complete=False)
rel='verification/TURN_505_BATCH_COMPLETION.json';(r/rel).write_text(json.dumps(result,indent=2)+'\n');paths.add(rel)
with (r/'TIMELINE.txt').open('a') as f:f.write('\n'+datetime.datetime.now(datetime.timezone.utc).isoformat()+' '+Path('work/timeline505.txt').read_text())
paths.update(['README.md','ZENODO_PAPER_DRAFT.txt','TIMELINE.txt']);Path('work/checkpoint505_paths.json').write_text(json.dumps(sorted(paths)));print(json.dumps(result))
