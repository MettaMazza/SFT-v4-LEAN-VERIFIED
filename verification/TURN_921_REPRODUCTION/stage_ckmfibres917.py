from pathlib import Path
w=Path('work');r=w/'constants-recovery'
s=(w/'prepare_quarkdressing916.py').read_text().replace('QUARK_DRESSING_SPEC','CKM_FIBRE_SPEC').replace('quarkdressing916','ckmfibres917').replace('quarkdressing_witness916','ckmfibres_witness917').replace('QuarkDressingEntry','CKMFibreEntry').replace('QuarkDressing','CKMFibres').replace('factorsCheck','matrixCheck')
a=s.index('def matrixCheck : Bool :=');b=s.index('def witnesses',a);s=s[:a]+'''def matrixCheck : Bool := match ckmFibres with
 | .error _ => false
 | .ok f => decide (f.matrix=originalRecord.matrix)
'''+s[b:];(w/'prepare_ckmfibres917.py').write_text(s)
for kind in ['entry','program','independent','original']:
 s=(w/f'check_quarkdressing_{kind}916.py').read_text().replace('916','917').replace('quarkdressing','ckmfibres').replace('QuarkDressingEntry','CKMFibreEntry').replace('QuarkDressing','CKMFibres').replace('MATTER-QUARK-DRESSING','MATTER-CKM-FIBRE').replace('QUARK_DRESSING_SPEC','CKM_FIBRE_SPEC');(w/f'check_ckmfibres_{kind}917.py').write_text(s)
s=(w/'prepare_quarkdressing_native916.py').read_text().replace('916','917').replace('QuarkDressingEntry','CKMFibreEntry').replace('QuarkDressingProgram','CKMFibresProgram');(w/'prepare_ckmfibres_native917.py').write_text(s)
(r/'CKMFibresProgram917.lean').write_text((r/'QuarkDressingProgram916.lean').read_text().replace('QuarkDressingEntry','CKMFibreEntry'))
