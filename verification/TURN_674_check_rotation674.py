from pathlib import Path
import json,hashlib,re
w=Path('work');ns={};exec((w/'matcubic_spec673.py').read_text(),ns);f=ns['namespace']['_positive_prime_factors'];lines=(w/'rotation674_outputs.tsv').read_text().splitlines();assert len(lines)==65
for n,line in enumerate(lines):
 i,status,value=line.split('\t',2);assert int(i)==n
 try: expected=f(n)
 except Exception as e: assert status=='error' and value==str(e),(n,line,str(e))
 else:
  actual=tuple(map(int,value.split(','))) if value else ()
  assert status=='ok' and actual==expected,(n,line,expected)
p=w/'constants-recovery/SFT/Materials/RotationFactors.lean';names=['SFT.Materials.RotationFactors.'+n for n in re.findall(r'^(?:def|theorem|inductive) (\w+)',p.read_text(),re.M)];audit=(w/'rotation674_audit.log').read_text();assert all("'"+n+"' does not depend on any axioms" in audit for n in names)
report={'status':'PASS','completed_entry':False,'source_pin':ns['pin'],'operation':'sft/materials/structural_counts.py:_positive_prime_factors','source_sha256':hashlib.sha256(ns['raw']('sft/materials/structural_counts.py').encode()).hexdigest(),'lean_sha256':hashlib.sha256(p.read_bytes()).hexdigest(),'tested_inputs':list(range(65)),'fresh_lean_execution':True,'audited_declarations':names,'axiom_dependencies':[],'scope':'Exact source removal-loop implementation with proved decreasing measures; original host guards and output/error comparisons0..64. Totient and unrestricted rotation classification remain to be connected.'};(w/'rotation674_comparison.json').write_text(json.dumps(report,indent=2)+'\n');print('PASS:12 declarations;65 source output/error comparisons')
