from pathlib import Path
import ast,json,hashlib
r=Path(__file__).resolve().parents[1];source=r/'reference/applications/discovery-SFT-v2/sftoe/usde.py';tree=ast.parse(source.read_text());out=r/'.lake/build/applications/discovery/work/inference1607';checks=[]
# Read literal prompt segments and substitute explicitly specified fixture strings only.
# This never imports or executes the original program or its methods.
def original_text(method,variable,substitutions):
 fn=next(n for n in ast.walk(tree)if isinstance(n,ast.FunctionDef)and n.name==method)
 value=next(n.value for n in ast.walk(fn)if isinstance(n,ast.Assign)and any(isinstance(t,ast.Name)and t.id==variable for t in n.targets))
 return ''.join(v.value if isinstance(v,ast.Constant)else substitutions[ast.unparse(v.value)]for v in value.values)
fn=next(n for n in ast.walk(tree)if isinstance(n,ast.FunctionDef)and n.name=='run_analytical_proof');ret=next(n for n in fn.body[::-1]if isinstance(n,ast.Return));keys=[ast.literal_eval(k)for k in ret.value.keys if ast.literal_eval(k).startswith('T')]
raw=json.dumps(dict(sector_m=3,coordinate_count=1,coordinates=['1/2'],eigenvalues=[1.0,2.0,4.0],invariants={k:'FAIL'if k=='T5_pair_law'else'PASS'for k in keys},physical_alignments=[]),indent=2)
expected={
'raw-data.json':raw,
'sweep-system.txt':original_text('generate_inference_report_sweep','system_prompt',{'master_text':'MASTER-FIXTURE'}),
'sector-system.txt':original_text('generate_inference_report','system_prompt',{'master_text':'MASTER-FIXTURE'}),
'sweep-prompt.txt':original_text('generate_inference_report_sweep','prompt',dict(sector_m='3',family='a/b*c',name='X/Y*Z',calc='2.000000',meas='2.000000',dev='0.0000',sig='5.00')),
'sector-prompt.txt':original_text('generate_inference_report','prompt',{'sector_m':'3','json.dumps(raw_data, indent=2)':raw})}
for name,text in expected.items():
 actual=(out/name).read_bytes();assert actual==text.encode(),name;checks.append(dict(path=name,sha256=hashlib.sha256(actual).hexdigest(),status='PASS'));print('PASS original-source literal/fixture bytes',name)
(out/'source_comparison.json').write_text(json.dumps(dict(source_sha256=hashlib.sha256(source.read_bytes()).hexdigest(),original_code_executed=False,checks=checks),indent=2)+'\n')
