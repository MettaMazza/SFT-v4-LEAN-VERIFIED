import fcntl
_registration_lock = open("work/entry_registration.lock", "w")
fcntl.flock(_registration_lock, fcntl.LOCK_EX)
from pathlib import Path
import json,hashlib,re,shutil,datetime
w=Path('work');r=w/'turn1064_recovery';cid='SFT-BIO-LIFE-MAINTENANCE-001';now=datetime.datetime.now(datetime.timezone.utc).isoformat();H=lambda p:hashlib.sha256(p.read_bytes()).hexdigest()
reports=['maintenance1144_full_audit_report.json','maintenance1144_program_report.json','maintenance1144_empirical_report.json','maintenance1144_original_report.json','maintenance1144_reused_source_evidence.json']
for n in reports:assert json.loads((w/n).read_text())['status']=='PASS',n
cases=json.loads((w/'maintenance1144_independent_report.json').read_text());assert len(cases)==4 and all(x['result']['passed']==(x['case']=='original')for x in cases)
assert json.loads((w/'maintenance1144_empirical_output.json').read_text())==json.loads((w/'maintenance1144_original_empirical.json').read_text())
audit=json.loads((w/'maintenance1144_full_audit_report.json').read_text());assert audit['count']==116
for rel,h in audit['source_sha256'].items():assert H(r/rel)==h
log=(w/'maintenance1144_full_audit.log').read_text();assert log.count('does not depend on any axioms')==116 and 'depends on axioms'not in log
pin=json.loads((w/'maintenance1144_source_pin.json').read_text());assert pin['commit']=='76f1b34e9e9682989adcbb088797b4ae4ce4fcf1'
for item in pin['files']:
 p=Path(item['raw_git_copy'])if 'raw_git_copy'in item else w/'pinned1144'/item['path'];b=p.read_bytes();assert hashlib.sha1(b'blob '+str(len(b)).encode()+b'\0'+b).hexdigest()==item['git_blob']
 if 'registered_execution_sha256'in item:assert H(w/'pinned1144'/item['path'])==item['registered_execution_sha256'].removeprefix('sha256:')
mods={'LifeMaintenance':('sft/biology/obligations.py','Original claim and carrier,damage/restoration relation,retained-identity organization and observation fields;allthree operational witnesses from derivation.py.'),'LifeMaintenanceGrammar':('sft/biology/derivation.py','All eight original binary dimensions,256forms,exact decisions,exhaustion,uniqueness and exclusions.'),'LifeMaintenanceEvidence':('sft/biology/generated_law.py','Original registration,census,closure,controls,programme methods and complete returned hashes.'),'LifeMaintenanceSource':('sft/biology/sources.py','Exact two source requirements,registered snapshots and label binding;sourceReuse connect unchanged shared extraction without a replacement target.'),'LifeMaintenanceExperiment':('sft/biology/generated_law.py','Original experiment registration,prediction document,three witnesses and fixed target identity.'),'LifeMaintenanceValidation':('sft/biology/generated_law.py','Original source/75claim seal gate,postseal custody,adverse comparison,source-derived label and full twelve-field empirical receipt.')}
cov=json.loads((r/'COVERAGE.json').read_text());by={x['claim_id']:x for x in cov['claims']};entry=by[cid];assert entry['lean_status']=='pending';assert all(by[x]['lean_status']=='complete'for x in entry['v3_registration']['dependencies']);assert len(entry['v3_registration']['dependencies'])==19
old=cov['summary'].copy();receipt='verification/TURN_1145_MAINTENANCE_COMPLETION.json';corr=json.loads((r/'reference/CORRESPONDENCE.json').read_text());oldnames=set(re.findall(r'^#print axioms (\S+)',(r/'Audit.lean').read_text(),re.M));newnames=[];hashes={}
for mod,(src,scope)in mods.items():
 rel='SFT/Biology/'+mod+'.lean';hashes[rel]=H(r/rel);names=['SFT.Biology.'+mod+'.'+x for x in re.findall(r'^theorem (\w+)',(r/rel).read_text(),re.M)];newnames.extend(x for x in names if x not in oldnames)
 corr['modules'].append({'lean_module':rel,'v3_claim':cid,'source_path':src,'lean_source_sha256':hashes[rel],'domain':scope,'remaining':[],'completion_evidence':receipt})
 imp='import '+rel[:-5].replace('/','.')
 if imp not in (r/'SFT.lean').read_text().splitlines():
  with(r/'SFT.lean').open('a')as f:f.write('\n'+imp+'\n')
