from pathlib import Path
import re,ast,json,hashlib
w=Path('work');p=w/'engine_sources1594/chess-winning-d0b1996/constants/fold_chess_bot.ep';s=p.read_text();assert hashlib.sha256(p.read_bytes()).hexdigest()=='c61a908fd10b78c5934c47b0e93c55847235735d9fe0dc0108bb11a2e7419d7c'
names=['piece_is_white','piece_is_black','piece_kind','starting_state','empty_state','copy_state','counted_reach','flip_rank','thinking_budget']
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
text='\n\n'.join(blocks);(w/'chess_board1594_original_lowered.py').write_text(text+'\n')
class Division(ast.NodeTransformer):
 def visit_BinOp(self,node):
  node=self.generic_visit(node)
  return ast.copy_location(ast.Call(func=ast.Name(id='tdiv',ctx=ast.Load()),args=[node.left,node.right],keywords=[]),node)if isinstance(node.op,ast.Div)else node
ns={'create_list':lambda:[],'append_list':lambda xs,x:xs.append(x),'get_list':lambda xs,i:xs[i]if 0<=i<len(xs)else 0,'tdiv':lambda a,b:(abs(a)//abs(b))*(-1 if (a<0)!=(b<0)else 1)}
exec(compile(ast.fix_missing_locations(Division().visit(ast.parse(text))),str(p),'exec'),ns)
rows=[]
for c in range(-4,17):rows.append(f"piece {c} {int(ns['piece_is_white'](c))} {int(ns['piece_is_black'](c))} {ns['piece_kind'](c)}")
for k in range(9):
 for sq in range(64):
  for side in range(2):rows.append(f"reach {k} {sq} {side} {ns['counted_reach'](k,sq,side)}")
for sq in range(64):rows.append(f"flip {sq} {ns['flip_rank'](sq)}")
a=ns['starting_state']();b=ns['empty_state']();c=ns['copy_state'](a)
for i in range(71):rows.append(f'board {i} {a[i]} {b[i]} {c[i]}')
rows.append(f"budget {ns['thinking_budget']()}")
(w/'chess_board1594_source_output.txt').write_text('\n'.join(rows)+'\n')
n=(w/'chess_board1594_native.log').read_text().splitlines();audit=[x for x in n if 'does not depend on any axioms' in x];n=[x for x in n if x not in audit];assert len(audit)==9;assert n==rows,[(a,b)for a,b in zip(n,rows)if a!=b][:10]
r={'status':'PASS','source_revision':'d0b1996c09fd0b27be5a6016324f83ed578c5c94','source_sha256':hashlib.sha256(p.read_bytes()).hexdigest(),'translated_source_functions':names,'comparison_rows':len(rows),'axiom_dependencies':[],'scope':'board, piece coding, counted empty-board reach, rank flip and exact original thinking budget; full engine not complete','stale_generated_C_budget':2**17,'winning_source_budget':2**22}
(w/'chess_board1594_report.json').write_text(json.dumps(r,indent=2)+'\n');print(r)
