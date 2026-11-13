from pathlib import Path
import os,subprocess,json,sys,ast,hashlib
w=Path('work');source=Path('/Volumes/One Touch/ernos-labs-sft-platform');sys.path.insert(0,str(source))
relative='sft/mathematics/dynamical_systems/law.py'
raw=subprocess.check_output(['git','-C',str(source),'show','76f1b34e9e9682989adcbb088797b4ae4ce4fcf1:'+relative])
assert raw==(source/relative).read_bytes()
node=next(x for x in ast.parse(raw).body if isinstance(x,ast.FunctionDef) and x.name=='reversible_with_record')
namespace={};exec(compile(ast.Module(body=[node],type_ignores=[]),relative,'exec'),namespace)
reversible_with_record=namespace['reversible_with_record']
merge=(('a','terminal'),('b','terminal'),('terminal','terminal'))
cases=[(merge,merge),(merge,(('a','terminal'),)),(merge,merge+(('a','terminal'),)),((('a','a'),),(('a','a'),))]
expected=[reversible_with_record(*x) for x in cases]
r=subprocess.run(['/Users/dolltrading/.elan/bin/lean',str(w/'PiezoSource848.lean')],capture_output=True,text=True,env=dict(os.environ,LEAN_PATH=str((w/'constants-recovery/.lake/build/lib/lean').resolve())));r.check_returncode();actual=[x=='true' for x in r.stdout.strip().split(',')];assert len(actual)==4 and actual==expected,(actual,expected,r.stdout)
out={'status':'PASS','source_operation':'sft/mathematics/dynamical_systems/law.py:reversible_with_record','cases':['complete merged predecessors','omitted predecessor','duplicate retained row','identity'],'expected':expected,'actual':actual,'execution':'Exact pinned pure-function AST; not a replay of the engine seal. Direct package import rejected AppleDouble engine files, retained unchanged.', 'source_sha256':hashlib.sha256(raw).hexdigest(),'scope':'Original retained-record criterion; does not equate retained-history recovery with singleton-fibre output inversion.'};(w/'piezo_source848_report.json').write_text(json.dumps(out,indent=2)+'\n');print(out)
