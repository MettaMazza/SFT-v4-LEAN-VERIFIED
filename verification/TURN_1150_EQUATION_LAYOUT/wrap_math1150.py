from pathlib import Path
import json,re,hashlib,fcntl
lock=open('work/entry_registration.lock','w');fcntl.flock(lock,fcntl.LOCK_EX)
p=Path('work/turn1064_recovery/ZENODO_PAPER_DRAFT.txt');before=p.read_text();s=before
breaks={
's157':[r'\pi_2(timeTrace)',r'timeCount='],
's206':[r'p.\operatorname{sourceId}',r'\land\operatorname{AcceptedTrace}'],
's228':[r's.\operatorname{content}',r's.\operatorname{message}'],
's240':[r'a\in A',r'\land\exists',r'\land(a_{\rm credential}'],
's263':[r'[(x,p(x))',r'\operatorname{all}',r'[(\mathrm{examples}',r'(\mathrm{withheld}'],
's301':[r'\land\operatorname{shift}',r'\qquad s_g'],
's316':[r'\to\mathrm{inputs/vault}',r'\to\mathrm{protectedAudit}'],
's466':['completeCausalChanges'],
's501':[r'\operatorname{map}(q,\operatorname{outgoingSupport}'],
's586':[r'\land'],
's831':[r'\qquad']}
changes=[]
for item in json.loads(Path('work/pdf1145/math_sizes.json').read_text()):
 if item['scale']>=1:continue
 old=item['tex'];new=old
 for marker in breaks[item['section']]:
  assert new.count(marker)==1,(item['section'],marker)
  new=new.replace(marker,'\\\\\n'+marker)
 new='\n\\begin{gathered}\n'+new.strip()+'\n\\end{gathered}\n'
 assert s.count('\\['+old+'\\]')==1,item['section']
 s=s.replace('\\['+old+'\\]','\\['+new+'\\]')
 changes.append({'section':item['section'],'previous_pixels':item['pixels'],'breaks_before':breaks[item['section']]})
# Erase only layout commands introduced here; every original mathematical token stays.
normalize=lambda t:re.sub(r'\s','',t.replace('\\begin{gathered}','').replace('\\end{gathered}','').replace('\\\\',''))
assert normalize(before)==normalize(s)
s=s.replace('The original V 3 validator','The original V3 validator')
p.write_text(s)
report=dict(status='PASS',wrapped_equations=len(changes),mathematical_tokens_unchanged=True,before_sha256=hashlib.sha256(before.encode()).hexdigest(),after_sha256=hashlib.sha256(s.encode()).hexdigest(),changes=changes)
Path('work/publication1150_math_layout.json').write_text(json.dumps(report,indent=2)+'\n');print('Wrapped',len(changes),'equations; original mathematical tokens unchanged')
