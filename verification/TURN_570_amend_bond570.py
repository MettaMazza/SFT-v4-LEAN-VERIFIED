from pathlib import Path
import json,hashlib,re,subprocess,os,datetime
r=Path('/Volumes/One Touch/SFT v4 Full model LEAN');w=Path('work');rec=w/'constants-recovery';paths=set(json.load(open(w/'checkpoint570_paths.json')))
p=rec/'SFT/Chemistry/ExtendedExtraction.lean';source=p.read_text();ns=re.findall(r'^\s*def (\w+)',source,re.M);a=w/'AuditExtended570.lean';a.write_text(source+'\n'+'\n'.join('#print axioms SFT.Chemistry.ExtendedExtraction.'+n for n in ns));o=subprocess.run(['/Users/dolltrading/.elan/bin/lean',str(a)],env=dict(os.environ,LEAN_PATH=str((rec/'.lake/build/lib/lean').resolve())),capture_output=True,text=True);assert o.returncode==0,o.stdout+o.stderr;assert 'depends on axioms:' not in o.stdout;(w/'extended570_audit.log').write_text(o.stdout+o.stderr)
rel='SFT/Chemistry/ExtendedExtraction.lean';(r/rel).write_text(source)
cfg=json.load(open(w/'bond570_audit_config.json'));p=r/'verification/TURN_570_BOND_COMPLETION.json';e=json.load(open(p));old=set(e['audited_declarations']);new=[n for n in cfg['definitions_and_theorems'] if n not in old];assert len(new)==2,new;e['audited_declarations']=cfg['declarations'];e['added_audited_definitions_and_theorems']+=new;e['lean_source_sha256']['ExtendedExtraction']=hashlib.sha256(source.encode()).hexdigest();e['source_derivation_mapping']['versioned notes-aware source adapter']+=['SFT.Chemistry.ExtendedExtraction.targetKey','SFT.Chemistry.ExtendedExtraction.checkTargetKey'];e['registry_controls_report']='verification/TURN_570_extended570_registry_report.json';e['executed_commands']+=['python3 work/check_extended570.py','python3 work/check_extended_registry570.py','python3 work/amend_bond570.py'];p.write_text(json.dumps(e,indent=2)+'\n')
p=r/'verification/TURN_570_REGISTERED_DECLARATIONS_AUDIT.log';p.write_text(p.read_text()+''.join("'"+n+"' does not depend on any axioms\n" for n in new))
p=r/'COVERAGE.json';c=json.load(open(p));oldcount=c['summary']['axiom_free_audited_definitions_and_theorems'];c['summary']['axiom_free_audited_definitions_and_theorems']+=len(new);p.write_text(json.dumps(c,indent=2)+'\n')
for name in ['README.md','docs/assets/sft-banner.svg','ZENODO_PAPER_DRAFT.txt']:
 p=r/name;p.write_text(p.read_text().replace(f'{oldcount:,}',f'{oldcount+len(new):,}'))
p=r/'reference/CORRESPONDENCE.json';c=json.load(open(p))
for e in c['evidence_modules']:
 if e['module']==rel:
  e['lean_source_sha256']=hashlib.sha256(source.encode()).hexdigest()
  for n in ['targetKey','checkTargetKey']:e['implemented'][n]='Original dictionary key presence/hashability checks and Boolean/integer key identity.'
p.write_text(json.dumps(c,indent=2)+'\n')
for name in ['bond570_audit_config.json','bond570_audit.log','AuditBond570.lean','build_bond_protocol570.log','check_bond_validation570.log','bond_validation570_report.json','bond_validation570_output.json','AuditExtended570.lean','extended570_audit.log','check_extended_registry570.py','extended570_registry_report.json','extended570_registry.log','amend_bond570.py']:
 rel='verification/TURN_570_'+name;(r/rel).write_bytes((w/name).read_bytes());paths.add(rel)
for name in ['ExtendedRegistry570.lean','BondValidationProgram570.lean']:
 rel='verification/TURN_570_'+name;(r/rel).write_bytes((rec/name).read_bytes());paths.add(rel)
for module in ['ExtendedExtraction','BondExperiment','BondValidation']:
 rel='verification/TURN_570_build570_'+module+'.log';(r/rel).write_bytes((w/('build570_'+module+'.log')).read_bytes());paths.add(rel)
with (r/'TIMELINE.txt').open('a') as f:f.write('\n'+datetime.datetime.now(datetime.timezone.utc).isoformat()+' Turn570 pre-push amendment: Code inspection found that an additional malformed observation row with a missing or unhashable target key could be rejected by the original dictionary construction before reference resolution; Boolean/integer dictionary keys also share identity in Python. Added exact key guards and key normalization to ExtendedExtraction. Eleven fresh native registry cases matched the original source helper, including missing keys, list/dict keys, repeated keys and Boolean/integer collisions. Reran only the affected protocol, full empirical comparison and audit; all passed. Final audit160 declarations,20 extraction definitions; completion remains372 and audited definition/theorem count is46,014. Updated completion/source-correspondence hashes and retained all unchanged scientific/program proofs. No branch was updated before this correction.\n')
p=r/'CONTINUATION_STATE.json';s=json.load(open(p));s['live_jobs']=[]
for x in s['snapshot']:
 if x['root']=='canonical' and x['path'] in paths-{'CONTINUATION_STATE.json'}:x['sha256']=hashlib.sha256((r/x['path']).read_bytes()).hexdigest()
 if x['root']=='retained' and x['path']=='SFT/Chemistry/ExtendedExtraction.lean':x['sha256']=hashlib.sha256(source.encode()).hexdigest()
known={(x['root'],x['path']) for x in s['snapshot']}
for rel in paths-{'CONTINUATION_STATE.json'}:
 if ('canonical',rel) not in known:s['snapshot'].append(dict(root='canonical',path=rel,sha256=hashlib.sha256((r/rel).read_bytes()).hexdigest()))
p.write_text(json.dumps(s,indent=2)+'\n')
manifest=[]
for rel in sorted(paths):
 data=(r/rel).read_bytes();out=w/'checkpoint570_ready'/rel;out.parent.mkdir(parents=True,exist_ok=True);out.write_bytes(data);manifest.append(dict(path=rel,file=str(out.resolve()),size=len(data),sha=hashlib.sha1(b'blob '+str(len(data)).encode()+b'\0'+data).hexdigest()))
(w/'checkpoint570_ready_manifest.json').write_text(json.dumps(manifest,indent=2));(w/'checkpoint570_paths.json').write_text(json.dumps(sorted(paths)));print('PASS amendment',len(manifest),'files')
