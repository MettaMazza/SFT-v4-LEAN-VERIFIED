import ast,json,subprocess,pathlib
from fractions import Fraction
pin='76f1b34e9e9682989adcbb088797b4ae4ce4fcf1';v3='/Volumes/One Touch/ernos-labs-sft-platform';ns={'Fraction':Fraction}
selected={
 'sft/physics/structural_constants.py':['fold_part','first_return_trace','fold_word_support_count','positive_predecessor','generator_unit_part','generator_period_three'],
 'sft/physics/atomic_constants.py':['binary_count','positive_power','minimal_binary_cover','fine_structure_blocks'],
 'sft/physics/cosmology_prior_value_laws.py':['dark_baryon_structure'],
 'sft/physics/hubble_calibration_law.py':['hubble_calibration_structure']}
for path,names in selected.items():
 s=subprocess.check_output(['git','-C',v3,'show',pin+':'+path],text=True);t=ast.parse(s);nodes=[n for n in t.body if isinstance(n,ast.FunctionDef) and n.name in names];assert len(nodes)==len(names)
 t=ast.Module(body=[ast.ImportFrom(module='__future__',names=[ast.alias(name='annotations')],level=0)]+nodes,type_ignores=[]);exec(compile(ast.fix_missing_locations(t),path,'exec'),ns)
def normalize(x):
 if isinstance(x,Fraction):return [x.numerator,x.denominator]
 if isinstance(x,(list,tuple)):return [normalize(v) for v in x]
 if isinstance(x,dict):return {k:normalize(v) for k,v in x.items()}
 return x
actual=[json.loads(l) for l in pathlib.Path('work/cosmic_native.jsonl').read_text().splitlines()];expected=[normalize(ns[n]()) for n in ['dark_baryon_structure','hubble_calibration_structure']];assert actual==expected,(actual,expected)
r={'status':'PASS','source_commit':pin,'scope':'Every field of both original structure functions, including complete ordered first-return traces; fresh native Lean output compared to isolated unchanged pinned Python definitions. V3 used only as verification oracle, never as Lean execution or proof premise.','functions':['dark_baryon_structure','hubble_calibration_structure'],'fields':sum(len(x) for x in expected)};pathlib.Path('work/cosmic_source_report.json').write_text(json.dumps(r,indent=2));print(r)
