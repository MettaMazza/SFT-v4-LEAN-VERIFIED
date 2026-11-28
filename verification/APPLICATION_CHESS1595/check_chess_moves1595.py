from pathlib import Path
import re,ast,json,hashlib
w=Path('work');p=w/'engine_sources1594/chess-winning-d0b1996/constants/fold_chess_bot.ep';s=p.read_text();assert hashlib.sha256(p.read_bytes()).hexdigest()=='c61a908fd10b78c5934c47b0e93c55847235735d9fe0dc0108bb11a2e7419d7c'
names=['piece_is_white','piece_is_black','piece_kind','starting_state','empty_state','copy_state','make_move','push_move','push_pawn_move','king_square']
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
text='\n\n'.join(blocks);(w/'chess_moves1595_original_lowered.py').write_text(text+'\n')
class Division(ast.NodeTransformer):
 def visit_BinOp(self,node):
  node=self.generic_visit(node)
  return ast.copy_location(ast.Call(func=ast.Name(id='tdiv',ctx=ast.Load()),args=[node.left,node.right],keywords=[]),node)if isinstance(node.op,ast.Div)else node
ns={'create_list':lambda:[],'append_list':lambda xs,x:xs.append(x),'get_list':lambda xs,i:xs[i]if 0<=i<len(xs)else 0,'tdiv':lambda a,b:(abs(a)//abs(b))*(-1 if (a<0)!=(b<0)else 1)}
ns['set_list']=lambda xs,i,x: xs.__setitem__(i,x) if 0<=i<len(xs) else 0
exec(compile(ast.fix_missing_locations(Division().visit(ast.parse(text))),str(p),'exec'),ns)

rows=[]
def emit(tag,state,move):rows.append(tag+' '+','.join(map(str,ns['make_move'](state,move))))
for f in range(64):
 for t in range(64):emit(f'start {f*64+t}',ns['starting_state'](),f*64+t)
for code in range(12):
 for f in range(64):
  for t in [0,7,8,16,47,48,56,63]:
   for promo in [0,2,3,4,5]:
    state=ns['empty_state']();state[f]=code+1;state[64]=0 if code<6 else 1;state[69]=t
    emit(f'sparse {code+1} {f} {t} {promo}',state,promo*4096+f*64+t)
for side in [0,1]:
 for target in range(64):rows.append(f'pawn {side} {target} '+','.join(map(str,ns['push_pawn_move']([],12,target,side))))
rows.append('king '+ ' '.join(map(str,[ns['king_square'](ns['starting_state'](),0),ns['king_square'](ns['starting_state'](),1),ns['king_square'](ns['empty_state'](),0)])))
n=(w/'chess_moves1595_native.log').read_text().splitlines();audit=[x for x in n if 'does not depend on any axioms' in x];n=[x for x in n if x not in audit];assert len(audit)==6,audit;assert n==rows,[(a,b)for a,b in zip(n,rows)if a!=b][:3]
(w/'chess_moves1595_source_output.txt').write_text('\n'.join(rows)+'\n')
r={'status':'PASS','source_revision':'d0b1996c09fd0b27be5a6016324f83ed578c5c94','source_sha256':hashlib.sha256(p.read_bytes()).hexdigest(),'comparison_rows':len(rows),'native_audited_functions':6,'axiom_dependencies':[],'scope':'move updates, promotion move construction, king lookup; full engine not complete'}
(w/'chess_moves1595_report.json').write_text(json.dumps(r,indent=2)+'\n');print(r)
