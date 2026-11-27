from pathlib import Path
w=Path('work');s=(w/'generate_addition1502_witness_graphs.py').read_text();start=s.index('results=[');end=s.index('q=lambda')
s=s[:start]+'''sft.chemistry.__path__.insert(0,str((w/'pinned_elimination1503/sft/chemistry').resolve()))
from sft.chemistry import elimination_reaction_law_v1 as elim
results=[('Same',elim._addition_witness('same')),('Adjacent',elim._addition_witness('adjacent')),('Nonadjacent',elim._addition_witness('nonadjacent'))]
base=results[2][1];ext=AdditionBond(base.source.atoms[1],atom('elim-successor-atom'),support('elim-successor-support'))
a=AdditionState(HeldLabel('addition-state',base.source.identity.label+'-successor'),base.source.atoms+(ext.right,),base.source.bonds+(ext,),base.source.free_supports)
b=AdditionState(HeldLabel('addition-state',base.terminal.identity.label+'-successor'),base.terminal.atoms+(ext.right,),base.terminal.bonds+(ext,),base.terminal.free_supports)
results.append(('Successor',v.forced_complete_addition_transform(base.reaction_identity,a,b)))
'''+s[end:]
s=s.replace('AdditionWitnessGraphs','EliminationWitnessGraphs').replace('addition1502_witness_graphs.json','elimination1503_witness_graphs.json')
exec(compile(s,'elimination_graphs','exec'))
