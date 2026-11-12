from pathlib import Path
import json,hashlib,re
w=Path('work');ns={};exec((w/'matcubic_spec673.py').read_text(),ns);src=ns['namespace']
lines=(w/'rotation675_factor_outputs.tsv').read_text().splitlines();assert len(lines)==65
for n,line in enumerate(lines):
 i,status,value=line.split('\t',2);assert int(i)==n
 try: expected=src['_positive_prime_factors'](n)
 except Exception as e:assert status=='error' and value==str(e)
 else:assert status=='ok' and (tuple(map(int,value.split(','))) if value else ())==expected
lines=(w/'rotation675_totient_outputs.tsv').read_text().splitlines();assert len(lines)==64
for n,line in enumerate(lines,1):
 i,count,admitted=line.split('\t');order=src['PositiveCount'](n);assert int(i)==n
 assert int(count)==src['totient_count'](order).value
 assert (admitted=='true')==src['crystallographic_rotation_admitted'](order)
report={'status':'PASS','completed_entry':False,'source_pin':ns['pin'],'factor_cases':65,'totient_and_admission_cases':64,'fresh_lean_execution':True,'source_sha256':hashlib.sha256(ns['raw']('sft/materials/structural_counts.py').encode()).hexdigest(),'remaining':'Unrestricted factor/exponent classification and original entry program/controls/validator.'}
(w/'rotation675_comparison.json').write_text(json.dumps(report,indent=2)+'\n');print('PASS65 factor and64 totient/admission comparisons')
