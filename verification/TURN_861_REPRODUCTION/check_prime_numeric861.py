from pathlib import Path
import json
exec(Path('work/prime_spec861.py').read_text())
a=json.loads(Path('work/prime_program861_output.json').read_text())
assert a['prime_status']==[ns['_is_prime'](n) for n in range(10001)]
expected=[[n,list(ns['_goldbach_pair'](n)) if ns['_goldbach_pair'](n) else None] for n in range(4,10001,2)]
assert a['goldbach_pairs']==expected
assert a['twins']==[[p,p+2] for p in range(3,9999) if ns['_is_prime'](p) and ns['_is_prime'](p+2)]
assert len(a['twins'])==ns['_twin_count'](10000)==205
assert a['spot_counts']==[1,6]
Path('work/prime861_numeric_report.json').write_text(json.dumps(dict(status='PASS',source_commit=pin,prime_statuses_compared=10001,ordered_even_inputs_and_first_pairs_compared=4999,twin_pairs_compared=205,exact_spot_counts=a['spot_counts'],fresh_native_execution=True),indent=2));print('PASS 10001 prime statuses,4999 original first pairs,205 exact twin pairs and original spot counts')
