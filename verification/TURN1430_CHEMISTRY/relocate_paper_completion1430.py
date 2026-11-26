from pathlib import Path
import json,re,collections,fcntl,datetime
w=Path('work');r=w/'turn1064_recovery';p=r/'ZENODO_PAPER_DRAFT.txt'
with(w/'entry_registration.lock').open('a')as lock:
 fcntl.flock(lock,fcntl.LOCK_EX);before=p.read_text();s=before
 heads=list(re.finditer(r'^(\d+)\. (.+)$',s,re.M));a=next(h for h in heads if h[1]=='1188');b=next(h for h in heads if h[1]=='1189');body=s[a.start():b.start()];paras=[x for x in body.split('\n\n')if 'Completion receipt:'in x];moves=[]
 for para in paras:
  receipt=re.search(r'Completion receipt: (\S+COMPLETION\.json)',para)[1];record=json.loads((r/receipt).read_text());assert record['status']=='complete';token=Path(receipt).stem.replace('_COMPLETION','');targets=[]
  for i,h in enumerate(heads):
   if h[1]=='1188':continue
   end=heads[i+1].start()if i+1<len(heads)else len(s)
   if token in s[h.start():end]:targets.append(h[1])
  if token=='TURN1232_BIOCAUSALITY':
   target='1111';h=next(h for h in heads if h[1]==target);i=heads.index(h);assert 'BioCausality andBioHandoff' in s[h.start():heads[i+1].start()] and 'Native correspondence: SFT/Biology/' in s[h.start():heads[i+1].start()];targets=[target]
  assert len(targets)==1,(token,targets)
  assert body.count(para)==1;body=body.replace(para,'',1);moves.append({'receipt':receipt,'claim_id':record['claim_id'],'from':1188,'to':int(targets[0]),'paragraph':para})
 s=s[:a.start()]+body+s[b.start():]
 for move in moves:
  h=re.search(r'^'+str(move['to'])+r'\. ',s,re.M);n=re.search(r'^\d+\. ',s[h.end():],re.M);end=h.end()+n.start();s=s[:end].rstrip()+'\n\n'+move['paragraph']+'\n\n'+s[end:]
 # Every nonblank paragraph is retained byte-for-byte, including equations/citations.
 split=lambda x:collections.Counter(z.strip()for z in re.split(r'\n\s*\n',x)if z.strip())
 assert split(s)==split(before)
 p.write_text(s);report={'status':'PASS','moved':len(moves),'paragraph_multiset_unchanged':True,'moves':[{k:v for k,v in m.items()if k!='paragraph'}for m in moves]};(w/'paper_completion_placement1430.json').write_text(json.dumps(report,indent=2)+'\n');print('PASS relocated',len(moves),'unchanged paragraphs')
