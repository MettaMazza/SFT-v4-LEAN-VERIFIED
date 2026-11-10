from pathlib import Path
import json,subprocess
w=Path('work');r=w/'constants-recovery';items=json.loads((w/'backfill534_metadata.json').read_text())
for i,item in enumerate(items):
 stem=item['stem'];low=stem.lower()
 spec="from pathlib import Path\nimport ast,json\nvalues=json.loads(Path('work/backfill534_metadata.json').read_text())["+str(i)+"][\"law\"]\ncid=values['claim_id'];q=lambda x:json.dumps(x,ensure_ascii=False)\ndims=[[d['key'],'',d['choices'][0]['name'],d['choices'][0]['reason'],d['choices'][1]['name'],d['choices'][1]['reason']] for d in values['dimensions']]\nkw={k:ast.parse(repr(v),mode='eval').body for k,v in values.items()}\n"
 (w/(low+'_spec534.py')).write_text(spec)
 for part in ['grammar','evidence']:
  s=(w/('unit_'+part+'480.py')).read_text().replace('unit',low).replace('Unit',stem).replace('480','534');(w/(low+'_'+part+'534.py')).write_text(s);subprocess.run(['python3',str(w/(low+'_'+part+'534.py'))],check=True)
 for tail in ['Grammar','Evidence']:
  s=(w/(stem+tail+'534.lean')).read_text().replace('import «work».'+stem+'Carrier534','import SFT.Physics.'+item['module']+'\nimport SFT.Foundation.FormAcceptance').replace('«work».'+stem+'Grammar534','SFT.Physics.'+stem+'Grammar')
  if tail=='Evidence':
   a=s.index('def onePairWitness');b=s.index('def claimId',a)
   # Original backfill witnesses are literal booleans; preserve those exact source witnesses.
   q=lambda x:json.dumps(x,ensure_ascii=False)
   s=s[:a]+'def witnesses : Value := .array ['+','.join('.array [.text '+q(x[0])+',.text '+q(x[1])+',.boolean '+str(x[2]).lower()+']' for x in item['law']['operational_witnesses'])+']\n'+s[b:]
  (r/'SFT/Physics'/(stem+tail+'.lean')).write_text(s)
print('Prepared eight complete source grammars and evidence modules.')
