from pathlib import Path
import re,json,shutil
entries=[('PhysicalState','PHYSICAL_STATE','QuantumPhysicalState'),('Evolution','EVOLUTION','QuantumPhysicalEvolution'),('Observable','OBSERVABLE','QuantumPhysicalObservable'),('Weight','WEIGHT','QuantumPhysicalWeight')]
scopes={
'PhysicalState':'Complete generated Fold word support with its original nontrivial phase cycle, distinct word admission, full source identity and preparation record; exact generated support and complete branch reconstruction.',
'Evolution':'Actual original successful gate schedule on the admitted physical state, exact reverse-order inverse derivation, all predecessor states and complete branch traces, support count and preparation preservation.',
'Observable':'Original total classification and retained observation record; exact selected fibre, every original branch classified, closed alternatives retained, full initial state and preparation reconstruction.',
'Weight':'Exact positive selected-predecessor/whole-support count ratio from the original observation, full record count, selected-count bound, normalized cross-product identity and uniqueness with no fitted values.'}
s=Path('work/prepare_wave490.py').read_text().replace('490','491').replace('wave491','quantum491').replace("'WAVE-'","'QUANTUM-'").replace('SFT-PHYS-WAVE-','SFT-PHYS-QUANTUM-')
s=re.sub(r'entries=\[.*?\];metadata=\{\}','entries='+repr(entries)+';metadata={}',s,count=1)
a=s.index("  if part=='spec':");b=s.index("\n  Path('work/'+low",a)
s=s[:a]+'''  if part=='spec':
   s=s.replace("'sft/physics/measurement_laws.py',{'SOURCE_PATH','SOURCE_HASH','SOURCE_ID','BASE_DEPENDENCIES','targets','spec','"+key+"'}", "'sft/physics/measured_value.py',{'CODATA_SOURCE_ID','CODATA_SOURCE_PATH','CODATA_SOURCE_HASH'}),('sft/physics/quantum_physics_laws.py',{'SOURCES','BASE','quantum_law','PHYSICAL_STATE','EVOLUTION','OBSERVABLE','WEIGHT','INCOMPATIBILITY','SPIN'}")'''+s[b:]
s=s.replace('decide ((("a","b","a") : String × String × String).1 = (("a","b","a") : String × String × String).2.2)','decide ((["a","b"] : List String).length = 2)').replace('forward-held','phase-a').replace('reverse-held','phase-b')
Path('work/prepare_quantum491.py').write_text(s)
s=Path('work/build_wave490.py').read_text().replace('wave490','quantum491');Path('work/build_quantum491.py').write_text(s)
s=Path('work/run_wave489.py').read_text().replace('489','491').replace('wave491','quantum491').replace('SFT-PHYS-WAVE-','SFT-PHYS-QUANTUM-').replace("'work/register_wave491.py'","'work/register_quantum491.py'")
s=s.replace("subprocess.run(['/Users/dolltrading/.elan/bin/leanc','-c'","common += "+repr(['SFT/Physics/'+c for _,_,c in json.load(open('work/wave490_entries.json'))]+['SFT/Physics/'+c for _,_,c in entries])+"\ncommon += ['SFT/Mathematics/LeastCommonReturn']\nsubprocess.run(['/Users/dolltrading/.elan/bin/leanc','-c'",1)
# Audit config is refreshed by this new family; prior global registered audit is used by the registrar.
Path('work/run_quantum491.py').write_text(s)
s=Path('work/register_wave490.py').read_text().replace('490','491').replace('SFT-PHYS-WAVE-','SFT-PHYS-QUANTUM-').replace('wave491','quantum491').replace('sft/physics/wave_laws.py','sft/physics/quantum_physics_laws.py')
s=re.sub(r"key=\{.*?\}\[stem\];component=\{.*?\}\[stem\]",'key='+repr({s:k for s,k,c in entries})+'[stem];component='+repr({s:c for s,k,c in entries})+'[stem]',s,count=1)
a=s.index('scopes=');b=s.index('\nfor rel in modules:',a);s=s[:a]+'scopes='+repr(scopes)+s[b:];s=s.replace('TURN_489_REGISTERED_DECLARATIONS_AUDIT','TURN_490_REGISTERED_DECLARATIONS_AUDIT');Path('work/register_quantum491.py').write_text(s)
Path('work/field491_initializer_bridge.c').write_text(Path('work/field490_initializer_bridge.c').read_text())
Path('work/quantum491_scopes.json').write_text(json.dumps(scopes,indent=2))
# Copy only missing local source dependencies from the authoritative completed tree.
root=Path('/Volumes/One Touch/SFT v4 Full model LEAN');dest=Path('work/constants-recovery');seen=set();copied=[]
def visit(rel):
 if rel in seen:return
 seen.add(rel);p=dest/rel
 if not p.exists():
  src=root/rel;assert src.exists(),rel;p.parent.mkdir(parents=True,exist_ok=True);shutil.copy2(src,p);copied.append(rel)
 for m in re.findall(r'^import (SFT\.\S+)',p.read_text(),re.M):visit(m.replace('.','/')+'.lean')
for _,_,m in entries:visit('SFT/Physics/'+m+'.lean')
Path('work/quantum491_recovery_sources.json').write_text(json.dumps(copied,indent=2));print('copied',len(copied),'unchanged prerequisite sources')
