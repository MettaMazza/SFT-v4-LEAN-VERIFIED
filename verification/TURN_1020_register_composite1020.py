from pathlib import Path
import json,re,hashlib,datetime,shutil,sys
r=Path('/Volumes/One Touch/SFT v4 Full model LEAN');w=Path('work');cid='SFT-PHYS-COMPOSITE-CONFINING-SECTOR-TERMINAL-031';receipt='verification/TURN_1020_COMPOSITE_CONFINING_COMPLETION.json';now=datetime.datetime.now(datetime.timezone.utc).isoformat();prefix='composite1020';cfg=json.load(open(w/'composite1020_proofs_config.json'));audit=(w/'composite1020_audit.log').read_text()
assert all("'"+n+"' does not depend on any axioms" in audit for n in cfg['declarations'])
for m,h in cfg['source_sha256'].items():assert hashlib.sha256((r/f'SFT/Physics/{m}.lean').read_bytes()).hexdigest()==h
for f in ['composite1019_program_report.json','composite1019_fresh_report.json']:assert json.load(open(w/f))['status']=='PASS'
cases=json.load(open(w/'composite_independent1019_report.json'));assert len(cases)==4 and all(x['expected']==x['actual']['passed'] for x in cases)
checks=['composite_confining1013_core_report.json','composite_confining1013_derivation_report.json','composite_confining1017_core_report.json','composite1017_complements_report.json','composite1018_return_report.json','composite1018_return_comparison.json','composite1018_pairs_report.json','composite1018_binding_report.json','composite1018_grammar_report.json','composite1018_grammar_comparison.json','composite1018_witness_comparison.json','composite1019_loop_report.json','composite1020_partition_report.json','composite1020_pairs_report.json','composite1019_entry_report.json']
for f in checks:assert json.load(open(w/f))['status']=='PASS'
cov=json.load(open(r/'COVERAGE.json'));by={x['claim_id']:x for x in cov['claims']};entry=by[cid];assert entry['lean_status']=='pending';assert all(by[d]['lean_status']=='complete' for d in entry['v3_registration']['dependencies']);state=json.load(open(r/'CONTINUATION_STATE.json'))
scopes={
'CompositeConfining':'Original held denominator,complete labels/exact modes,guardedforward/inverse Fold,antipodal pairs andholding coupling; all original inputguards.',
'CompositeConfiningDerivation':'General half-successor inverse,bijection,confinement andinjectivity on the complete original standing support.',
'CompositeConfiningOrbits':'Exact tagged first-return orbit,least-remaining-label partition,all14certificatefields andfive-sector census.',
'CompositeConfiningComplements':'Original positive complement,reassembly,uniqueness,involution andodd-support exclusion ofself-pairs.',
'CompositeConfiningReturn':'General original iteration,first return withind-1,unrestricted-label coverage/disjointcycles andfirst-cycle uniqueness/cardinality.',
'CompositeConfiningPairCount':'Original pair generator cardinality,exact(d-1)/2=(s-2)/2 formula andnext-even-sector successor.',
'CompositeConfiningPairCoverage':'Every original standing label occurs in the generated lower-half complement-pair census.',
'CompositeConfiningBinding':'Exact original support guard andguardedFold operation bound to thegeneral arithmetic derivation.',
'CompositeConfiningLoop':'Exported orbitFromLabel completes with exact first-return row,Boolean/inttag preservation andnontruncating derivedsupportbudget.',
'CompositeConfiningPartition':'Exact orbit membership/remaining-set closure,original removal andpartition-loop termination withinthe remaininglabelcount.',
'CompositeConfiningWitnesses':'Allseven actual original operationalwitness predicates andkernelproofs.',
'CompositeConfiningAcceptanceCount':'Source-equivalent constructorcriterion count retains all2048candidates andproves theoriginal fullsurvivor count.',
'CompositeConfiningControls':'Allfour original false-premise,source-identity,artifact andboundarycontrols withoriginalconditions andhashes.',
'CompositeConfiningEvidence':'Entire original StructuralPhysicsProgram registration,census,decisions,closure/hashes andunknownID behavior;FORMAL andbothoriginalprovenancevalues.'}

