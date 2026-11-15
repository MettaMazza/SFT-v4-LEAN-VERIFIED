from pathlib import Path
import sys,json,subprocess,os,re,hashlib
w=Path('work');r=Path('/Volumes/One Touch/SFT v4 Full model LEAN');sys.path.insert(0,str((w/'v3-runtime500').resolve()));from sft.physics import static_exterior_clock_terminal_law_v1 as src
from sft.engine.canonical import canonical_value
s=(w/'constants-recovery/StaticCore982.lean').read_text();s=s[:s.index('def remainderResult')].replace('import SFT.Physics.StaticExteriorClock','import SFT.Physics.StaticExteriorClockCertificate').replace('open SFT.Physics.StaticExteriorClock','open SFT.Physics.StaticExteriorClockCertificate SFT.Physics.StaticExteriorClock')
s+='''def certificateValue (c : Certificate) : Value := .object [("mass",frac c.mass),("horizon",frac c.horizon),("boundary",stateValue c.boundary),("rows",.array (c.rows.map stateValue)),("all_exterior_coefficients_positive",.boolean c.allExteriorCoefficientsPositive),("all_fluxes_equal_horizon",.boolean c.allFluxesEqualHorizon),("all_well_radius_products_equal_horizon",.boolean c.allWellRadiusProductsEqualHorizon),("all_complements_complete_One",.boolean c.allComplementsCompleteOne),("well_halves_each_successor",.boolean c.wellHalvesEachSuccessor),("field_quarters_each_successor",.boolean c.fieldQuartersEachSuccessor),("coefficient_increases_each_successor",.boolean c.coefficientIncreasesEachSuccessor),("horizon_clock_record_empty",.boolean c.horizonClockRecordEmpty),("exact_clock_pair",clockValue c.exactClockPair),("weak_field_successor",.text c.weakFieldSuccessor),("general_flux_identity",.text c.generalFluxIdentity),("general_coefficient_identity",.text c.generalCoefficientIdentity),("physical_unit_conversion_not_formal_input",.boolean c.physicalUnitConversionNotFormalInput),("negative_zero_irrational_or_imaginary_proof_scalar_used",.boolean c.forbiddenProofScalarUsed)]
def result : Except String Certificate → Value | .ok c => certificateValue c | .error e => .object [("error",.text e)]
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
#eval IO.println (render (.array [
''';tests=[False,True,-3,0,1,2,3,5,10,12,20];expected=[];expr=[]
for depth in tests:
 expr.append('result (exteriorCertificate ('+('.boolean '+str(depth).lower() if isinstance(depth,bool) else '.integer ('+str(depth)+')')+'))')
 try:expected.append(canonical_value(src.exterior_certificate(depth)))
 except ValueError as e:expected.append({'error':str(e)})
s+=',\n'.join(expr)+']))\n';p=w/'constants-recovery/StaticCertificate982.lean';p.write_text(s);out=subprocess.check_output(['/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean','-j1',str(p)],env={**os.environ,'LEAN_PATH':str(r/'.lake/build/lib/lean')},text=True);actual=json.loads(out);expected=json.loads(json.dumps(expected));assert actual==expected,[i for i,(a,e) in enumerate(zip(actual,expected)) if a!=e]
mods=['StaticExteriorClock','StaticExteriorClockCertificate'];names=[];hashes={};audit=''.join('import SFT.Physics.'+m+'\n' for m in mods)
for m in mods:
 p=r/f'SFT/Physics/{m}.lean';s=p.read_text();hashes[m]=hashlib.sha256(s.encode()).hexdigest();names+=['SFT.Physics.'+m+'.'+n for n in re.findall(r'^(?:def|theorem) (\w+)',s,re.M)];(w/'constants-recovery/SFT/Physics'/p.name).write_text(s)
audit+=''.join('#print axioms '+n+'\n' for n in names);p=w/'static982_certificate_audit.lean';p.write_text(audit);out=subprocess.check_output(['/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean',str(p)],env={**os.environ,'LEAN_PATH':str(r/'.lake/build/lib/lean')},text=True);(w/'static982_certificate_audit.log').write_text(out);assert all("'"+n+"' does not depend on any axioms" in out for n in names)
(w/'static982_certificate_report.json').write_text(json.dumps(dict(status='PASS',cases=len(tests),all18fields=True,axioms=[],declarations=names,source_sha256=hashes),indent=2));print('PASS',len(tests),'complete18fieldcertificates/guards;',len(names),'emptydeclarations')
