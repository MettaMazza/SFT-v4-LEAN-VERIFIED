from pathlib import Path
import re,json,hashlib
w=Path('work');r=w/'turn1064_recovery';changes=[]
for p in (r/'SFT/Medicine').glob('*Experiment.lean'):
 if p.name=='PatientIdentityExperiment.lean':continue
 s=p.read_text();target=re.search(r'^def targetId : String := "([^"]+)"',s,re.M).group(1)
 out=re.sub(r'\b\w+Source\.Requirement\.sourceId',r'(fun requirement => requirement.sourceId)',s)
 out=out.replace('if !Text.equal targetId "sft-med-patient-identity-001-authority-correspondence"',f'if !Text.equal targetId "{target}"')
 if out!=s:
  p.write_text(out);changes.append(dict(path=str(p),old_sha256=hashlib.sha256(s.encode()).hexdigest(),new_sha256=hashlib.sha256(out.encode()).hexdigest()))
 for g in w.glob('generate_*_experiment.py'):
  t=g.read_text()
  if 'namespace SFT.Medicine.'+p.stem not in t:continue
  v=re.sub(r'\b\w+Source\.Requirement\.sourceId',r'(fun requirement => requirement.sourceId)',t)
  v=v.replace('if !Text.equal targetId "sft-med-patient-identity-001-authority-correspondence"',f'if !Text.equal targetId "{target}"')
  v=re.sub(r'\b\w+Source\.distinctIds','SFT.Biology.LifeOrganizationSource.distinctIds',v)
  if v!=t:
   compile(v,str(g),'exec');g.write_text(v);changes.append(dict(path=str(g),old_sha256=hashlib.sha256(t.encode()).hexdigest(),new_sha256=hashlib.sha256(v.encode()).hexdigest()))
(w/'medicine_binding1192_changes.json').write_text(json.dumps(changes,indent=2)+'\n')
print('Exact source-binding correction:',len(changes),'files; PatientIdentity retained; source target formula preserved.')
