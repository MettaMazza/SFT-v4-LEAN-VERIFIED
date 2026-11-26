from pathlib import Path
import re
jobs=[('freeenergy1334','FreeEnergyEquivalentDirectionValidation','FreeEnergyEquivalentDirectionValidationProgram1334'),('activity1336','SolutionActivityValidation','SolutionActivityValidationProgram1336'),('gas1337','RealGasExchangeValidation','RealGasExchangeValidationProgram1337')]
for tag,mod,program in jobs:
 s=Path('work/prepare_rotational1323_native1406.py').read_text().replace("r=w/'execution1406_shadow'","r=w/'turn1064_recovery'").replace("out=w/'rotational1323_native1406'","out=w/'"+tag+"_empirical_native1413'").replace("visit('SFT.Chemistry.RotationalConstantValidation')","visit('SFT.Chemistry."+mod+"')").replace("w/'rotational1323_native_build1406.json'","w/'"+tag+"_empirical_native_build1413.json'").replace('RotationalConstantValidationProgram1323',program).replace('def source_comparison_complete():\n return False',"def source_comparison_complete():\n p=w/'"+tag+"_empirical_report.json'\n return p.exists() and json.loads(p.read_text()).get('status')=='PASS'")
 s=s.replace("'rotational1323_native_build1392.json']","'rotational1323_native_build1392.json','heatwork1331_program_native_build1413.json','phase1338_program_native_build1413.json']").replace('unchanged polarizability empirical runner','unchanged '+tag+' empirical runner').replace('Native polarizability empirical executable','Native '+tag+' empirical executable')
 Path('work/prepare_'+tag+'_empirical_native1413.py').write_text(s)
 s=Path('work/check_'+tag+'_empirical.py').read_text()
 pre="""native_build=json.loads((w/'TAG_empirical_native_build1413.json').read_text());assert native_build['status']=='PASS'
for row in native_build['modules']:
 assert hashlib.sha256(Path(row['source']).read_bytes()).hexdigest()==row['source_sha256'],row['module']
assert hashlib.sha256((w/'PROGRAM.lean').read_bytes()).hexdigest()==native_build['runner_sha256']
assert hashlib.sha256(Path(native_build['executable']).read_bytes()).hexdigest()==native_build['executable_sha256']
cmd=[sys.executable,'work/run_lean_guarded.py',native_build['executable']]
""".replace('TAG',tag).replace('PROGRAM',program)
 s,n=re.subn(r'^cmd=\[[^\n]+\]\n',lambda _:pre,s,count=1,flags=re.M);assert n==1
 for suffix in ['output.json','execution.log','report.json']:s=s.replace(tag+'_empirical_'+suffix,tag+'_empirical_native1413_'+suffix)
 s=s.replace(tag+'_original_empirical_current.json',tag+'_native1413_original_empirical_current.json')
 Path('work/check_'+tag+'_empirical_native1413.py').write_text(s)