with(r/'Audit.lean').open('a')as f:f.write(''.join('#print axioms '+x+'\n'for x in newnames))
evidence=reports+['maintenance1144_external_input_receipt.json','maintenance1144_independent_report.json','maintenance1144_empirical_output.json','maintenance1144_original_empirical.json','maintenance1144_source_pin.json','check_maintenance1144_program.py','check_maintenance1144_empirical.py','prepare_maintenance1144_empirical.py']
for n in evidence:shutil.copy2(w/n,r/'verification'/('TURN_1145_'+n))
record={'status':'complete','claim_id':cid,'registered_at':now,'source_commit':'76f1b34e9e9682989adcbb088797b4ae4ce4fcf1','lean_source_sha256':hashes,'source_component_correspondence':{m:{'source':p,'component':s}for m,(p,s)in mods.items()},'candidate_rows':256,'original_witnesses':3,'audited_declarations':116,'axiom_dependencies':[],'dependencies':entry['v3_registration']['dependencies'],'source_extraction_reuse':'See maintenance1144_reused_source_evidence.json; unchanged original registered bytes and previously verified extraction, exact prior Biology source/seal proof reuse.','checks':{n:H(w/n)for n in evidence},'remaining':[]};(r/receipt).write_text(json.dumps(record,indent=2)+'\n')
entry.update(lean_status='complete',remaining=[],lean_modules=list(hashes),completion_evidence=receipt,verified_scope='; '.join(v[1]for v in mods.values()),artifact_runtime_parity='PASS complete256programme,three independent adverse cases,twelve-field empiricalreceipt/allhashes,116empty-axiom declarations,three original operational witnesses.')
count=sum(x['lean_status']=='complete'for x in cov['claims']);assert count==old['fully_reconstructed_claims']+1
cov['summary'].update(fully_reconstructed_claims=count,pending=sum(x['lean_status']=='pending'for x in cov['claims']),in_progress=sum(x['lean_status']=='in_progress'for x in cov['claims']),axiom_free_exported_results=old['axiom_free_exported_results']+len(newnames),axiom_free_audited_definitions_and_theorems=old['axiom_free_audited_definitions_and_theorems']+116);cov['updated_at']=now;(r/'COVERAGE.json').write_text(json.dumps(cov,indent=2)+'\n');corr['audited_theorems']=sorted(set(corr['audited_theorems'])|set(newnames));(r/'reference/CORRESPONDENCE.json').write_text(json.dumps(corr,indent=2)+'\n')
candidates=int(re.search(r'([0-9,]+) candidate records matched',(r/'README.md').read_text())[1].replace(',',''))
for fn in ['README.md','docs/assets/sft-banner.svg','ZENODO_PAPER_DRAFT.txt']:
 p=r/fn;s=p.read_text().replace(f'{candidates:,}',f'{candidates+256:,}')
 for suffix in [' / 2,781',' V3 entries verified',' model entries',' completed entries',' completed source entries',' source entries']:s=s.replace(str(old['fully_reconstructed_claims'])+suffix,str(count)+suffix)
 for key in ['axiom_free_exported_results','axiom_free_audited_definitions_and_theorems']:s=s.replace(f'{old[key]:,}',f'{cov["summary"][key]:,}')
 s=s.replace(f'{old["pending"]:,} entries remain pending',f'{cov["summary"]["pending"]:,} entries remain pending')
 if fn=='README.md':s=re.sub(r'(\[latest completion evidence\]\()[^)]+',lambda m:m.group(1)+receipt,s)
 s=s.replace('Full-entry registration awaits the running original programme comparison.','The original programme comparison and all three independent adverse cases pass; the entry is registered complete.')
 p.write_text(s)
with(r/'TIMELINE.txt').open('a')as f:f.write('\nTURN1145 registration '+now+' — Maintenance complete at'+str(count)+'. All19prerequisites complete;116empty-axiom declarations,256original programme cases,original/threeadverse independent cases,twelve-field empirical receipt andthree original witnesses PASS.\n')
def append_verified_result(result):
 p=r/'ZENODO_PAPER_DRAFT.txt';text=p.read_text()
 for old,new in {'The full native empirical receipt matches all twelve original fields, four messages and every hash. The complete original programme comparison remains in progress; full-entry registration follows that result.': 'The full native programme and empirical comparisons pass; the entry is registered complete.'}.items():text=text.replace(old,new)
 match=re.search(r'(?m)^\d+\. '+re.escape('Biological maintenance: retained repair organization and complete alternatives')+r'$',text);assert match
 following=re.search(r'(?m)^\d+(?:\.\d+)*\. ',text[match.end():])
 at=match.end()+following.start() if following else len(text)
 text=text[:at].rstrip()+'\n\n'+result.strip()+'\n\n'+text[at:]
 p.write_text(text)
append_verified_result('\nMaintenance verification: all256original alternatives,allthree operational witnesses,original controls and twelve-field empirical receipt match V3. All116audited declarations have empty axiom dependencies. The source-bound extraction and complete75claim seal are reused with exact identity evidence; no scientific input or boundary is changed. Source correspondence: '+receipt+'. Timeline TURN1144–1145.\n')
p=r/'CONTINUATION_STATE.json';s=json.loads(p.read_text());s['maintenance1145_completion']={'count':count,'receipt':receipt};p.write_text(json.dumps(s,indent=2)+'\n');print(count)
