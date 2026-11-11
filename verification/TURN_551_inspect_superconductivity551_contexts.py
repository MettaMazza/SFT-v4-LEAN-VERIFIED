import subprocess,pathlib,json,re,hashlib
repo='/Volumes/One Touch/ernos-labs-sft-platform';pin='76f1b34e9e9682989adcbb088797b4ae4ce4fcf1';files=json.loads(pathlib.Path('work/source551_related_paths.json').read_text());seen={}
for f in files:
 if not f.endswith('.md'):continue
 text=subprocess.check_output(['git','-C',repo,'show',pin+':'+f],text=True);paragraphs=text.split('\n\n')
 for i,p in enumerate(paragraphs):
  if not re.search(r'momentum.randomiz|label.compatible dissip|scattering.closed|loss.paths.below.gap',p,re.I):continue
  context='\n\n'.join(paragraphs[max(0,i-1):i+2]);key=re.sub(r'\s+',' ',context)
  if key not in seen:seen[key]={'text':context,'paths':[]}
  seen[key]['paths'].append(f)
rows=list(seen.values());pathlib.Path('work/source551_derivation_contexts.json').write_text(json.dumps(rows,indent=2));print('Distinct source contexts:',len(rows))
for n,row in enumerate(rows):print(n,row['paths'][0],row['text'][:900].replace('\n',' '))
