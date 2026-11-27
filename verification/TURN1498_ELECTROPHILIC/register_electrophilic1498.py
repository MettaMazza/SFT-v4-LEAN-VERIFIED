from pathlib import Path
import json,re,hashlib,datetime,fcntl
w=Path('work');r=w/'turn1064_recovery';cid='SFT-CHEM-ELECTROPHILIC-SUBSTITUTION-FAMILY-008';now=datetime.datetime.now(datetime.timezone.utc).isoformat();H=lambda p:hashlib.sha256(p.read_bytes()).hexdigest()
reports=['electrophilic1498_full_audit_report.json','electrophilic1498_program_report.json','electrophilic1498_analysis_report.json','electrophilic1498_paths_report.json','electrophilic1498_validation_report.json']
for f in reports:assert json.loads((w/f).read_text())['status']=='PASS',f
audit=json.loads((w/reports[0]).read_text());names=audit['declarations'];assert len(names)==131
for m,h in audit['source_sha256'].items():assert H(r/'SFT/Chemistry'/f'{m}.lean')==h
assert json.loads((w/'electrophilic1498_validation_output.json').read_text())==json.loads((w/'electrophilic1498_original_empirical.json').read_text())
assert json.loads((w/'electrophilic1498_validation_output.json').read_text())['passed']
lock=open(w/'entry_registration.lock','w');fcntl.flock(lock,fcntl.LOCK_EX)
c=json.loads((r/'COVERAGE.json').read_text());by={x['claim_id']:x for x in c['claims']};x=by[cid];assert x['lean_status']!='complete';assert all(by[d]['lean_status']=='complete'for d in x['v3_registration']['dependencies']);old=c['summary'].copy();assert old['fully_reconstructed_claims']==1051
law='sft/chemistry/electrophilic_substitution_law_v1.py';val='sft/chemistry/electrophilic_substitution_validation_v1.py';batch='sft/chemistry/electrophilic_substitution_batch_v1.py'
scopes={
'ElectrophilicCarrier':(law,'Five retained role occurrences, structural singletonEmptyOne acceptor, complete source donor/recurrence/leaving pair checks, background-support exclusions, transition conservation and exact source/intermediate/restored-terminal dictionary classification.'),
'ElectrophilicPath':(law,'Original one/two-transition paths, gap-free occurrence order, adjacent-state/action guards, return records and fresh aromatic-carrier extension preserving prior bond prefixes.'),
'ElectrophilicConservation':(law,'General successful-transition theorem retains ordered atoms, all held electron occurrences and the supplied transition fields.'),
'ElectrophilicWitnesses':(law,'Seven original proved witnesses: complete carrier, acceptor transfer, leaving relinquishment, restored recurrence, both path lengths, cleavage-first rejection and retained successor.'),
'ElectrophilicGrammar':(batch,'All eight original binary axes and256 candidates, complete census and unique source-preserving survivor.'),
'ElectrophilicEvidence':(batch,'Original registration, all256 decisions, seven witnesses, closure, four controls and unregistered-candidate rejection; entire fresh programme matches original.'),
'ElectrophilicAnalysis':(val,'Original complete452-page text-vector count/hash/character guards, four target checks and retained26-field post-seal analysis. External PdfReader extraction is preserved as in V3 and bound to original PDF bytes.'),
'ElectrophilicSource':(val,'Original four-target identity, source snapshot and payload guards with exact six-key correspondence and original error order.'),
'ElectrophilicExperiment':(val,'Original observational registration, four references, eight dimensions, prediction programme, envelope and seven witnesses.'),
'ElectrophilicValidation':(val,'Full source-specific capability execution, seal, audit, target custody, comparisons, omitted-row/tampered-label controls and12-field six-message report; fresh full native report matches passing original.')}

