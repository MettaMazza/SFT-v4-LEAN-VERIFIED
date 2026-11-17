from pathlib import Path
import json,hashlib,re,fcntl
lock=open('work/entry_registration.lock','w');fcntl.flock(lock,fcntl.LOCK_EX)
r=Path('work/turn1064_recovery');base=Path('/Volumes/One Touch/SFT v4 Full model LEAN');p=r/'ZENODO_PAPER_DRAFT.txt';s=p.read_text();before=s;rp=Path('work/publication1149_editorial_report.json');report=json.loads(rp.read_text())
rows=[('The source-specific application and independent-validator work remains separate from these completed translations; claim 006 has not yet been registered complete.','The source-specific application and independent-validator work are complete; verification/TURN_1025_CALCULATOR_006_COMPLETION.json records the completed entry.','1025_CALCULATOR_006'),('The native full empirical/programme comparison remains in progress, so this entry is not yet registered complete.','The native full empirical and programme comparisons pass, and the entry is registered complete; see verification/TURN_1129_ISOTOPE_EXCHANGE_COMPLETION.json.','1129_ISOTOPE_EXCHANGE')]
for old,new,tag in rows:
 receipt='verification/TURN_'+tag+'_COMPLETION.json';q=r/receipt
 if not q.exists():q=base/receipt
 d=json.loads(q.read_text());assert d['status']=='complete' and not d['remaining']
 for rel,h in d['lean_source_sha256'].items():
  if '/' not in rel:rel='SFT/Mathematics/'+rel+'.lean'
  q=r/rel
  if not q.exists():q=base/rel
  assert hashlib.sha256(q.read_bytes()).hexdigest()==h,rel
 assert s.count(old)==1;s=s.replace(old,new);report['edits'].append(dict(old=old,new=new,receipt=receipt))
assert re.findall(r'\\\[[\s\S]*?\\\]|\\\([\s\S]*?\\\)',before)==re.findall(r'\\\[[\s\S]*?\\\]|\\\([\s\S]*?\\\)',s)
p.write_text(s);report['completion_sentences_corrected']=7;report['after_sha256']=hashlib.sha256(s.encode()).hexdigest();rp.write_text(json.dumps(report,indent=2)+'\n');print('Corrected seven stale completion sentences in total; mathematical expressions unchanged.')
