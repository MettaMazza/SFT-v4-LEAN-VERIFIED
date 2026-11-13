from pathlib import Path
import ast,json,subprocess
r=Path('work/constants-recovery');pin='76f1b34e9e9682989adcbb088797b4ae4ce4fcf1';src=subprocess.check_output(['git','-C','/Volumes/One Touch/ernos-labs-sft-platform','show',pin+':sft/mathematics/lineage_laws.py'],text=True);tree=ast.parse(src);node=next(n for n in tree.body if isinstance(n,ast.Assign) and any(isinstance(t,ast.Name) and t.id=='BOUNDED_N_BODY' for t in n.targets));kw={x.arg:x.value for x in node.value.keywords};dims=[]
for d in kw['dimensions'].elts:
 key,bad,reason,good,goodreason=map(ast.literal_eval,d.args);dims.append((key,key.replace('_',' ')+'?',bad,reason,good,goodreason))
s=Path('work/unit_grammar480.py').read_text();s=s[s.index("cs={'SURVIVOR'"):];s=s.replace('«work».UnitCarrier480','SFT.Mathematics.BoundedFoldTransient').replace('SFT.Physics.UnitGrammar','SFT.Mathematics.BoundedNBodyGrammar').replace('SFT/Physics/UnitGrammar.lean','SFT/Mathematics/BoundedNBodyGrammar.lean').replace('work/UnitGrammar480.lean','work/constants-recovery/SFT/Mathematics/BoundedNBodyGrammar.lean').replace('memMap _ extension _ hextension','memMap _ addition _ haddition');exec(s)
