from pathlib import Path
import sys,importlib.util,json,hashlib,itertools
w=Path('work');sys.path.insert(0,str((w/'v3-runtime500').resolve()))
p=w/'pinned1138/sft/chemistry/equilibrium_isotope_fractionation_law_v1.py'
spec=importlib.util.spec_from_file_location('fractionation_source1138',p);m=importlib.util.module_from_spec(spec);sys.modules[spec.name]=m;spec.loader.exec_module(m)
expected=[]
for la,ha,lb,hb in itertools.product(range(1,5),repeat=4):
 s=m._partition(la,ha,lb,hb);a=s.ratio_a.fraction;b=s.ratio_b.fraction;f=s.factor.fraction;o='empty-One' if s.orientation==m.EMPTY_ONE else s.orientation.label
 expected.append(f'{la},{ha},{lb},{hb}:{a.numerator}/{a.denominator},{b.numerator}/{b.denominator},{f.numerator}/{f.denominator},{o}')
lines=(w/'fractionation1138_native.txt').read_text().splitlines();resource=json.loads(lines[-1]);assert resource['exit']==0 and resource['resource_stop'] is None;actual=lines[:-1];assert actual==expected, [(i,a,b) for i,(a,b) in enumerate(zip(actual,expected)) if a!=b][:3]
log=(w/'fractionation1138_audit.log').read_text();assert log.count('does not depend on any axioms')==23 and 'depends on axioms' not in log
native=w/'turn1064_recovery/SFT/Chemistry/EquilibriumIsotopeFractionation.lean'
report={'status':'PASS','source_commit':'76f1b34e9e9682989adcbb088797b4ae4ce4fcf1','source_sha256':hashlib.sha256(p.read_bytes()).hexdigest(),'native_sha256':hashlib.sha256(native.read_bytes()).hexdigest(),'positive_inventory_cases':256,'compared_fields':['ratio_a','ratio_b','factor','orientation'],'empty_axiom_declarations':23,'original_witnesses':8,'entry_complete':False}
(w/'fractionation1138_report.json').write_text(json.dumps(report,indent=2)+'\n');print(json.dumps(report))
