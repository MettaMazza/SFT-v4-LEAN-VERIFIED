from pathlib import Path
w=Path('work')
base=(w/'register_coordisomer1474.py').read_text()
common=base[base.index('oldNames=set'):]
common=common.replace("['coordisomer1474_independent_report.json','coordisomer1474_empirical_output.json','coordisomer1474_original_empirical.json','coordisomer1474_program_output.json','coordisomer1474_source_pin.json','coordisomer1474_witness_audit.log','coordisomer1474_derivation_audit.log','coordisomer1474_interfaces_output.json','coordisomer1474_interfaces_expected.json']", "['ligandsplit1475_independent_report.json','ligandsplit1476_empirical_output.json','ligandsplit1475_original_empirical.json','ligandsplit1475_program_output.json','ligandsplit1475_source_pin.json','ligandsplit1476_retention_audit.log','ligandsplit1475_proof_audit.log','ligandsplit1475_interfaces_output.json','ligandsplit1475_interfaces_expected.json','ligandsplit1475_guard_expected.json','ligandsplit1475_guard_output.json']")
common=common.replace('original_target_rows=17','original_target_rows=32').replace('measurement_messages=14','measurement_messages=13').replace('37core/20interface cases and full12field14message','3fullrecord/9constructor/35interface cases and full12field13message')
a=common.index("with(r/'TIMELINE.txt').open('a')");b=common.index('nextId=',a)
common=common[:a]+'''with(r/'TIMELINE.txt').open('a')as f:f.write('\\nTURN1476 registration — '+now+' — Ligand State Splitting complete at1,035. Verified all12 native module hashes,206 empty-axiom declarations,original registered dependencies,full256programme and independent controls,3complete records/9constructor/35interface comparisons and full12field13message empirical result. Updated count,imports,audit and correspondence.\\n')
'''+common[b:]
common=common.replace("s['coordisomer1474']", "s['ligandsplit1474']")
header='''from pathlib import Path
import json,re,hashlib,datetime,shutil,fcntl
w=Path('work');r=w/'turn1064_recovery';H=lambda p:hashlib.sha256(p.read_bytes()).hexdigest()
reports=['ligandsplit1475_core_report.json','ligandsplit1475_guard_report.json','ligandsplit1475_proof_report.json','ligandsplit_grammar1475_entry_audit_report.json','ligandsplit_interfaces1475_entry_audit_report.json','ligandsplit1475_interfaces_comparison_report.json','ligandsplit1476_validation_entry_audit_report.json','ligandsplit1475_program_report.json','ligandsplit1476_empirical_report.json','ligandsplit1475_original_report.json']
names=[];hashes={}
for f in reports:
 d=json.loads((w/f).read_text());assert d['status']=='PASS',f
 for m,h in d.get('source_sha256',{}).items():
  rel=m if m.startswith('SFT/')else 'SFT/Chemistry/'+m+'.lean'
  assert H(r/rel)==h,(f,rel);hashes[rel]=h
 names.extend(d.get('declarations',[]))
s=(w/'ligandsplit1476_retention_audit.log').read_text();retentionNames=re.findall(r"'([^']+)' does not depend on any axioms",s);assert len(retentionNames)==25 and 'depends on axioms:'not in s and 'error:'not in s
names.extend(retentionNames);rel='SFT/Chemistry/LigandStateSplittingRetention.lean';hashes[rel]=H(r/rel)
assert len(names)==len(set(names))==206
for rel in hashes:assert not re.search(r'^\\s*(axiom|opaque)\\s|\\b(sorry|admit)\\b',re.sub(r'"(?:[^"\\\\]|\\\\.)*"|--[^\\n]*','',(r/rel).read_text()),re.M),rel
ind=json.loads((w/'ligandsplit1475_independent_report.json').read_text());assert len(ind)==4 and all(z['result']['passed']==(z['case']=='original')for z in ind)
assert json.loads((w/'ligandsplit1476_empirical_output.json').read_text())==json.loads((w/'ligandsplit1475_original_empirical.json').read_text())
assert json.loads((w/'ligandsplit1475_program_report.json').read_text())['candidates']==256
pin=json.loads((w/'ligandsplit1475_source_pin.json').read_text());assert pin['commit']=='76f1b34e9e9682989adcbb088797b4ae4ce4fcf1'
for row in pin['files']:assert H(w/'pinned_ligandsplit1474'/row['path'])==row['sha256'],row['path']
(w/'ligandsplit1476_full_audit_report.json').write_text(json.dumps(dict(status='PASS',declarations=names,count=len(names),source_sha256=hashes,axiom_dependencies=[]),indent=2)+'\\n');reports+=['ligandsplit1476_full_audit_report.json']
lock=open(w/'entry_registration.lock','w');fcntl.flock(lock,fcntl.LOCK_EX)
now=datetime.datetime.now(datetime.timezone.utc).isoformat();cid='SFT-CHEM-LIGAND-STATE-SPLITTING-006'
c=json.loads((r/'COVERAGE.json').read_text());by={z['claim_id']:z for z in c['claims']};x=by[cid];assert x['lean_status']!='complete';assert all(by[d]['lean_status']=='complete'for d in x['v3_registration']['dependencies']);old=c['summary'].copy();oldCount=old['fully_reconstructed_claims'];assert oldCount==1034;newCount=oldCount+1
receipt='verification/TURN1476_LIGAND_STATE_SPLITTING_COMPLETION.json';dest=r/'verification/TURN1476_LIGAND_STATE_SPLITTING';dest.mkdir(exist_ok=True)
'''
scopes={
'LigandStateSplitting':('sft/chemistry/ligand_state_splitting_law_v1.py','Exact five-support generator;support/geometry/level/splitting guards,complete incidence grouping,normalized separations,complementary balance and removed-interaction construction;3fullsource records and9constructor cases.'),
'LigandStateSplittingDerivation':('sft/chemistry/ligand_state_splitting_batch_v1.py:induction_base/induction_step;ligand_state_splitting_law_v1.py:interaction_rank/forced_ligand_state_splitting','Exact filter incidence,one-word successor and total grouping/sorting cardinality for every input list.'),
'LigandStateSplittingRetention':('sft/chemistry/ligand_state_splitting_law_v1.py:forced_ligand_state_splitting;ligand_state_splitting_batch_v1.py:statement/induction_step','Every selected member multiplicity is preserved;generated members occur once;all level members have their actual incidence;level ranks are distinct;equal incidence iff same generated level.'),
'LigandStateSplittingWitnesses':('sft/chemistry/ligand_state_splitting_law_v1.py:OPERATIONAL_WITNESSES','Six original witnesses,computed from the actual source-bound native operations,and six kernel pass proofs.'),
'LigandStateSplittingGrammar':('sft/chemistry/ligand_state_splitting_law_v1.py:DIMENSIONS;ligand_state_splitting_batch_v1.py:LIGAND_STATE_SPLITTING_SPEC','All eight binary axes,all256candidates,original elimination decisions and unique survivor.'),
'LigandStateSplittingEvidence':('sft/chemistry/generated_observational_law.py:GeneratedObservationalChemistryProgram;ligand_state_splitting_batch_v1.py:LIGAND_STATE_SPLITTING_SPEC','Exact registration,dependencies,closure,four controls and actual original witnesses;fullfreshprogramme comparison and3adverse independent cases.'),
'LigandStateSplittingPrediction':('sft/chemistry/ligand_state_splitting_validation_v1.py:prediction_program_document/_identities','Complete32sourceidentity rows,11-cell words,original value-free identity checks and forbidden-key boundary.'),
'LigandStateSplittingSource':('sft/chemistry/ligand_state_splitting_validation_v1.py:_prediction_map/_source_rows','Complete32row table,six identity bindings,post-seal primary/target byte guards and target payload hashes.'),
'LigandStateSplittingAnalysis':('sft/chemistry/ligand_state_splitting_validation_v1.py:exact_analysis','Actual native five-support partitions,separation/balance vectors,blind spectral maxima/separations,IUPAC boundaries,twoadverse absences and12ancillary rows;35fullinterface cases.'),
'LigandStateSplittingComparison':('sft/chemistry/ligand_state_splitting_validation_v1.py:LigandStateSplittingValidator.validate','Five identity andfive law bindings,exact source passed conjunction and seven original controls.'),
'LigandStateSplittingExperiment':('sft/chemistry/ligand_state_splitting_validation_v1.py:experiment_registration_record','All15originalregistrationfields,32references,sourceidentities andoriginalspecguards.'),
'LigandStateSplittingValidation':('sft/chemistry/ligand_state_splitting_validation_v1.py:LigandStateSplittingValidator.validate','Originalpredictionexecution,pre-source seal,targetcustody,all32comparisons,full12field13message empirical result including exactblind spectrum inscriptions.')}
(w/'register_ligandsplit1476.py').write_text(header+'scopes='+repr(scopes)+'\n'+common)
