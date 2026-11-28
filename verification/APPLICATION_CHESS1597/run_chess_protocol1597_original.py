from pathlib import Path
import re,ast,json,hashlib
w=Path(__file__).resolve().parent;p=w.parents[1]/'reference/applications/chess-winning-d0b1996/constants/fold_chess_bot.ep';s=p.read_text();assert hashlib.sha256(p.read_bytes()).hexdigest()=='c61a908fd10b78c5934c47b0e93c55847235735d9fe0dc0108bb11a2e7419d7c'
names=['piece_is_white','piece_is_black','piece_kind','starting_state','empty_state','copy_state','square_attacked','king_square','side_in_check','make_move','push_move','push_pawn_move','pseudo_moves','legal_moves','perft','counted_reach','lesser_attacker_exists','attack_min_reach_map','mobility_count','pawn_promotion_potential','side_units','share_numerator','share_denominator','move_is_capture','ordered_moves','could_check_from','quiescence','tt_key','tt_ensure','search_value','state_signature','root_pass','thinking_budget','search_best_seen','search_best','flip_rank','parse_packed_token','load_packed_table','endgame_probe','endgame_best_move','start_is_at_the_lock','finds_fools_mate','fools_mate_is_seen_as_mate','fools_mate_is_real','self_play_plies']
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
text='\n\n'.join(blocks);text=text.replace('def quiescence(state,alpha_num,alpha_den,beta_num,beta_den,fresh):','def quiescence(state,alpha_num,alpha_den,beta_num,beta_den,fresh):\n    global NODES_LEFT, PASS_ABORTED');text=text.replace('def search_value(state,depth,alpha_num,alpha_den,beta_num,beta_den):','def search_value(state,depth,alpha_num,alpha_den,beta_num,beta_den):\n    global NODES_LEFT, PASS_ABORTED');text=text.replace('def search_best_seen(state,ceiling,seen):','def search_best_seen(state,ceiling,seen):\n    global NODES_LEFT, PASS_ABORTED, TT_GEN').replace('def search_best(state,depth):','def search_best(state,depth):\n    global NODES_LEFT, PASS_ABORTED');(w/'chess_protocol1597_original_lowered.py').write_text(text+'\n')
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
ns.update(string_length=len,char_at=lambda s,i:ord(s[i]),file_read=lambda p:Path(p).read_text(),string_split=lambda s,sep:s.split(sep))
kqk=ns['load_packed_table'](str(w.parents[1]/'reference/applications/chess-winning-d0b1996/data/kqk_packed.txt'));krk=ns['load_packed_table'](str(w.parents[1]/'reference/applications/chess-winning-d0b1996/data/krk_packed.txt'))
rows=[]
def reset():ns.update(TT_KEYS=[],TT_MOVES=[],TT_STAMP=[],KILLER_A=[],KILLER_B=[],TT_GEN=0,NODES_LEFT=0,PASS_ABORTED=0)
for history in [[],[853,3364,926],[853,3364,926,3807]]:
 reset();state=ns['starting_state']();seen=ns['state_signature'](state)
 for move in history:state=ns['make_move'](state,move);seen+=ns['state_signature'](state)
 endgame=ns['endgame_best_move'](state,kqk,krk)
 answer=endgame[1]if endgame[0]==1 else ns['search_best_seen'](state,2,seen)[0]
 rows.append('protocol '+str(answer))
reset();rows.append('lock '+str(ns['start_is_at_the_lock']()).lower());rows.append('find '+str(ns['finds_fools_mate']()));rows.append('seen '+str(ns['fools_mate_is_seen_as_mate']()).lower());rows.append('real '+str(ns['fools_mate_is_real']()).lower())
for n in [-1,0,1,2]:rows.append(f"self {n} {ns['self_play_plies'](n)}")
(w/'chess_protocol1597_original.log').write_text('\n'.join(rows)+'\n');print('rows',len(rows))
