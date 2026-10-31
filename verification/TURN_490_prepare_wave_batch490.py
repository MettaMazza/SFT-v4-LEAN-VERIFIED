from pathlib import Path
import re,json
entries=[(s,k,'Wave'+s) for s,k in [('Superposition','SUPERPOSITION'),('Interference','INTERFERENCE'),('Diffraction','DIFFRACTION'),('Polarization','POLARIZATION'),('Dispersion','DISPERSION'),('Resonance','RESONANCE'),('EnergyMomentum','ENERGY_MOMENTUM')]]
scopes={
'Superposition':'Complete disjoint labelled junction of original wave traces; both full branch projections, injection, no cross-branch collision, exact occurrence count and reconstruction.',
'Interference':'Common-cell phase-labelled predecessor merging by the existing exact Fold scalar arithmetic; matching support addition, opposed held remainder and exact closure, preserving both full predecessors.',
'Diffraction':'Exact aperture membership, complete retained-path successor generation, both reachability directions, exclusion of closed paths and causal adjacency for actual propagation outputs.',
'Polarization':'Held transverse recurrence orientation with full original electromagnetic carrier; reversal involution, distinct held labels, unchanged energy, momentum magnitude, recurrence, frequency and transverse role.',
'Dispersion':'Complete recurrence-label-indexed registered support responses, exact per-label wavelength/frequency propagation ratio, causal path and full phase retention; distinct registered path timings remain distinct over positive repeated support counts.',
'Resonance':'Original driver and supported recurrence paths, exact common refinement, positive least shared return, divisibility of every aligned return, exact phase mismatch exclusion and complete repeated aligned transfer records.',
'EnergyMomentum':'Full radiation carrier paired at source and remote response along its complete causal path, unchanged exact work and momentum, held propagation orientation, complete path recovery and closed network conservation.'}
s=Path('work/prepare_wave489.py').read_text().replace('489','490')
s=re.sub(r'entries=\[.*?\];metadata=\{\}', 'entries='+repr(entries)+';metadata={}',s,count=1)
s=s.replace("'PERIOD_FREQUENCY','PROPAGATION','SPEED_LENGTH_FREQUENCY'}", "'PERIOD_FREQUENCY','PROPAGATION','SPEED_LENGTH_FREQUENCY','SUPERPOSITION','INTERFERENCE','DIFFRACTION','POLARIZATION','DISPERSION','RESONANCE','ENERGY_MOMENTUM'}")
Path('work/prepare_wave490.py').write_text(s)
for name in ['build_wave','run_wave','register_wave']:
 s=Path('work/'+name+'489.py').read_text().replace('489','490')
 if name=='run_wave':
  s=s.replace("subprocess.run(['/Users/dolltrading/.elan/bin/leanc','-c'", "common += "+repr(['SFT/Physics/'+c for _,_,c in entries])+"\nsubprocess.run(['/Users/dolltrading/.elan/bin/leanc','-c'",1)
 if name=='register_wave':
  s=re.sub(r"key=\{.*?\}\[stem\];component=\{.*?\}\[stem\]",'key='+repr({s:k for s,k,c in entries})+'[stem];component='+repr({s:c for s,k,c in entries})+'[stem]',s,count=1)
  a=s.index('scopes=');b=s.index('\nfor rel in modules:',a);s=s[:a]+'scopes='+repr(scopes)+s[b:]
  s=s.replace('TURN_488_REGISTERED_DECLARATIONS_AUDIT','TURN_489_REGISTERED_DECLARATIONS_AUDIT')
 Path('work/'+name+'490.py').write_text(s)
Path('work/field490_initializer_bridge.c').write_text(Path('work/field489_initializer_bridge.c').read_text())
Path('work/wave490_scopes.json').write_text(json.dumps(scopes,indent=2))
