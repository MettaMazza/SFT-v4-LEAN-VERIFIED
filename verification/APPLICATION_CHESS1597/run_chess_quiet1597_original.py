from pathlib import Path
import re,ast,json,hashlib
w=Path(__file__).resolve().parent;p=w.parents[1]/'reference/applications/chess-winning-d0b1996/constants/fold_chess_bot.ep';s=p.read_text();assert hashlib.sha256(p.read_bytes()).hexdigest()=='c61a908fd10b78c5934c47b0e93c55847235735d9fe0dc0108bb11a2e7419d7c'
names=['piece_is_white','piece_is_black','piece_kind','starting_state','empty_state','copy_state','square_attacked','king_square','side_in_check','make_move','push_move','push_pawn_move','pseudo_moves','legal_moves','perft','counted_reach','lesser_attacker_exists','attack_min_reach_map','mobility_count','pawn_promotion_potential','side_units','share_numerator','share_denominator','move_is_capture','ordered_moves','could_check_from','quiescence','tt_key','tt_ensure']
# Execute the selected original EP statements through direct syntax lowering;
# do not use the stale checked-in C artifact as the winning source oracle.
blocks=[]
for name in names:
 m=re.search(r'^define '+name+r'[^\n]*\n(.*?)(?=^define |\Z)',s,re.M|re.S);assert m,name
 lines=m.group(0).splitlines();header=lines[0];params=[]
 if ' with ' in header:
  params=[x.strip().split()[0]for x in header.split(' with ',1)[1].split(' returning ')[0].rstrip(':').split(' and ')]
 out=['def '+name+'('+','.join(params)+'):']
 for line in lines[1:]:
  if not line.strip() or line.lstrip().startswith('#'):continue
  if not line.startswith(' '):continue
  line=re.sub(r'^(\s*)set (\w+) to ',r'\1\2 = ',line).replace('repeat while ','while ').replace(' and ',', ').replace('true','True').replace('false','False')
  out.append(line)
 blocks.append('\n'.join(out))
text='\n\n'.join(blocks);text=text.replace('def quiescence(state,alpha_num,alpha_den,beta_num,beta_den,fresh):','def quiescence(state,alpha_num,alpha_den,beta_num,beta_den,fresh):\n    global NODES_LEFT, PASS_ABORTED');(w/'chess_quiet1597_original_lowered.py').write_text(text+'\n')
class Division(ast.NodeTransformer):
 def visit_BinOp(self,node):
  node=self.generic_visit(node)
  return ast.copy_location(ast.Call(func=ast.Name(id='tdiv',ctx=ast.Load()),args=[node.left,node.right],keywords=[]),node)if isinstance(node.op,ast.Div)else node
ns={'create_list':lambda:[],'append_list':lambda xs,x:xs.append(x),'get_list':lambda xs,i:xs[i]if 0<=i<len(xs)else 0,'tdiv':lambda a,b:(abs(a)//abs(b))*(-1 if (a<0)!=(b<0)else 1)}
ns['set_list']=lambda xs,i,x:xs.__setitem__(i,x)if 0<=i<len(xs)else 0
ns['length_list']=len
exec(compile(ast.fix_missing_locations(Division().visit(ast.parse(text))),str(p),'exec'),ns)

ns['BLACK_REACH_BUF']=[];ns['WHITE_REACH_BUF']=[]
ns.update(TT_KEYS=[],TT_MOVES=[],TT_STAMP=[],KILLER_A=[],KILLER_B=[],TT_GEN=0,NODES_LEFT=0,PASS_ABORTED=0)
rows=[]
ns['tt_ensure']();rows.append(f"ensure {len(ns['TT_KEYS'])} {len(ns['TT_MOVES'])} {len(ns['TT_STAMP'])} {len(ns['KILLER_A'])} {len(ns['KILLER_B'])} {ns['KILLER_A'][63]}")
ns['tt_ensure']();rows.append(f"ensure2 {len(ns['TT_KEYS'])} {len(ns['KILLER_A'])}")
def emit(tag,state):
 rows.append(tag+f" key {ns['tt_key'](state)}")
 for budget in [-1,0,1,16,256]:
  for fresh in [0,1]:
   for an,ad,bn,bd in [(0,1,1,1),(1,2,1,2),(3,4,1,4)]:
    ns['NODES_LEFT']=budget;ns['PASS_ABORTED']=0
    value=ns['quiescence'](state,an,ad,bn,bd,fresh)
    rows.append(tag+f" q {budget} {fresh} {an} {ad} {bn} {bd} {value} {ns['NODES_LEFT']} {ns['PASS_ABORTED']}")
for i,c in enumerate(json.load(open(w/'chess_rules1596_fixtures.json'))):emit(f'fixture {i}',c['state'])
state=ns['starting_state']()
for step in range(12):
 emit(f'walk {step}',state);moves=ns['legal_moves'](state)
 if moves:state=ns['make_move'](state,moves[(step*17+3)%len(moves)])
state=ns['starting_state']();state[70]=100;emit('clock',state)
(w/'chess_quiet1597_original.log').write_text('\n'.join(rows)+'\n');print('rows',len(rows))
