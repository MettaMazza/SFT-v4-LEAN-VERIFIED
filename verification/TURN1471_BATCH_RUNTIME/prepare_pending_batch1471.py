from pathlib import Path
import ast,json,re
w=Path('work');base=(w/'prepare_catalytic1356_optimized1470.py').read_text();pool=ast.literal_eval(base.split('for receipt_name in ',1)[1].split(':\n',1)[0]);rows=[]
for tag,name,num,pid in [('diffusionlimit1357','DiffusionLimitedReaction',1357,78246),('isotope1358','KineticIsotopeEffect',1358,86168),('dynamics1359','ReactionDynamicsScattering',1359,91213)]:
 s=base.replace('catalytic1356',tag).replace('CatalyticTurnover',name).replace('1470','1471')
 old=s.split('for receipt_name in ',1)[1].split(':\n',1)[0]
 receipts=pool+['catalytic1356_optimized_build1470.json',tag+'_program_native_build1413.json']
 assert all((w/n).exists()for n in receipts)
 s=s.replace('for receipt_name in '+old,'for receipt_name in '+repr(receipts))
 (w/('prepare_'+tag+'_optimized1471.py')).write_text(s)
 p=w/(name+'ValidationProgram'+str(num)+'.lean');(w/(name+'ValidationProgram1471.lean')).write_text(p.read_text().replace(tag+'_empirical_input.json',tag+'_optimized1471_input.json'))
 s=(w/('check_'+tag+'_empirical.py')).read_text();a=s.index('cmd=');b=s.index('\nwith',a);s=s[:a]+"cmd=[sys.executable,'work/prepare_"+tag+"_optimized1471.py','--execute']"+s[b:]
 for old,new in [(tag+'_empirical_',tag+'_optimized1471_'),(tag+'_original_empirical_current',tag+'_optimized1471_original_empirical_current')]:s=s.replace(old,new)
 (w/('check_'+tag+'_optimized1471.py')).write_text(s)
 s=(w/'adopt_catalytic_optimized1470.py').read_text().replace('catalytic1356',tag).replace('CatalyticTurnover',name).replace('1470','1471')
 s=s.replace('for pid in [75679,76176]:','for pid in ['+str(pid)+']:')
 s=re.sub(r'^ if \(pid==76176.*:\n'," if pid=="+str(pid)+" and '--run work/"+name+'ValidationProgram'+str(num)+".lean' in cmd:\n",s,flags=re.M)
 (w/('adopt_'+tag+'_optimized1471.py')).write_text(s)
 run='run_'+tag+'_optimized1471.py';jobs=['prepare_'+tag+'_optimized1471.py','check_'+tag+'_optimized1471.py','adopt_'+tag+'_optimized1471.py']
 (w/run).write_text('import subprocess\nfor n in '+repr(jobs)+":\n print('RUN '+n,flush=True);subprocess.run(['python3','-u','work/'+n],check=True)\n")
 rows.append(dict(tag=tag,module=name,original_pid=pid,controller=run,log=tag+'_optimized1471.log'))
(w/'pending_batch1471.json').write_text(json.dumps(rows,indent=2)+'\n');print(json.dumps(rows))
