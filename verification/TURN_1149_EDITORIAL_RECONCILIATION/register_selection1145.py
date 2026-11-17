import fcntl
_registration_lock = open("work/entry_registration.lock", "w")
fcntl.flock(_registration_lock, fcntl.LOCK_EX)
from pathlib import Path
import json,re,hashlib,datetime,shutil
w=Path('work');r=w/'turn1064_recovery';now=datetime.datetime.now(datetime.timezone.utc).isoformat();digest=lambda p:hashlib.sha256(p.read_bytes()).hexdigest()
cid='SFT-CHEM-SELECTION-RULE-STRUCTURE-010';receipt='verification/TURN_1145_SELECTION_COMPLETION.json'
reports=['selection1142_core_source_audit_report.json', 'selection_grammar1142_entry_audit_report.json', 'selection1143_derivation_source_audit_report.json', 'selection1143_observation_source_audit_report.json', 'selection1143_targets_source_audit_report.json', 'selection1143_experiment_source_audit_report.json', 'selection1143_validation_source_audit_report.json', 'selection1142_core_report.json', 'selection1143_program_report.json', 'selection1143_empirical_report.json', 'selection1143_original_report.json', 'selection1143_targets_report.json']
for n in reports:assert json.loads((w/n).read_text())['status']=='PASS',n
independent=json.loads((w/'selection1143_independent_report.json').read_text());assert len(independent)==4 and all(x['result']['passed']==(x['case']=='original')for x in independent)
assert json.loads((w/'selection1143_empirical_output.json').read_text())==json.loads((w/'selection1143_original_empirical.json').read_text())
audit=dict(count=0,declarations=[],source_sha256={})
for n in reports[:7]:
 d=json.loads((w/n).read_text());log=(w/n.replace('_report.json','.log')).read_text()
 assert log.count('does not depend on any axioms')==d['count'] and 'depends on axioms' not in log
 audit['count']+=d['count'];audit['declarations']+=d['declarations']
 for module,h in d['source_sha256'].items():
  rel='SFT/Chemistry/'+module+'.lean';assert digest(r/rel)==h;audit['source_sha256'][rel]=h
assert audit['count']==160 and len(set(audit['declarations']))==160
pin=json.loads((w/'selection1142_source_pin.json').read_text());assert pin['commit']=='76f1b34e9e9682989adcbb088797b4ae4ce4fcf1'
for item in pin['files']:
 b=(w/'pinned1142'/item['path']).read_bytes();assert hashlib.sha1(b'blob '+str(len(b)).encode()+b'\0'+b).hexdigest()==item['git_blob']
core=json.loads((w/'selection1142_core_report.json').read_text());assert digest(w/'pinned1142'/'sft/chemistry'/'selection_rule_law_v1.py')==core['source_sha256'];assert digest(r/'SFT/Chemistry'/'SelectionRule.lean')==core['native_sha256']
cov=json.loads((r/'COVERAGE.json').read_text());by={x['claim_id']:x for x in cov['claims']};entry=by[cid];assert entry['lean_status']=='in_progress';assert len(entry['v3_registration']['dependencies'])==10 and all(by[d]['lean_status']=='complete'for d in entry['v3_registration']['dependencies']);old=cov['summary'].copy()
scopes={'SelectionRule': ('sft/chemistry/selection_rule_law_v1.py', 'Exact four-field state signatures, family guards, ten direct axis pairs, direct count/inversion conditions and original five-class priority; arbitrary mediator payload preserved with no added unresolved-branch guard.'), 'SelectionDerivation': ('sft/chemistry/selection_rule_law_v1.py', 'Source constructor acceptance implies original direct predicate, multiplicity, axis and inversion; direct priority and missing-mediator rejection.'), 'SelectionRuleGrammar': ('sft/chemistry/selection_rule_batch_v1.py', 'Eight original axes including record, all256alternatives, original elimination decisions and exhaustive unique survivor.'), 'SelectionRuleEvidence': ('sft/chemistry/generated_observational_law.py', 'Exact original registration,census,closure,controls and programme hashes.'), 'SelectionObservation': ('sft/chemistry/selection_rule_validation_v1.py', 'Original arrow priority, comma terminals, coupling delimiter, signature lookup, multi-terminal unknown branch, five classifications, six counts and six controls.'), 'SelectionTargets': ('sft/chemistry/selection_rule_validation_v1.py', 'All five original source hashes; all63ordered unique records reconstructed from60transitionrows and46H2signatures, including three adverse notes and exact unresolved values.'), 'SelectionRuleExperiment': ('sft/chemistry/selection_rule_batch_v1.py', 'Original eight-row19instruction value-free prediction, exact registration/specification guards and envelope.'), 'SelectionRuleValidation': ('sft/chemistry/selection_rule_validation_v1.py', 'Original postseal source comparison/custody,63rows,sixcounts,sixcontrols; complete12-field75-message receipt and original custodian identity.')}
oldtheorems=set(re.findall(r'^#print axioms (\S+)',(r/'Audit.lean').read_text(),re.M));newtheorems=[];corr=json.loads((r/'reference/CORRESPONDENCE.json').read_text())
for module,(source,scope)in scopes.items():
 rel='SFT/Chemistry/'+module+'.lean';s=(r/rel).read_text();names=['SFT.Chemistry.'+module+'.'+n for n in re.findall(r'^theorem (\w+)',s,re.M)];newtheorems.extend(n for n in names if n not in oldtheorems)
 corr['modules'].append({'lean_module':rel,'v3_claim':cid,'source_path':source,'lean_source_sha256':audit['source_sha256'][rel],'domain':scope,'remaining':[],'completion_evidence':receipt})
 imp='import '+rel[:-5].replace('/','.')
 if imp not in (r/'SFT.lean').read_text().splitlines():
  with(r/'SFT.lean').open('a')as f:f.write('\n'+imp+'\n')
