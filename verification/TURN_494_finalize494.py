from pathlib import Path
import json,re,shutil,datetime,subprocess
r=Path('/Volumes/One Touch/SFT v4 Full model LEAN');rec=Path('work/constants-recovery');c=json.loads((r/'COVERAGE.json').read_text());groups={'matter':json.load(open('work/matter494_all_entries.json'))};entries=[(family,*e) for family,es in groups.items() for e in es];by={e['claim_id']:e for e in c['claims']};paths=set(json.load(open('work/checkpoint494_paths.json')))
assert c['summary']['fully_reconstructed_claims']==267 and len(entries)==6
for family,stem,key,component in entries:
 e=by['SFT-PHYS-'+family.upper()+'-'+key.replace('_','-')+'-001'];assert e['lean_status']=='complete' and not e['remaining'];assert all(by[d]['lean_status']=='complete' for d in e['v3_registration']['dependencies'])
 for part in ['program','validation']:assert json.load(open('work/'+stem.lower()+'_'+part+'494_report.json'))['status']=='PASS'
 cases=json.load(open('work/'+stem.lower()+'_independent494_report.json'));assert len(cases)==4 and all(x['actual']['passed']==x['expected'] for x in cases)
 for rel in e['lean_modules']:assert (r/rel).read_bytes()==(rec/rel).read_bytes(),rel
for log in ['build_matter494.log','build_exchange_spin494.log','build_matter494_remaining.log']:assert 'Build completed successfully' in Path('work/'+log).read_text()
names=['prepare_matter494.py','prepare_matter494.log','build_matter494.py','build_matter494.log','build_matter494_coordinator.log','prepare_matter494_tail.py','prepare_matter494_tail.log','prepare_matter494_last.py','prepare_matter494_last.log','build_matter494_tail.py','build_matter494_tail.log','build_matter494_remaining.py','build_matter494_remaining.log','build_matter494_remaining_coordinator.log','run_matter494_remaining.py','matter494_remaining_run.log','build_exchange_spin494.log','build_spectrum494.log','build_hadrons494.log','build_scattering494.log','build_decay494.log','MatterTail494Audit.lean','matter494_tail_audit.log','matter494_all_entries.json','matter494_remaining_entries.json','matter494_tail_metadata.json','matter494_last_metadata.json','finalize494.py']
for family in groups:
 names += [f'prepare_{family}494.py',f'prepare_{family}494.log',f'build_{family}494.py',f'build_{family}494.log',f'build_{family}494_coordinator.log',f'run_{family}494.py',f'{family}494_run.log',f'register_{family}494.py',f'{family}494_entries.json',f'{family}494_metadata.json',f'{family}494_scopes.json',f'audit{family}494_config.json']
for name in names:
 p=Path('work')/name
 if p.exists():rel='verification/TURN_494_'+name;shutil.copy2(p,r/rel);paths.add(rel)
for family in groups:
 for p in Path('work/'+family+'494_source').iterdir():
  rel='verification/TURN_494_SOURCE/'+p.name;(r/rel).parent.mkdir(exist_ok=True);shutil.copy2(p,r/rel);paths.add(rel)
for source in ['sft/physics/matter_nuclear_laws.py','sft/physics/generated_empirical_law.py']:
 rel='verification/TURN_494_SOURCE/'+Path(source).name;(r/rel).write_bytes(subprocess.check_output(['git','-C','/Volumes/One Touch/ernos-labs-sft-platform','show',c['source_commit']+':'+source]));paths.add(rel)
for _,stem,_,_ in entries:
 for part in ['spec','grammar','evidence','experiment']:
  p=Path('work')/(stem.lower()+'_'+part+'494.py');rel='verification/TURN_494_'+p.name;shutil.copy2(p,r/rel);paths.add(rel)
