from pathlib import Path
import ast,json,subprocess
r=Path('work/constants-recovery');pin='76f1b34e9e9682989adcbb088797b4ae4ce4fcf1';src=subprocess.check_output(['git','-C','/Volumes/One Touch/ernos-labs-sft-platform','show',pin+':sft/foundation/admission_enforcement.py'],text=True);tree=ast.parse(src);cs={}
for n in tree.body:
 if isinstance(n,ast.Assign):
  try:cs[n.targets[0].id]=ast.literal_eval(n.value)
  except (ValueError,TypeError):pass
names=['registration','premises','census','forcing','closure','controls','validation','measurement','receipts','dependency','extra'];fields=[]
for i,key in enumerate(names):
 cs[key.upper()]=cs['DOMAINS'][i];fields.append((key,key.capitalize(),['noExtra','hasExtra'] if i==10 else ['rejected','admitted'],key.upper(),0 if i==10 else 1))
cs['SURVIVOR']='__'.join(cs[k][a] for f,t,ctors,k,a in fields);q=lambda x:json.dumps(x,ensure_ascii=False)
s=Path('work/gen043.py').read_text();s=s[s.index("s='import"):];s=s.replace('SFT.Foundation.FormAcceptance','SFT.Foundation.AdmissionAcceptance').replace('SFT.Foundation.FormGrammar','SFT.Foundation.AdmissionGrammar').replace('SFT/Foundation/FormGrammar.lean','SFT/Foundation/AdmissionGrammar.lean').replace('i==6','i==10').replace('= 288','= 2048').replace('Grammar proposal has ','Admission path has ').replace('maxHeartbeats 20000000','maxHeartbeats 100000000').replace('maxHeartbeats 10000000','maxHeartbeats 100000000')
a=s.index('fn=next');b=s.index("s+='def generationRule",a)
s=s[:a]+'''fn=next(n for n in tree.body if isinstance(n,ast.FunctionDef) and n.name=='decision_reason');checks=ast.literal_eval(fn.body[0].value);s+='def decisionReason (c : Candidate) : String :=\\n'
for i,(marker,reason) in enumerate(checks):
 field=fields[i][0];s+='  if SFT.Host.Text.equal ('+field+'Name c.'+field+') '+q(marker)+' then '+q(reason)+' else\\n'
s+='  '+q(ast.literal_eval(fn.body[-1].value))+'\\n\\n'
'''+s[b:]
s=s.replace('⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩','⟨'+','.join(['rfl']*11)+'⟩').replace('⟨h0,h1,h2,h3,h4,h5,h6⟩','⟨'+','.join('h'+str(i) for i in range(11))+'⟩').replace('cases h6\\n','cases h6; cases h7; cases h8; cases h9; cases h10\\n');exec(s)
