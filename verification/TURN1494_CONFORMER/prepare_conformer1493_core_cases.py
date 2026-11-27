from pathlib import Path
import sys,json,hashlib
w=Path('work');pin=w/'pinned_conformer1493';sys.path.insert(0,str((w/'v3-runtime500').resolve()))
import sft.chemistry
sft.chemistry.__path__=[str((pin/'sft/chemistry').resolve())]+list(sft.chemistry.__path__)
from sft.chemistry import conformer_generation_equivalence_law_v1 as v
from sft.engine.canonical import canonical_value
p=v.PositiveCount;label=v.HeldLabel;rows=[]
def record(name,fn):
 try: result={'ok':canonical_value(fn())}
 except (ValueError,IndexError,KeyError) as e:result={'error':str(e)}
 rows.append({'case':name,'result':result})
c=v.butane_four_site_census();record('original_butane_census',lambda:c)
record('original_six_witnesses',lambda:v.OPERATIONAL_WITNESSES)
record('empty_atoms',lambda:v.FiniteMolecularGraph((),()))
record('self_bond',lambda:v.FiniteMolecularGraph(c.graph.atom_types,((p(1),p(1)),)))
record('duplicate_reversed_bond',lambda:v.FiniteMolecularGraph(c.graph.atom_types,((p(1),p(2)),(p(2),p(1)))))
record('disconnected',lambda:v.FiniteMolecularGraph(c.graph.atom_types,((p(1),p(2)),(p(3),p(4)))))
record('incomplete_reversal',lambda:v.HeldTorsionAlphabet((v.ANTI,v.GAUCHE_FORWARD),((v.ANTI,v.ANTI),)))
record('duplicate_reversal_key_last_value',lambda:v.HeldTorsionAlphabet((v.ANTI,),((v.ANTI,v.GAUCHE_FORWARD),(v.ANTI,v.ANTI))))
record('empty_action',lambda:v.GraphAutomorphism(()))
record('duplicate_action_position',lambda:v.GraphAutomorphism((p(1),p(1))))
record('empty_rotor_product',lambda:v.generate_conformer_assignments(()))
record('original_cartesian_product',lambda:v.generate_conformer_assignments(c.alphabets))
for i,a in enumerate(c.automorphisms):
 for j,assignment in enumerate(c.generated_assignments):record(f'action_{i}_assignment_{j}',lambda a=a,assignment=assignment:v._apply_action(assignment,a,c.rotors,c.alphabets))
(w/'conformer1493_original_core_cases.json').write_text(json.dumps(rows,indent=2)+'\n')
print('Retained',len(rows),'original operation outcomes; native comparison pending')