with(r/'Audit.lean').open('a')as f:f.write(''.join('#print axioms '+n+'\n'for n in newtheorems))
evidence=['selection1142_core_source_audit_report.json', 'selection_grammar1142_entry_audit_report.json', 'selection1143_derivation_source_audit_report.json', 'selection1143_observation_source_audit_report.json', 'selection1143_targets_source_audit_report.json', 'selection1143_experiment_source_audit_report.json', 'selection1143_validation_source_audit_report.json', 'selection1142_core_report.json', 'selection1143_program_report.json', 'selection1143_empirical_report.json', 'selection1143_original_report.json', 'selection1143_targets_report.json', 'selection1143_independent_report.json', 'selection1143_empirical_output.json', 'selection1143_original_empirical.json', 'selection1142_source_pin.json', 'check_selection1143_program.py', 'check_selection1143_empirical.py', 'selection1142_core_source_audit.log', 'selection_grammar1142_entry_audit.log', 'selection1143_derivation_source_audit.log', 'selection1143_observation_source_audit.log', 'selection1143_targets_source_audit.log', 'selection1143_experiment_source_audit.log', 'selection1143_validation_source_audit.log', 'check_selection1143_targets.py', 'SelectionTargetsParity1143.lean', 'SelectionValidationProgram1143.lean', 'selection1143_targets_output.json']
for n in evidence:shutil.copyfile(w/n,r/'verification'/('TURN_1145_'+n))
record={'status':'complete','registered_at':now,'claim_id':cid,'source_commit':pin['commit'],'source_component_correspondence':{m:{'source':p,'component':s}for m,(p,s)in scopes.items()},'lean_source_sha256':audit['source_sha256'],'dependencies':{d:'complete'for d in entry['v3_registration']['dependencies']},'candidate_rows':256,'original_target_rows':63,'iupac_rows':0,'nist_rows':63,'empirical_fields':12,'measurement_messages':75,'original_operational_witnesses':4,'axiom_dependencies':[],'audited_declarations':audit['declarations'],'added_registered_theorems':newtheorems,'remaining':[],'checks':{n:digest(w/n)for n in evidence}}
(r/receipt).write_text(json.dumps(record,indent=2)+'\n')
entry.update(lean_status='complete',remaining=[],lean_modules=list(audit['source_sha256']),completion_evidence=receipt,verified_scope='; '.join(s for _,s in scopes.values()),artifact_runtime_parity='PASS full256candidate programme, original/threeadverse independent cases, full12field75message empirical receipt and all hashes;160empty-axiom declarations; source-specific core comparisons and complete original controls.')
completed=sum(x['lean_status']=='complete'for x in cov['claims']);assert completed==old['fully_reconstructed_claims']+1
cov['summary'].update(fully_reconstructed_claims=completed,pending=sum(x['lean_status']=='pending'for x in cov['claims']),in_progress=sum(x['lean_status']=='in_progress'for x in cov['claims']),axiom_free_exported_results=old['axiom_free_exported_results']+len(newtheorems),axiom_free_audited_definitions_and_theorems=old['axiom_free_audited_definitions_and_theorems']+160);cov['updated_at']=now
(r/'COVERAGE.json').write_text(json.dumps(cov,indent=2)+'\n');corr['audited_theorems']=sorted(set(corr['audited_theorems'])|set(newtheorems));(r/'reference/CORRESPONDENCE.json').write_text(json.dumps(corr,indent=2)+'\n')

