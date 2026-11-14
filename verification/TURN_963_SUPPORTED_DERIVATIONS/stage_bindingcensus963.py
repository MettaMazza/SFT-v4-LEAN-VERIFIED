from pathlib import Path
import ast,json,sys,collections
w=Path('work');sys.path.insert(0,str((w/'v3-runtime500').resolve()))
p=w/'v3-runtime500/sft/physics/nuclear_binding_curve_successor_laws_v1.py';tree=ast.parse(p.read_text());nodes=[x for x in tree.body if isinstance(x,(ast.Import,ast.ImportFrom,ast.FunctionDef))];ns={'__name__':'original_binding_operations963'};exec(compile(ast.Module(body=nodes,type_ignores=[]),str(p),'exec'),ns)
candidates=ns['finite_peak_candidates']();counts=collections.Counter();rows=[]
for mass in range(2,ns['tail_cutoff_mass']()):
 n=1
 while True:
  lo,hi=ns['continuous_vertex_enclosure'](mass,n)
  if hi-lo<ns['residual_boundary_support']():break
  n+=1
 counts[n]+=1;rows.append(dict(mass=mass,refinements=n,charges=ns['possible_mass_maximizers'](mass)))
(w/'nuclearbindingcurve963_original_census.json').write_text(json.dumps(dict(candidates=candidates,masses=rows,refinement_distribution=dict(counts)),indent=2));print('PASS original census',len(candidates),'candidates; refinement distribution',dict(counts),flush=True)