nextmods=[]
audit=Path('work/matter494_tail_audit.log').read_text();assert 'depends on axioms:' not in audit and 'error' not in audit
nextcount=0
total=c['summary']['fully_reconstructed_claims'];ths=c['summary']['axiom_free_exported_results'];defs=c['summary']['axiom_free_audited_definitions_and_theorems'];rows=89446+6*256
assert ths==len(set(re.findall(r'^#print axioms (\S+)',(r/'Audit.lean').read_text(),re.M)))
assert defs==len(set(re.findall("'([^']+)' does not depend on any axioms",(r/'verification/TURN_494_REGISTERED_DECLARATIONS_AUDIT.log').read_text())))
p=r/'ZENODO_PAPER_DRAFT.txt';s=p.read_text();assert '\n426.' not in s
s=re.sub(r'The accompanying formalisation contains [0-9,]+ audited theorems; the audit covers [0-9,]+ definitions and theorems and reports zero axiom dependencies\.',f'The accompanying formalisation contains {ths:,} audited theorems; the audit covers {defs:,} definitions and theorems and reports zero axiom dependencies.',s)
s=re.sub(r'The registered formalisation contains [^\n]+',f'The registered formalisation contains {total} completed entries out of 2,781, with {ths:,} audited theorems and {defs:,} audited definitions and theorems, all with zero axiom dependencies. Registered candidate comparisons cover {rows:,} records across {total} completed entries. Terminal Planck has a separately verified 1,024-form native comparison and original independent-validator checks; its nuclear-coupling dependency remains incomplete.',s,count=1)
s=s.replace('TURN_493_BATCH_COMPLETION.json and its referenced evidence record the current continuation results.','TURN_494_BATCH_COMPLETION.json and its referenced evidence record the current continuation results.');s+=Path('work/paper494_addition.txt').read_text();assert re.findall(r'^(\d+)\. ',s,re.M)==list(map(str,range(1,432)));p.write_text(s)
p=r/'README.md';s=p.read_text();s=re.sub(r'TURN_\d+_REGISTERED_DECLARATIONS_AUDIT.log','TURN_494_REGISTERED_DECLARATIONS_AUDIT.log',s);s=s.replace('1 entries are in progress','1 entry is in progress');s=re.sub(r'(Current registered comparisons cover \*\*[0-9,]+ candidate records across )\d+( source entries)',lambda m:m[1]+str(total)+m[2],s);s=s.replace('Complete physical quantum chain, mass-energy correspondence and particle-antiparticle reversal verified.','Matter through exchange, conserved labels, particle spectrum, hadrons, scattering and decay verified.');p.write_text(s)
summary=dict(source_commit=c['source_commit'],completed_entries=total,in_progress=c['summary']['in_progress'],registered_theorems=ths,audited_definitions_and_theorems=defs,registered_candidate_rows=rows,new_completed_entries=6,scientific_component_audits=sum(len([n for n in v["declarations"] if any(n.startswith("SFT.Physics."+m+".") for m in [entry[2] for entry in groups["matter"]]+["MatterExchangeSpin"])]) for v in json.load(open("work/auditmatter494_config.json")).values()),axiom_dependencies=[],remaining_for_completed_entries=[],staged_next_components=nextmods,staged_next_audited_declarations=nextcount,full_model_complete=False);rel='verification/TURN_494_BATCH_COMPLETION.json';(r/rel).write_text(json.dumps(summary,indent=2)+'\n');paths.add(rel)
with (r/'TIMELINE.txt').open('a') as f:f.write('\n'+datetime.datetime.now(datetime.timezone.utc).isoformat()+Path('work/timeline494_addition.txt').read_text()+f'\nFinal totals {total}/2781 completed, {ths} registered theorems, {defs} audited definitions/theorems, {rows} candidate records and 431 numbered manuscript sections. Next freeze, push and verify this six-entry checkpoint; continue MIXING then the original nuclear entries toward Unified Constants. No milestone reached. No Zenodo publication.\n')
paths.update(['README.md','ZENODO_PAPER_DRAFT.txt','TIMELINE.txt','COVERAGE.json','reference/CORRESPONDENCE.json']);Path('work/checkpoint494_paths.json').write_text(json.dumps(sorted(paths)));print(json.dumps(summary,indent=2))