paths=set();corr=json.load(open(r/'reference/CORRESPONDENCE.json'));oldth=set(re.findall(r'^#print axioms (\S+)',(r/'Audit.lean').read_text(),re.M));newth=[n for n in cfg['theorems'] if n not in oldth];readme=(r/'README.md').read_text();oldlog=re.search(r'verification/TURN_\w+_REGISTERED_DECLARATIONS_AUDIT\.log',readme)[0];old_audit=(r/oldlog).read_text();olddefs=set(re.findall("'([^']+)' does not depend on any axioms",old_audit));newdefs=[n for n in cfg['definitions_and_theorems'] if n not in olddefs];newlog='verification/TURN_1020_REGISTERED_DECLARATIONS_AUDIT.log';(r/newlog).write_text(old_audit+'\n'+audit);paths.add(newlog)
source_map={};hashes={}
for mod in cfg['modules']:
 rel='SFT/Physics/'+mod+'.lean';p=r/rel;body=p.read_text();assert not re.search(r'\bsorry\b|^\s*axiom\b',body,re.M);hashes[mod]=hashlib.sha256(p.read_bytes()).hexdigest();paths.add(rel)
 if mod in scopes:scope=scopes[mod]
 else:scope='All11originalbinaryaxes,complete2048alternatives,originalorder/reasons andunique source survivor; originalcensus proofchunk whereapplicable.'
 source='sft/physics/structural_constants.py' if mod.endswith(('Controls','Evidence')) else 'sft/physics/composite_confining_sector_terminal_law_v1.py';source_map[mod]={'source':source,'component':scope}; imp='import '+rel[:-5].replace('/','.')
 if imp not in (r/'SFT.lean').read_text().splitlines():
  with (r/'SFT.lean').open('a') as f:f.write('\n'+imp+'\n')
 corr['modules' if 'Grammar' in mod or 'Census' in mod else 'evidence_modules'].append(dict(module=rel,v3_claim=cid,source_path=source,lean_source_sha256=hashes[mod],domain=scope,remaining=[],completion_evidence=receipt))
with (r/'Audit.lean').open('a') as f:f.write(''.join('#print axioms '+n+'\n' for n in newth))
files=[prefix+'_proofs_config.json',prefix+'_audit.log','composite1019_program_report.json','composite1019_program_output.json','composite1019_fresh_report.json','composite_independent1019_report.json']+checks
for name in files:
 rel='verification/TURN_1020_'+name;shutil.copy2(w/name,r/rel);paths.add(rel)
