from pathlib import Path
import sys,json
sys.path.insert(0,str(Path('work/v3-runtime500').resolve()));from sft.physics.grand_lock_terminal_law_v1 import frozen_input
r=Path('/Volumes/One Touch/SFT v4 Full model LEAN/SFT/Physics');d=frozen_input();rows=[(x['claim_id'],x['dependencies'])for x in d['dependency_dictionary']];q=json.dumps;lst=lambda xs:'['+','.join(q(x)for x in xs)+']';empty=(None,());nodes={};lines=[]
def lit(t):
 if t in nodes:return nodes[t]
 v,ch=t;children='['+','.join('('+str(k)+','+lit(c)+')'for k,c in ch)+']';n='dictionaryNode'+str(len(nodes));nodes[t]=n;lines.append('def '+n+' : Dictionary (List String) := .node '+('none'if v is None else '(some '+lst(v)+')')+' '+children);return n
def put(t,bs,v):
 old,cs=t
 if not bs:return(tuple(v),cs)
 k=bs[0];found=next((c for key,c in cs if key==k),empty);nextt=put(found,bs[1:],v)
 if any(key==k for key,_ in cs):cs=tuple((key,nextt if key==k else c)for key,c in cs)
 else:cs=((k,nextt),)+cs
 return(old,cs)
t=empty;states=[lit(t)]
for key,ds in rows:t=put(t,key.encode(),ds);states.append(lit(t))
head='import SFT.Physics.GrandLockDependencyGraphData\nnamespace SFT.Physics.GrandLockDependencyProofs\nopen SFT.Physics.GrandLockDependency\nset_option maxRecDepth 100000\nset_option maxHeartbeats 100000000\n';end='end SFT.Physics.GrandLockDependencyProofs\n';s=head+'\n'.join(lines)+'\n'
for i,n in enumerate(states):s+='def sourceDictionary'+str(i)+' : Dictionary (List String) := '+n+'\n'
s+='def sourceRows'+str(len(rows))+' : Rows := []\n'
for i in reversed(range(len(rows))):s+='def sourceRows'+str(i)+' : Rows := ('+q(rows[i][0])+','+lst(rows[i][1])+') :: sourceRows'+str(i+1)+'\n'
(r/'GrandLockDictionaryData.lean').write_text(s+end)
s=head.replace('GrandLockDependencyGraphData','GrandLockDictionaryData');final='sourceDictionary'+str(len(rows));f='(fun d (name,parents)=>put d name parents)'
s+='theorem dictionaryFold'+str(len(rows))+' : recordFoldPure '+f+' '+final+' sourceRows'+str(len(rows))+' = '+final+' := rfl\n'
for i in reversed(range(len(rows))):
 a='sourceDictionary'+str(i);b='sourceDictionary'+str(i+1);key,ds=rows[i];expr='put '+a+' '+q(key)+' '+lst(ds)
 s+='theorem dictionaryInsert'+str(i)+' : '+expr+' = '+b+' := rfl\n'
 s+='theorem dictionaryFold'+str(i)+' : recordFoldPure '+f+' '+a+' sourceRows'+str(i)+' = '+final+' := by\n change recordFoldPure '+f+' ('+expr+') sourceRows'+str(i+1)+' = _\n rw [dictionaryInsert'+str(i)+']\n exact dictionaryFold'+str(i+1)+'\n'
s+='theorem originalDictionary : rowDictionary originalRows = '+final+' := dictionaryFold0\n#print axioms originalDictionary\n';(r/'GrandLockDictionaryProof.lean').write_text(s+end)
for name in ['Traversal','Roots']:
 p=r/('GrandLockDependency'+name+'.lean');s=p.read_text().replace('import SFT.Physics.GrandLockDependencyGraphData','import SFT.Physics.GrandLockDictionaryProof');op='traversalCount' if name=='Traversal'else'allRooted';s=s.replace(':= rfl',':= by\n unfold '+op+'\n rw [originalDictionary]\n rfl');p.write_text(s)
print(len(rows),'ordered source insertions,',len(nodes),'shared exact dictionary nodes')
