from pathlib import Path
import json
r=json.loads(Path('work/terminalhyperfine_independent953_report.json').read_text())
assert len(r)==4 and all(x['actual']['passed']==x['expected'] for x in r)
print('Reused original claim independent-validator result;source binds it to the law,not the separate empirical specification')