report=dict(status='complete',registered_at=now,claim_id=cid,source_commit=cov['source_commit'],source_component_correspondence=source_map,lean_source_sha256=hashes,dependencies={d:'complete' for d in entry['v3_registration']['dependencies']},candidate_rows=2048,axiom_dependencies=[],audited_declarations=cfg['declarations'],added_registered_theorems=newth,added_audited_definitions_and_theorems=newdefs,remaining=[],empirical_validator=None,source_registration_status=entry['v3_registration'].get('status'),source_supersession=entry['v3_registration'].get('superseded_by'),shared_grammar='SFT.Physics.CompositeConfiningGrammar',program_report='verification/TURN_1020_'+'composite1019_program_report.json',independent_validator_cases=cases,checks_executed=['lake build source-specific CompositeConfiningEvidence,Partition andPairCoverage targets','Source-specific full native2048programme versus pinned records and fresh original Python','Original independent validator unchanged and three adverse cases','All exported entry declarations axiom audit','Retained source-hash-bound original held-label/orbit/certificate comparisons'])
(r/receipt).write_text(json.dumps(report,indent=2)+'\n');paths.add(receipt)
entry.update(lean_status='complete',remaining=[],lean_modules=['SFT/Physics/'+m+'.lean' for m in cfg['modules']],completion_evidence=receipt,verified_scope='; '.join(v['component'] for v in source_map.values()),artifact_runtime_parity='PASS complete2048native programme=freshV3=pinnedrecords; original independent validator and three adverse cases; all source-bound operation checks retained; original source registration and supersession unchanged.')
old=cov['summary'].copy();count=old['fully_reconstructed_claims']+1;cov['summary'].update(fully_reconstructed_claims=count,pending=old['pending']-1,axiom_free_exported_results=old['axiom_free_exported_results']+len(newth),axiom_free_audited_definitions_and_theorems=old['axiom_free_audited_definitions_and_theorems']+len(newdefs));cov['updated_at']=now;assert count==sum(x['lean_status']=='complete' for x in cov['claims']);(r/'COVERAGE.json').write_text(json.dumps(cov,indent=2)+'\n');corr['audited_theorems']=sorted(set(corr['audited_theorems'])|set(newth));(r/'reference/CORRESPONDENCE.json').write_text(json.dumps(corr,indent=2)+'\n')
oldrows=int(re.search(r'([0-9,]+) candidate records matched',readme)[1].replace(',',''))
for name in ['README.md','docs/assets/sft-banner.svg','ZENODO_PAPER_DRAFT.txt']:
 p=r/name;s=p.read_text()
 for tail in [' / 2,781',' V3 entries verified',' model entries',' completed entries',' completed source entries',' source entries']:s=s.replace(str(count-1)+tail,str(count)+tail)
 for field in ['axiom_free_exported_results','axiom_free_audited_definitions_and_theorems']:s=s.replace(f"{old[field]:,}",f"{cov['summary'][field]:,}")
 s=s.replace(f'{oldrows:,}',f'{oldrows+2048:,}').replace(f"{old['pending']:,} entries remain pending",f"{cov['summary']['pending']:,} entries remain pending")
 if name=='README.md':s=re.sub(r'(\[latest completion evidence\]\()[^)]+',lambda m:m.group(1)+receipt,s).replace(oldlog,newlog)
 if name=='ZENODO_PAPER_DRAFT.txt':
  s+=f'\nThe composite confining-sector entry is registered complete as source entry {count}. Its {len(cfg["declarations"])} audited declarations have empty axiom dependencies. The complete 2,048-candidate native programme agrees with fresh original execution and pinned records; the original independent validator accepts it and rejects all three retained adverse cases. Source correspondence and completion evidence: {receipt}.\n'

 p.write_text(s);paths.add(name)
status='verification/TURN_377_NATIVE_BATCH/BATCH_STATUS.json';b=json.load(open(r/status));b['completed_entries']=count;(r/status).write_text(json.dumps(b,indent=2)+'\n');paths.add(status)
with (r/'TIMELINE.txt').open('a') as f:f.write(f'\n{now} — TURN1020 registered {cid} as entry {count}: complete2048programme, fresh original, pinned outputs, original independent validator/three adversecases, {len(cfg["declarations"])} empty-axiom declarations. Reused unchanged source-bound operation evidence; original source status preserved. Updated count, source correspondence and manuscript immediately. Receipt {receipt}.\n')
state=json.load(open(r/'CONTINUATION_STATE.json'));done={x['claim_id'] for x in cov['claims'] if x['lean_status']=='complete'};nextentry=next(x['claim_id'] for x in cov['claims'] if x['claim_id'] not in done and set(x['v3_registration']['dependencies'])<=done);state['scientific_cursor']={'completed':cid,'next':nextentry,'receipt':receipt,'source':'claims/'+nextentry+'/execution.py','next_milestone':750};state['authorized_action']='Continue '+nextentry+' in dependency order toward750;reuse source-bound verified work;prepare complete cumulative publication review package at750,thenpause.';state[prefix]={'status':'complete','receipt':receipt,'remaining':[]};(r/'CONTINUATION_STATE.json').write_text(json.dumps(state,indent=2)+'\n');paths.update(['SFT.lean','Audit.lean','COVERAGE.json','reference/CORRESPONDENCE.json','TIMELINE.txt','CONTINUATION_STATE.json']);(w/'checkpoint1020completion_paths.json').write_text(json.dumps(sorted(paths)));print(json.dumps(cov['summary']));print('NEXT',nextentry)
