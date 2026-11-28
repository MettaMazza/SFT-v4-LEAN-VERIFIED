from pathlib import Path
import re,ast,json,hashlib
w=Path(__file__).resolve().parent;p=w.parents[1]/'reference/applications/chess-winning-d0b1996/constants/fold_chess_bot.ep';s=p.read_text();assert hashlib.sha256(p.read_bytes()).hexdigest()=='c61a908fd10b78c5934c47b0e93c55847235735d9fe0dc0108bb11a2e7419d7c'
names=['piece_is_white','piece_is_black','piece_kind','starting_state','empty_state','copy_state','square_attacked','king_square','side_in_check','make_move','push_move','push_pawn_move','pseudo_moves','legal_moves','perft','counted_reach','lesser_attacker_exists','attack_min_reach_map']
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
text='\n\n'.join(blocks);(w/'chess_reach1596_original_lowered.py').write_text(text+'\n')
class Division(ast.NodeTransformer):
 def visit_BinOp(self,node):
  node=self.generic_visit(node)
  return ast.copy_location(ast.Call(func=ast.Name(id='tdiv',ctx=ast.Load()),args=[node.left,node.right],keywords=[]),node)if isinstance(node.op,ast.Div)else node
ns={'create_list':lambda:[],'append_list':lambda xs,x:xs.append(x),'get_list':lambda xs,i:xs[i]if 0<=i<len(xs)else 0,'tdiv':lambda a,b:(abs(a)//abs(b))*(-1 if (a<0)!=(b<0)else 1)}
ns['set_list']=lambda xs,i,x:xs.__setitem__(i,x)if 0<=i<len(xs)else 0
ns['length_list']=len
exec(compile(ast.fix_missing_locations(Division().visit(ast.parse(text))),str(p),'exec'),ns)

ns['BLACK_REACH_BUF']=[];ns['WHITE_REACH_BUF']=[]
rows=[]
def emit(tag,state,full):
 for side in [0,1]:
  rows.append(tag+f' map {side} '+','.join(map(str,ns['attack_min_reach_map'](state,side))))
  if full:
   for sq in range(65):
    for threshold in [0,2,8,14,27]:rows.append(tag+f" lesser {side} {sq} {threshold} {int(ns['lesser_attacker_exists'](state,sq,threshold,side))}")
for code in range(12):
 for sq in range(64):
  state=ns['empty_state']();state[sq]=code+1;emit(f'piece {code+1} {sq}',state,False)
for i,c in enumerate(json.load(open(w/'chess_rules1596_fixtures.json'))):emit(f'fixture {i}',c['state'],True)
state=ns['starting_state']()
for step in range(80):
 emit(f'walk {step}',state,True);moves=ns['legal_moves'](state)
 if moves:state=ns['make_move'](state,moves[(step*17+3)%len(moves)])
(w/'chess_reach1596_original.log').write_text('\n'.join(rows)+'\n');print('Original rows',len(rows))
