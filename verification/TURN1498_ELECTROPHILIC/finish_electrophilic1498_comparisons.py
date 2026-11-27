from pathlib import Path
import json,hashlib
w=Path('work')
for kind,start in [('program','{"census"'),('validation','{"')]:
 lines=(w/f'electrophilic1498_{kind}_output.log').read_text().splitlines()
 values=[json.loads(s)for s in lines if s.startswith(start)]
 values=[d for d in values if 'resource_receipt'not in d];assert len(values)==1,kind;d=values[0]
 original=json.load(open(w/f'electrophilic1498_original_{"empirical" if kind=="validation" else "program"}.json'));assert d==original,(kind,[k for k in d if d[k]!=original.get(k)])
 (w/f'electrophilic1498_{kind}_output.json').write_text(json.dumps(d,indent=2)+'\n')
 report=dict(status='PASS',source_commit='76f1b34e9e9682989adcbb088797b4ae4ce4fcf1',comparison='entire fresh native output equals actual original execution')
 if kind=='program':report['candidates']=len(d['decisions'])
 else:report.update(empirical_validation_passed=d['passed'],fields=len(d),messages=len(d['measurements']));assert d['passed']
 (w/f'electrophilic1498_{kind}_report.json').write_text(json.dumps(report,indent=2)+'\n');print(kind,'PASS')
