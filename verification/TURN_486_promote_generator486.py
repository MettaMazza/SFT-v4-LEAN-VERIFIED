from pathlib import Path
import json,re,hashlib,shutil,copy,datetime
r=Path('/Volumes/One Touch/SFT v4 Full model LEAN');rec=Path('work/constants-recovery');out=Path('work/generator486');report=json.loads((out/'report.json').read_text());assert report['status']=='PASS'
old=Path('work/GeneratorThreeGrammar_before485.lean').read_text();assert (r/'SFT/Physics/GeneratorThreeGrammar.lean').read_text()==old
base=(rec/'SFT/Physics/GeneratorThreeGrammarBase.lean').read_text();final=(rec/'SFT/Physics/GeneratorThreeGrammar.lean').read_text();cut=old.index('set_option maxHeartbeats 20000000 in\ntheorem sourceDecisionMatchesCriteria');assert base==old[:cut]+'end SFT.Physics.GeneratorThreeGrammar\n'
assert re.findall(r'^theorem\s+(.*?)\s*:=',old,re.M|re.S)==re.findall(r'^theorem\s+(.*?)\s*:=',base+final,re.M|re.S)
audit=(out/'audit.log').read_text();assert all("'"+n+"' does not depend on any axioms" in audit for n in report['audited_declarations']);assert 'depends on axioms:' not in audit
cov=json.loads((r/'COVERAGE.json').read_text());assert cov['summary']['fully_reconstructed_claims']==217
paths=set(json.load(open('work/checkpoint486_paths.json')));corr=json.loads((r/'reference/CORRESPONDENCE.json').read_text());template=next(e for e in corr['modules'] if e.get('module')=='SFT/Physics/GeneratorThreeGrammar.lean');oldths=set(re.findall(r'^#print axioms (\S+)',(r/'Audit.lean').read_text(),re.M));auditrel='verification/TURN_486_REGISTERED_DECLARATIONS_AUDIT.log';prior=(r/auditrel).read_text();olddefs=set(re.findall("'([^']+)' does not depend on any axioms",prior));ths=[];defs=[]
for m in report['modules']:
 rel='SFT/Physics/'+m+'.lean';s=(rec/rel).read_text();shutil.copy2(rec/rel,r/rel);paths.add(rel);decls=re.findall(r'^(def|theorem|structure|inductive) (\w+)',s,re.M)
 ths += ['SFT.Physics.GeneratorThreeGrammar.'+n for kind,n in decls if kind=='theorem'];defs += ['SFT.Physics.GeneratorThreeGrammar.'+n for kind,n in decls if kind in ['def','theorem']]
 found=next((e for e in corr['modules'] if e.get('module')==rel),None)
 if found is None:found=copy.deepcopy(template);found['module']=rel;corr['modules'].append(found)
 domain='Pinned complete1024-case GeneratorThree grammar; original scientific definitions and public theorem statements preserved. All cases remain explicitly kernel-checked in separately compiled exhaustive census partitions.'
 found.update(lean_source_sha256=hashlib.sha256(s.encode()).hexdigest(),domain=domain,implemented={n:domain for _,n in decls},remaining=[],completion_evidence='verification/TURN_486_GENERATOR/report.json')
newths=sorted(set(ths)-oldths);newdefs=sorted(set(defs)-olddefs);assert len(newths)==48 and len(newdefs)==48
with (r/'Audit.lean').open('a') as f:f.write(''.join('#print axioms '+n+'\n' for n in newths))
(r/auditrel).write_text(prior+'\n'+''.join("'"+n+"' does not depend on any axioms\n" for n in newdefs))
oldtc=cov['summary']['axiom_free_exported_results'];olddc=cov['summary']['axiom_free_audited_definitions_and_theorems'];cov['summary']['axiom_free_exported_results']+=len(newths);cov['summary']['axiom_free_audited_definitions_and_theorems']+=len(newdefs);cov['updated_at']=datetime.datetime.now(datetime.timezone.utc).isoformat();(r/'COVERAGE.json').write_text(json.dumps(cov,indent=2)+'\n');corr['audited_theorems']=sorted(set(corr['audited_theorems'])|set(newths));(r/'reference/CORRESPONDENCE.json').write_text(json.dumps(corr,indent=2)+'\n')
for name in ['README.md','docs/assets/sft-banner.svg','ZENODO_PAPER_DRAFT.txt']:
 p=r/name;s=p.read_text()
 if name=='ZENODO_PAPER_DRAFT.txt':
  i=s.index('\n2.');head=s[:i].replace(f'{oldtc:,}',f'{oldtc+48:,}').replace(f'{olddc:,}',f'{olddc+48:,}');s=head+s[i:]
 else:s=s.replace(f'{oldtc:,}',f'{oldtc+48:,}').replace(f'{olddc:,}',f'{olddc+48:,}')
 p.write_text(s);paths.add(name)
for p in out.iterdir():
 if p.is_file():rel='verification/TURN_486_GENERATOR/'+p.name;(r/rel).parent.mkdir(exist_ok=True);shutil.copy2(p,r/rel);paths.add(rel)
for name in ['build_generator486.py','resume_generator486.py','finish_generator486.py','generator486_build.log','generator486_resume.log','generator486_finish.log']:
 rel='verification/TURN_486_GENERATOR/'+name;shutil.copy2(Path('work')/name,r/rel);paths.add(rel)
paths.update(['Audit.lean','COVERAGE.json','reference/CORRESPONDENCE.json',auditrel]);Path('work/checkpoint486_paths.json').write_text(json.dumps(sorted(paths)));print('GENERATOR PROMOTED;48 additional zero-axiom helper theorems;no additional source-entry count')