oldCandidates = int(re.search(r'([0-9,]+) candidate records matched',(r/'README.md').read_text())[1].replace(',',''))
newCandidates = oldCandidates + record['candidate_rows']
for name in ['README.md','docs/assets/sft-banner.svg','ZENODO_PAPER_DRAFT.txt']:
 p=r/name;t=p.read_text();t=t.replace(f'{oldCandidates:,}',f'{newCandidates:,}')
 for suffix in [' / 2,781',' V3 entries verified',' model entries',' completed entries',' completed source entries',' source entries']:t=t.replace(str(old['fully_reconstructed_claims'])+suffix,str(completed)+suffix)
 for key in ['axiom_free_exported_results','axiom_free_audited_definitions_and_theorems']:t=t.replace(f'{old[key]:,}',f'{cov["summary"][key]:,}')
 t=t.replace(f'{old["pending"]:,} entries remain pending',f'{cov["summary"]["pending"]:,} entries remain pending')
 if name=='README.md':t=re.sub(r'(\[latest completion evidence\]\()[^)]+',lambda m:m.group(1)+receipt,t)
 p.write_text(t)
with(r/'TIMELINE.txt').open('a')as f:f.write('\nTURN1145 registration — '+now+' — '+cid+' complete at '+str(completed)+'. Source pin and current native hashes checked. All 10 prerequisites complete; 160 empty-axiom declarations,256 original programme alternatives, original/three adverse independent cases, full12-field 75-message empirical receipt and all hashes pass. Source-specific core outcomes retained without rerunning unchanged checks.\n')
def append_verified_result(result):
 p=r/'ZENODO_PAPER_DRAFT.txt';text=p.read_text()
 for old,new in {'The entry count will advance when its remaining original grammar, closure and empirical obligations pass.': 'The original grammar, closure and full empirical obligations pass; the entry is registered complete.', 'its full executable comparisons are running.': 'its full executable comparisons pass.'}.items():text=text.replace(old,new)
 match=re.search(r'(?m)^\d+\. '+re.escape('Selection records: constructor soundness and source reconstruction')+r'$',text);assert match
 following=re.search(r'(?m)^\d+(?:\.\d+)*\. ',text[match.end():])
 at=match.end()+following.start() if following else len(text)
 text=text[:at].rstrip()+'\n\n'+result.strip()+'\n\n'+text[at:]
 p.write_text(text)
append_verified_result('\nSelection verification result: the source-specific derivations and original controls described above are registered complete. All 160 audited declarations have empty axiom dependencies; the complete 256-form programme and full twelve-field, 75-message empirical receipt match the original source. The independent validator accepts the original and rejects the three original adverse cases. Original source: pinned sft/chemistry/selection_rule_law_v1.py; native modules and full correspondence: '+receipt+'. Timeline TURN1145.\n')
p=r/'CONTINUATION_STATE.json';state=json.loads(p.read_text());state['selection1145_completion']={'status':'complete','receipt':receipt,'count':completed};state['authorized_action']='750 entries complete. Selection registered from its successful retained receipts; Coordination Number and Maintenance already complete. Do not restart their checks or start entry 751. Prepare the entire cumulative 750 review edition: update paper and index, push and verify completed code, render and inspect final PDF with that code pin, refresh metadata/landing description and complete source/evidence bundle including timeline, verify review edition on GitHub, then pause for author review. No Zenodo publication without explicit approval.'; state['scientific_cursor']={'completed':cid,'next':None,'next_milestone':750,'action':'Prepare complete 750 author-review publication package'};p.write_text(json.dumps(state,indent=2)+'\n');print(json.dumps(cov['summary']))