receipt='verification/TURN1498_ELECTROPHILIC_COMPLETION.json';corr=json.loads((r/'reference/CORRESPONDENCE.json').read_text());corr['modules']=[z for z in corr['modules']if z.get('v3_claim')!=cid];oldNames=set(re.findall(r'^#print axioms (\S+)',(r/'Audit.lean').read_text(),re.M));newNames=[]
for m,(source,scope)in scopes.items():
 rel='SFT/Chemistry/'+m+'.lean';ths=['SFT.Chemistry.'+m+'.'+n for n in re.findall(r'^theorem (\w+)',(r/rel).read_text(),re.M)];assert all(n in names for n in ths);newNames += [n for n in ths if n not in oldNames]
 corr['modules'].append(dict(lean_module=rel,v3_claim=cid,source_path=source,lean_source_sha256=H(r/rel),domain=scope,remaining=[],completion_evidence=receipt))
 imp='import '+rel[:-5].replace('/','.')
 if imp not in (r/'SFT.lean').read_text().splitlines():
  with(r/'SFT.lean').open('a')as f:f.write('\n'+imp+'\n')
with(r/'Audit.lean').open('a')as f:f.write(''.join('#print axioms '+n+'\n'for n in newNames))
record=dict(status='complete',claim_id=cid,registered_at=now,source_commit=c['source_commit'],lean_source_sha256={'SFT/Chemistry/'+m+'.lean':H(r/'SFT/Chemistry'/f'{m}.lean')for m in scopes},audited_declarations=131,axiom_dependencies=[],source_component_correspondence={m:dict(source=p,component=t)for m,(p,t)in scopes.items()},dependencies={d:'complete'for d in x['v3_registration']['dependencies']},reports={f:H(w/f)for f in reports},full_empirical_replay_passed=True,remaining=[])
(r/receipt).write_text(json.dumps(record,indent=2)+'\n');x.update(lean_status='complete',remaining=[],completion_evidence=receipt,lean_modules=list(record['lean_source_sha256']),verified_scope='; '.join(t for p,t in scopes.values()),artifact_runtime_parity='PASS fresh complete256-candidate programme and12-field empirical report match pinnedV3; originalindependentvalidator and three tamperingcontrolsPASS.')
c['summary'].update(fully_reconstructed_claims=1052,in_progress=sum(z['lean_status']=='in_progress'for z in c['claims']),pending=sum(z['lean_status']=='pending'for z in c['claims']),axiom_free_exported_results=old['axiom_free_exported_results']+len(newNames),axiom_free_audited_definitions_and_theorems=old['axiom_free_audited_definitions_and_theorems']+131);c['updated_at']=now;(r/'COVERAGE.json').write_text(json.dumps(c,indent=2)+'\n');corr['audited_theorems']=sorted(set(corr['audited_theorems'])|set(newNames));(r/'reference/CORRESPONDENCE.json').write_text(json.dumps(corr,indent=2)+'\n')
for fn in ['README.md','docs/assets/sft-banner.svg']:
 p=r/fn;s=p.read_text()
 for a,b in [('1,051 / 2,781','1,052 / 2,781'),('1051 / 2,781','1052 / 2,781'),('1,051 entries complete','1,052 entries complete'),('1051 entries complete','1052 entries complete'),('1,730 entries remain unfinished.','1,729 entries remain unfinished.')]:s=s.replace(a,b)
 for key in ['axiom_free_exported_results','axiom_free_audited_definitions_and_theorems']:s=s.replace(f'{old[key]:,}',f'{c["summary"][key]:,}')
 if fn=='README.md':
  s=re.sub(r'\[latest completion evidence\]\([^)]*\)','[latest completion evidence]('+receipt+')',s);s=re.sub(r'([0-9,]+) candidate records matched',lambda m:f'{int(m[1].replace(",",""))+256:,} candidate records matched',s)
 p.write_text(s)
nextId=next(z['claim_id']for z in c['claims']if z['lean_status']!='complete'and all(by[d]['lean_status']=='complete'for d in z['v3_registration']['dependencies']))
s=json.loads((r/'CONTINUATION_STATE.json').read_text());s['scientific_cursor'].update(completed=cid,next=nextId,next_milestone=1250,action='Continue '+nextId+' from pinned original source in dependency order. Preserve completed Electrophilic007 proof,256-candidate and full empirical equality evidence. No pending007 derivation or repeated review.');s['authorized_action']='1052 complete. Continue '+nextId+' toward1250; update counts,paper,timeline,push; pause at1250review.';s['electrophilic1498']=record;(r/'CONTINUATION_STATE.json').write_text(json.dumps(s,indent=2)+'\n');print('REGISTERED1052; next',nextId,';newtheorems',len(newNames))
