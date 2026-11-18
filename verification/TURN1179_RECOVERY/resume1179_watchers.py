from pathlib import Path
import subprocess,json
w=Path('work');names=['register_xray1163_when_ready.py','register_evolution1183_batch_when_ready.py','register_gene_protein1189_when_ready.py','register_cell1201_when_ready.py','register_organism1208_when_ready.py','register_ecology1220_when_ready.py','register_patient1234_when_ready.py','register_medicine1236_when_ready.py','register_medicine1241_when_ready.py'];jobs=[]
for name in names:
 log=(w/('resume1179_'+name[:-3]+'.log')).open('a');p=subprocess.Popen(['python3','work/'+name],stdout=log,stderr=subprocess.STDOUT);jobs.append((name,p,log))
(w/'resume1179_watchers.json').write_text(json.dumps([dict(worker=n,pid=p.pid)for n,p,l in jobs],indent=2)+'\n')
for name,p,log in jobs:print(name,p.wait(),flush=True);log.close()
