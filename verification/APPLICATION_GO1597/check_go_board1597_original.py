from pathlib import Path
import importlib.util,hashlib
w=Path(__file__).resolve().parent;p=w.parents[1]/'reference/applications/go-winning-2efcc6b/tools/measure_go.py';assert hashlib.sha256(p.read_bytes()).hexdigest()=='62069645154e3454bd4057660598c61008dcd2464a8d6792db0f176e5c15c6ab'
spec=importlib.util.spec_from_file_location('original_go',p);m=importlib.util.module_from_spec(spec);spec.loader.exec_module(m);rows=[]
def nums(a):return ','.join(map(str,a))
def key(b):return ''.join(map(str,b.board))
def emit(tag,b):
 rows.append(tag+' board '+key(b))
 for idx in range(b.size*b.size):
  group,libs=b.get_group(idx);rows.append(tag+f' group {idx} '+nums(sorted(group))+'/'+nums(sorted(libs)))
 for color in [1,2]:
  rows.append(tag+f' legal {color} '+nums(b.get_legal_moves(color)))
  for idx in list(range(b.size*b.size))+[None]:
   next=b.copy();ok=next.play_move(idx,color);rows.append(tag+f' move {color} {999 if idx is None else idx} {int(ok)} '+key(next)+' '+','.join(sorted(next.history)))
for size in [1,2]:
 for code in range(3**(size*size)):
  board=m.SFTGoBoard(size);board.board=[(code//3**i)%3 for i in range(size*size)];emit(f'enum {size} {code}',board)
  passed=board.copy();passed.play_move(None,1);emit(f'history {size} {code}',passed)
  board.ko_square=0;emit(f'ko {size} {code}',board)
for size in [3,9,19]:
 board=m.SFTGoBoard(size)
 for step in range(12):
  emit(f'walk {size} {step}',board);color=step%2+1;moves=board.get_legal_moves(color);board.play_move(moves[(step*17+3)%len(moves)]if moves else None,color)
(w/'go_board1597_original.log').write_text('\n'.join(rows)+'\n');print('rows',len(rows))
