from pathlib import Path
import subprocess,json,hashlib,sys,os,signal,shutil,datetime
w=Path('work');r=w/'turn1064_recovery';tag=sys.argv[1]
subprocess.run([sys.executable,'-u','work/prepare_'+tag+'_empirical_native1413.py'],check=True)
original=w/(tag+'_empirical_report.json')
if original.exists()and json.loads(original.read_text()).get('status')=='PASS':print('Original comparison finished; native execution unnecessary',flush=True);raise SystemExit(0)
subprocess.run([sys.executable,'work/check_'+tag+'_empirical_native1413.py'],check=True)
a=json.loads((w/(tag+'_empirical_native1413_report.json')).read_text());assert a['status']=='PASS'
for name,h in a['source_sha256'].items():assert hashlib.sha256((r/'SFT/Chemistry'/f'{name}.lean').read_bytes()).hexdigest()==h,name
assert json.loads((w/(tag+'_empirical_native1413_output.json')).read_text())==json.loads((w/(tag+'_native1413_original_empirical_current.json')).read_text())
b=json.loads((w/(tag+'_empirical_native_build1413.json')).read_text());a.update(execution_backend='compiled-native',compiled_build_receipt='work/'+tag+'_empirical_native_build1413.json',compiled_executable_sha256=b['executable_sha256'])
program={'freeenergy1334':'FreeEnergyEquivalentDirectionValidationProgram1334','activity1336':'SolutionActivityValidationProgram1336','gas1337':'RealGasExchangeValidationProgram1337','phase1338':'PhaseRuleValidationProgram1338','colligative1341':'ColligativeResponseValidationProgram1341','solvation1342':'SolvationDissolutionValidationProgram1342','diagram1340':'MulticomponentPhaseDiagramValidationProgram1340'}[tag]
rows={int(x[0]):x[1]for l in subprocess.check_output(['ps','-axo','pid,command'],text=True).splitlines()[1:]if len(x:=l.strip().split(None,1))==2};stopped=[]
for pid,cmd in rows.items():
 if cmd.endswith(' work/check_'+tag+'_empirical.py'):os.kill(pid,signal.SIGTERM);stopped.append(pid)
for pid,cmd in rows.items():
 if cmd.startswith(str(Path.home()/'.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean')+' ')and '--run work/'+program+'.lean' in cmd:os.killpg(pid,signal.SIGTERM);stopped.append(pid)
backup=w/(tag+'_pre_native_adoption1413');backup.mkdir(exist_ok=True)
for orig,verified in [(tag+'_empirical_output.json',tag+'_empirical_native1413_output.json'),(tag+'_empirical_execution.log',tag+'_empirical_native1413_execution.log'),(tag+'_original_empirical_current.json',tag+'_native1413_original_empirical_current.json')]:
 dest=w/orig
 if dest.exists():shutil.copyfile(dest,backup/orig)
 tmp=dest.with_suffix(dest.suffix+'.native-adopt');shutil.copyfile(w/verified,tmp);tmp.replace(dest)
tmp=original.with_suffix('.native-adopt');tmp.write_text(json.dumps(a,indent=2)+'\n');tmp.replace(original)
receipt=dict(status='PASS',tag=tag,stopped_superseded_pids=stopped,source_sha256=a['source_sha256'],actual_fields=a['fields'],messages=a['messages'],at=datetime.datetime.now(datetime.timezone.utc).isoformat());(w/(tag+'_native_adoption1413.json')).write_text(json.dumps(receipt,indent=2)+'\n');print('ADOPTED verified complete source-bound result',json.dumps(receipt),flush=True)
