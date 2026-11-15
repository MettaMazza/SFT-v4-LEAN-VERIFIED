from pathlib import Path
import os,subprocess,json,re
w=Path('work');r=Path('/Volumes/One Touch/SFT v4 Full model LEAN');schema=json.loads((w/'calculator1025_argument_schema.json').read_text());lean='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean';env={**os.environ,'LEAN_PATH':str(r/'.lake/build/lib/lean')}
code='''import SFT.Mathematics.CalculatorCompleteLaunchers
open SFT.Mathematics SFT.Host.Canonical CalculatorCompleteLaunchers
def encode : Step → Value
 | .changeDirectory p => .array [.text "cd",.text p]
 | .command args replace => .array [.text "command",.array (args.map Value.text),.boolean replace]
 | .exit n => .array [.text "exit",.integer (.ofNat n)]
#eval IO.println (render CalculatorCompleteTerminal.argumentSchema)
#eval IO.println (render (.array (sourceFiles.map fun (a,b) => .array [.text a,.text b])))
#eval IO.println (render (.array ([false,true].map fun b => .array ((posixLaunch b).map encode))))
#eval IO.println (render (.array (([-1,0,1,2] : List Int).map fun i => .array ((windowsLaunch i).map encode))))
''';p=w/'calculator1025_launchers_check.lean';p.write_text(code);x=subprocess.run([lean,str(p)],env=env,capture_output=True,text=True);(w/'calculator1025_launchers_check.log').write_text(x.stdout+x.stderr);assert x.returncode==0,x.stdout;rows=[json.loads(x)for x in x.stdout.splitlines()];assert rows[0]==schema
for name,text in rows[1]:assert text==subprocess.check_output(['git','-C','/Volumes/One Touch/ernos-labs-sft-platform','show','76f1b34e9e9682989adcbb088797b4ae4ce4fcf1:'+name]).decode()
assert rows[2]==[[['cd','$SCRIPT_DIR/..'],['exit',1]],[['cd','$SCRIPT_DIR/..'],['command',['python3','-m','sft.mathematics.calculator_complete','--gui'],True]]]
for i,row in zip([-1,0,1,2],rows[3]):assert row==[['cd','%~dp0\\..'],['command',['py','-3','-m','sft.mathematics.calculator_complete','--gui'],False]]+([['command',['python','-m','sft.mathematics.calculator_complete','--gui'],False]]if i>=1 else [])
s=(r/'SFT/Mathematics/CalculatorCompleteLaunchers.lean').read_text();names=re.findall(r'^def (\w+)',s,re.M);p=w/'calculator1025_launchers_audit.lean';p.write_text('import SFT.Mathematics.CalculatorCompleteLaunchers\n'+''.join('#print axioms SFT.Mathematics.CalculatorCompleteLaunchers.'+n+'\n'for n in names));x=subprocess.run([lean,str(p)],env=env,capture_output=True,text=True);(w/'calculator1025_launchers_audit.log').write_text(x.stdout+x.stderr);assert x.returncode==0 and x.stdout.count('does not depend on any axioms')==len(names),x.stdout
(w/'calculator1025_launchers_report.json').write_text(json.dumps(dict(status='PASS',exact_argument_schema=True,exact_source_launchers=3,launch_control_paths=6,declarations=names,axioms=[],scope='Original launcher command/control semantics and exact source bytes; this is not a claim of executing Windows on macOS.'),indent=2));print('PASS complete argument schema and original launcher control paths')
