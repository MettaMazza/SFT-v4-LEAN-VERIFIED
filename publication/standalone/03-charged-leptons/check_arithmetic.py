import ast,json,hashlib
from fractions import Fraction as F
from pathlib import Path
from math import isqrt
from decimal import Decimal,getcontext
getcontext().prec=55
source_root=Path(__file__).resolve().parents[1]/'v3';p=source_root/'sft/physics/charged_lepton_validation.py';tree=ast.parse(p.read_text());wanted=['cubic','isolate_three_roots','bisect_root','squared_ratio_interval','source_interval','positive_sqrt_interval','koide_source_interval','predicted_ratio_interval','intervals_overlap','comparison_record'];module=ast.Module(body=[n for n in tree.body if isinstance(n,ast.FunctionDef) and n.name in wanted],type_ignores=[]);g={'Fraction':F,'Path':Path,'isqrt':isqrt,'exact_decimal':lambda s:F(s.replace(' ','')),'SOURCE_PATH':'experiments/external_sources/physics/snapshots/nist-codata-2022-allascii.txt'};exec(compile(module,str(p),'exec'),g)
a=F(3676744786,503846395469);corr=a**3/F(27)*(5+F(7,3)*a);prod=F(3,1454)-corr
assert corr==F(376926193013708290190758164816402371555272,5220085816185270244432584276275384668628413983201)
assert prod==F(15659709397871168801443815466454510956837000584115,7590004776733382935404977537704409308185713931574254)
root=source_root;before=g['comparison_record'](root);after=g['comparison_record'](root,prod);assert not before['all_rows_passed'] and after['all_rows_passed'];br=g['isolate_three_roots'](product=prod);assert br==((F(1,128),F(1,64)),(F(3,16),F(25,128)),(F(101,128),F(51,64)))
expected=[(F(2760006749688854416,13348308265544641),F(2760006753011508025,13348308034474884)),(F(164508926409,2766726569104),F(164509737604,2766723242409))]
for key,e in zip(['muon_electron','muon_tau'],expected):assert tuple(map(F,after[key]['predicted_interval']))==e
q=g['koide_source_interval'](root/g['SOURCE_PATH']);assert q[0]<F(2,3)<q[1]
dec=lambda x:str(Decimal(x.numerator)/Decimal(x.denominator))
r={'source_python_sha256':hashlib.sha256(p.read_bytes()).hexdigest(),'method':'Execute only original pure rational function ASTs, supplying declared Fraction, integer square root and exact decimal conversion; no source changes. Compare actual results to native retained endpoint declarations.','alpha':str(a),'correction':str(corr),'terminal_product':str(prod),'source_base_comparison':before,'source_terminal_comparison':after,'terminal_matches_native_endpoints':True,'terminal_isolation':[[str(x) for x in b] for b in br],'koide_source_interval':[str(x) for x in q],'koide_decimal_bounds':[dec(x) for x in q],'koide_contains_two_thirds':True,'terminal_decimal_predictions':{key:[dec(F(x)) for x in after[key]['predicted_interval']] for key in ['muon_electron','muon_tau']}}

# Central-value comparison uses the same original enclosure operation, separately from uncertainty propagation.
A=g['source_interval'](root/g['SOURCE_PATH'],'muon-electron mass ratio')[1]
B=g['source_interval'](root/g['SOURCE_PATH'],'muon-tau mass ratio')[1]
T=A/B
asqrt=g['positive_sqrt_interval'](A);tsqrt=g['positive_sqrt_interval'](T)
qc=((1+A+T)/(1+asqrt[1]+tsqrt[1])**2,(1+A+T)/(1+asqrt[0]+tsqrt[0])**2)
residual=tuple(x-F(2,3) for x in qc)
assert residual[0]<residual[1]<0 and qc[1]-qc[0]<F(1,10**45)
r['koide_central_comparison']={'A':str(A),'B':str(B),'T':str(T),'binary_depth':160,'Q_exact_outward_bounds':[str(x) for x in qc],'Q_decimal_bounds':[dec(x) for x in qc],'signed_residual_Q_minus_two_thirds_bounds':[str(x) for x in residual],'signed_residual_decimal_bounds':[dec(x) for x in residual],'relative_residual_decimal_bounds':[dec(x/F(2,3)) for x in residual],'Q_is_separate_from_full_uncertainty_interval':True}

dest=Path(__file__).resolve().parents[1];dest.mkdir(exist_ok=True);(dest/'arithmetic_check.json').write_text(json.dumps(r,indent=2)+'\n');print(json.dumps({k:v for k,v in r.items() if k not in ['koide_source_interval']},indent=2))
