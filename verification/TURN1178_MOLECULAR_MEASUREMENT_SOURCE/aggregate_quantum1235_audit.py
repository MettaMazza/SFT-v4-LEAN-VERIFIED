from pathlib import Path
import json,hashlib
w=Path('work');r=w/'turn1064_recovery';names=[];hashes={}
for file in ['quantum1235_entry_audit_report.json','quantum1235_interfaces_audit_report.json']:
 a=json.loads((w/file).read_text());assert a['status']=='PASS';names+=a['declarations']
 for m,h in a['source_sha256'].items():
  rel='SFT/Chemistry/'+m+'.lean';assert hashlib.sha256((r/rel).read_bytes()).hexdigest()==h;hashes[rel]=h
assert len(names)==len(set(names))==142
(w/'quantum1235_full_audit_report.json').write_text(json.dumps(dict(status='PASS',declarations=names,source_sha256=hashes),indent=2)+'\n')
