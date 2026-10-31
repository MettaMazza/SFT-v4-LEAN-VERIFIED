from pathlib import Path
import subprocess,os,time,re,json,ast,hashlib
r=Path('work/constants-recovery').resolve();out=Path('work/native486').resolve();out.mkdir(exist_ok=True);env=dict(os.environ,LEAN_PATH=str(r/'.lake/build/lib/lean'));lean='/Users/dolltrading/.elan/bin/lean';leanc='/Users/dolltrading/.elan/bin/leanc'
assert json.load(open('work/generator486/report.json'))['status']=='PASS'
cs=re.findall(r'^import SFT.Physics.(HubbleCensus\d+)',(r/'SFT/Physics/HubbleGrammar.lean').read_text(),re.M)
modules=['HubbleGrammarBase']+cs+['HubbleGrammar','HubbleWitnesses','HubbleControls','HubbleEvidence']
for i,m in enumerate(modules):
 if (out/(m+'.o')).exists():
  print('RETAINED',m,flush=True)
  continue
 start=time.monotonic()
 with (out/(m+'.log')).open('w') as f:
  subprocess.run([lean,'-j','1','-M','4096','-c',str(out/(m+'.c')),str(r/'SFT/Physics'/(m+'.lean'))],env=env,stdout=f,stderr=subprocess.STDOUT,check=True)
  subprocess.run([leanc,'-O3','-c',str(out/(m+'.c')),'-o',str(out/(m+'.o'))],stdout=f,stderr=subprocess.STDOUT,check=True)
 print('COMPILED',i+1,len(modules),m,round(time.monotonic()-start,2),flush=True)
with (out/'main_compile.log').open('w') as f:subprocess.run([lean,'-j','1','-M','1024','-c',str(out/'HubbleProgram.c'),str(r/'HubbleProgram.lean')],env=env,stdout=f,stderr=subprocess.STDOUT,check=True)
p=out/'HubbleProgram.c';s=p.read_text();s=s.replace('lean_object* initialize_SFT_Physics_HubbleEvidence(uint8_t builtin);','lean_object* initialize_SFT_Physics_FoldFirstReturn(uint8_t builtin);\nlean_object* initialize_SFT_Physics_HubbleEvidence(uint8_t builtin);');s=s.replace('res = initialize_SFT_Physics_HubbleEvidence(builtin);','res = initialize_SFT_Physics_FoldFirstReturn(builtin);\nif (lean_io_result_is_error(res)) return res;\nlean_dec_ref(res);\nres = initialize_SFT_Physics_HubbleEvidence(builtin);');p.write_text(s)
# Reuse the exact successful native link, including both proved-equivalent identity namespaces.
s=Path('work/link_dark_complete483.py').read_text();s=s[:s.index("s=Path('work/check_dark")];s=s.replace("[str(r/(m+'.o')) for m in ['CosmicRatios','DarkBaryonGrammar','DarkBaryonWitnesses','DarkBaryonControls','DarkBaryonEvidence']]","[str(r/'CosmicRatios.o')]+[str(Path('work/native486').resolve()/(m+'.o')) for m in "+repr(modules)+"]");s=s.replace('work/native483/DarkBaryonProgram.c','work/native486/HubbleProgram.c').replace('work/native483/DarkBaryonProgramCompleteWindow','work/native486/HubbleProgram');Path('work/link_hubble486.py').write_text(s)
with (out/'link.log').open('w') as f:subprocess.run(['python3','work/link_hubble486.py'],stdout=f,stderr=subprocess.STDOUT,check=True)
s=Path('work/check_hubble_program394.py').read_text();a=s.index('out=subprocess.check_output');b=s.index(';actual=json.loads(out)',a);s=s[:a]+"out=subprocess.check_output([str(Path('work/native486/HubbleProgram').resolve()),source],cwd=Path.cwd(),text=True)"+s[b:];s=s.replace('hubble_program_output.json','hubble_native486_output.json').replace('hubble_program_report.json','hubble_native486_report.json');Path('work/check_hubble_native486.py').write_text(s)
subprocess.run(['python3','work/check_hubble_native486.py'],check=True)
print('FRESH HUBBLE PROGRAM PASS; independent validation and registration next',flush=True)
