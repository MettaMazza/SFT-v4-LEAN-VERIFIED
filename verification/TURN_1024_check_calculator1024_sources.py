from pathlib import Path
import subprocess,hashlib,json
w=Path('work');root=w/'v3-runtime500';pin='76f1b34e9e9682989adcbb088797b4ae4ce4fcf1';repo='/Volumes/One Touch/ernos-labs-sft-platform'
paths=['sft/mathematics/calculator_complete/'+s for s in ['evidence.py','expression_census.py','explorer.py','law.py']]+['sft/mathematics/catalog.py','generated/mathematics/scientific_calculator_coverage_v4.json']
rows=[]
for path in paths:
 b=subprocess.check_output(['git','-C',repo,'show',pin+':'+path]);assert b==(root/path).read_bytes(),path;rows.append(dict(path=path,sha256=hashlib.sha256(b).hexdigest()))
(w/'calculator1024_source_identity.json').write_text(json.dumps(dict(status='PASS',commit=pin,files=rows),indent=2));print('PASS six original source inputs match pinned bytes')
