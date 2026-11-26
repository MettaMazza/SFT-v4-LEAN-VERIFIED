from pathlib import Path
import subprocess,os,re,time,signal,json
w=Path('work/pdf_layout1374');node='/Users/dolltrading/.cache/codex-runtimes/codex-primary-runtime/dependencies/node/bin/node'
env=dict(os.environ,SFT_PAPER_SOURCE='work/turn1064_recovery/ZENODO_PAPER_DRAFT.txt',SFT_CODE_PIN='ec2d43bbaf789b440e131e0922d5e46a806b42bc',SFT_LAYOUT_ONLY='1');env.pop('SFT_REVIEW_EDITION',None);env.pop('SFT_PUBLICATION_EDITION',None);env.pop('SFT_PUBLICATION_DOI',None)
pressure=subprocess.check_output(['memory_pressure','-Q'],text=True);assert int(re.search(r'memory free percentage:\s*(\d+)%',pressure)[1])>=25
results=[]
for script in ['build_html.cjs','render.cjs']:
 with (w/(script+'.log')).open('w') as log:
  proc=subprocess.Popen([node,'--max-old-space-size=1024',str(w/script)],env=env,stdout=log,stderr=subprocess.STDOUT,start_new_session=True);peak=0
  while proc.poll()is None:
   rows=subprocess.check_output(['ps','-axo','pgid=,rss='],text=True).splitlines();rss=sum(int(f[1])for row in rows if len(f:=row.split())==2 and int(f[0])==proc.pid);peak=max(peak,rss)
   if rss>4096*1024:
    os.killpg(proc.pid,signal.SIGTERM);proc.wait();raise RuntimeError('Layout process group exceeded4GiB; preserve logs')
   time.sleep(1)
  results.append(dict(script=script,exit=proc.returncode,peak_rss_mib=round(peak/1024,1)));(w/'execution.json').write_text(json.dumps(results,indent=2)+'\n');assert proc.returncode==0,script
print(json.dumps(results))
