from pathlib import Path
import re,ast,json,hashlib
w=Path(__file__).resolve().parent;p=w.parents[1]/'reference/applications/chess-winning-d0b1996/constants/fold_chess_bot.ep';s=p.read_text();assert hashlib.sha256(p.read_bytes()).hexdigest()=='c61a908fd10b78c5934c47b0e93c55847235735d9fe0dc0108bb11a2e7419d7c'
names=['piece_is_white','piece_is_black','piece_kind','starting_state','empty_state','copy_state','square_attacked','king_square','side_in_check','make_move','push_move','push_pawn_move','pseudo_moves','legal_moves','perft','counted_reach','lesser_attacker_exists','attack_min_reach_map','mobility_count','pawn_promotion_potential','side_units','share_numerator','share_denominator','move_is_capture','ordered_moves','could_check_from','flip_rank','parse_packed_token','load_packed_table','endgame_probe','endgame_best_move']
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
text='\n\n'.join(blocks);(w/'chess_endgame1597_original_lowered.py').write_text(text+'\n')
class Division(ast.NodeTransformer):
 def visit_BinOp(self,node):
  node=self.generic_visit(node)
  return ast.copy_location(ast.Call(func=ast.Name(id='tdiv',ctx=ast.Load()),args=[node.left,node.right],keywords=[]),node)if isinstance(node.op,ast.Div)else node
ns={'create_list':lambda:[],'append_list':lambda xs,x:xs.append(x),'get_list':lambda xs,i:xs[i]if 0<=i<len(xs)else 0,'tdiv':lambda a,b:(abs(a)//abs(b))*(-1 if (a<0)!=(b<0)else 1)}
ns['set_list']=lambda xs,i,x:xs.__setitem__(i,x)if 0<=i<len(xs)else 0
ns['length_list']=len
exec(compile(ast.fix_missing_locations(Division().visit(ast.parse(text))),str(p),'exec'),ns)

ns['BLACK_REACH_BUF']=[];ns['WHITE_REACH_BUF']=[]
ns.update(string_length=len,char_at=lambda s,i:ord(s[i]),file_read=lambda p:Path(p).read_text(),string_split=lambda s,sep:s.split(sep))
kqk=ns['load_packed_table'](str(w.parents[1]/'reference/applications/chess-winning-d0b1996/data/kqk_packed.txt'));krk=ns['load_packed_table'](str(w.parents[1]/'reference/applications/chess-winning-d0b1996/data/krk_packed.txt'))
rows=[]
def line(tag,b):rows.append(tag+' '+','.join(map(str,b)))
line('kqk',kqk);line('krk',krk)
for tok in ['', '0','64','2049','12\n','-1','0012']:rows.append('token '+str(ns['parse_packed_token'](tok)))
for kind in [4,5,10,11]:
 for n in range(256):
  for side in [0,1]:
   state=ns['empty_state']();state[n%64]=6;state[(n*17+3)%64]=12;state[(n//4+7)%64]=kind;state[64]=side
   line(f'probe {kind} {n} {side}',ns['endgame_probe'](state,kqk,krk))
   if n<8:line(f'move {kind} {n} {side}',ns['endgame_best_move'](state,kqk,krk))
a=ns['empty_state']();a[0]=6;b=ns['empty_state']();b[0]=1;b[1]=7
for state in [ns['empty_state'](),ns['starting_state'](),a,b]:
 line('edge',ns['endgame_probe'](state,kqk,krk));line('noTable',ns['endgame_probe'](state,[],[]))
(w/'chess_endgame1597_original.log').write_text('\n'.join(rows)+'\n');print('rows',len(rows),'table sizes',len(kqk),len(krk))
