from pathlib import Path
import re,ast,json,hashlib
w=Path(__file__).resolve().parent;p=w.parents[1]/'reference/applications/chess-winning-d0b1996/constants/fold_chess_bot.ep';s=p.read_text();assert hashlib.sha256(p.read_bytes()).hexdigest()=='c61a908fd10b78c5934c47b0e93c55847235735d9fe0dc0108bb11a2e7419d7c'
names=['piece_is_white','piece_is_black','piece_kind','starting_state','empty_state','copy_state','square_attacked','king_square','side_in_check','make_move','push_move','push_pawn_move','pseudo_moves','legal_moves','perft','counted_reach','lesser_attacker_exists','attack_min_reach_map','mobility_count','pawn_promotion_potential','side_units','share_numerator','share_denominator','move_is_capture','ordered_moves','could_check_from','quiescence','tt_key','tt_ensure','search_value','state_signature','root_pass','thinking_budget','search_best_seen','search_best']
# Execute the selected original EP statements through direct syntax lowering;
# do not use the stale checked-in C artifact as the winning source oracle.
blocks=[]
for name in names:
 m=re.search(r'^define '+name+r'(?![A-Za-z0-9_])[^\n]*\n(.*?)(?=^define |\Z)',s,re.M|re.S);assert m,name
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
text='\n\n'.join(blocks);text=text.replace('def quiescence(state,alpha_num,alpha_den,beta_num,beta_den,fresh):','def quiescence(state,alpha_num,alpha_den,beta_num,beta_den,fresh):\n    global NODES_LEFT, PASS_ABORTED');text=text.replace('def search_value(state,depth,alpha_num,alpha_den,beta_num,beta_den):','def search_value(state,depth,alpha_num,alpha_den,beta_num,beta_den):\n    global NODES_LEFT, PASS_ABORTED');text=text.replace('def search_best_seen(state,ceiling,seen):','def search_best_seen(state,ceiling,seen):\n    global NODES_LEFT, PASS_ABORTED, TT_GEN').replace('def search_best(state,depth):','def search_best(state,depth):\n    global NODES_LEFT, PASS_ABORTED');(w/'chess_driver1597_original_lowered.py').write_text(text+'\n')
class Division(ast.NodeTransformer):
 def visit_BinOp(self,node):
  node=self.generic_visit(node)
  return ast.copy_location(ast.Call(func=ast.Name(id='tdiv',ctx=ast.Load()),args=[node.left,node.right],keywords=[]),node)if isinstance(node.op,ast.Div)else node
ns={'create_list':lambda:[],'append_list':lambda xs,x:xs.append(x),'get_list':lambda xs,i:xs[i]if 0<=i<len(xs)else 0,'tdiv':lambda a,b:(abs(a)//abs(b))*(-1 if (a<0)!=(b<0)else 1)}
ns['set_list']=lambda xs,i,x:xs.__setitem__(i,x)if 0<=i<len(xs)else 0
ns['length_list']=len
exec(compile(ast.fix_missing_locations(Division().visit(ast.parse(text))),str(p),'exec'),ns)

ns['BLACK_REACH_BUF']=[];ns['WHITE_REACH_BUF']=[]
ns.update(int_to_string=str,concat=lambda a,b:a+b,string_index_of=lambda a,b:a.find(b))
rows=[]
def reset():ns.update(TT_KEYS=[],TT_MOVES=[],TT_STAMP=[],KILLER_A=[],KILLER_B=[],TT_GEN=0,NODES_LEFT=0,PASS_ABORTED=0)
def line(tag,answer):rows.append(tag+' '+','.join(map(str,answer))+f" nodes={ns['NODES_LEFT']} abort={ns['PASS_ABORTED']} gen={ns['TT_GEN']}")
start=ns['starting_state']();fool=start
for move in [853,3364,926]:fool=ns['make_move'](fool,move)
mate=ns['make_move'](fool,3807)
for tag,state in [('start',start),('fool',fool),('mate',mate)]:
 rows.append(tag+' signature '+ns['state_signature'](state))
 for previous in [-1,82]:
  for seen in ['',ns['state_signature'](ns['make_move'](state,82))]:
   reset();ns['NODES_LEFT']=256;line(tag+f' root {previous} '+seen,ns['root_pass'](state,2,seen,previous))
 reset();line(tag+' iterative',ns['search_best_seen'](state,2,ns['state_signature'](state)))
reset();line('fool fixed',ns['search_best'](fool,2))
rows.append(f"mateCheck {str(ns['side_in_check'](mate)).lower()} {len(ns['legal_moves'](mate))}")
(w/'chess_driver1597_original.log').write_text('\n'.join(rows)+'\n');print('rows',len(rows))
