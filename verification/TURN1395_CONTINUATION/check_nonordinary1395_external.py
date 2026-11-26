from pathlib import Path
import json,os,time,subprocess,sys,hashlib
w=Path('work');r=w/'turn1064_recovery';job=json.loads((w/'nonordinary1395_external_job.json').read_text());audit=w/'external1395_audit_report.json'
while not audit.exists():
 os.kill(job['pid'],0);time.sleep(10)
a=json.loads(audit.read_text());assert a['status']=='PASS'
for rel,h in a['source_sha256'].items():assert hashlib.sha256((r/rel).read_bytes()).hexdigest()==h
subprocess.run([sys.executable,'work/prepare_nonordinaryexternal1395_programme.py'],check=True)
p=subprocess.run([sys.executable,'work/prepare_nonordinaryexternal1395_programme.py','--execute'],capture_output=True,text=True);(w/'nonordinary1395_empirical_execution.log').write_text(p.stdout+p.stderr);assert p.returncode==0,p.stdout[-1500:]+p.stderr[-700:];actual=json.loads(p.stdout);expected=json.loads((w/'nonordinary1395_empirical_expected.json').read_text());assert actual==expected,[k for k in expected if actual.get(k)!=expected[k]]
for row in json.loads((w/'nonordinary1395_empirical_files.json').read_text()):assert hashlib.sha256((w/'pinned1394'/row['path']).read_bytes()).hexdigest()==row['sha256']
(w/'nonordinary1395_empirical_output.json').write_text(json.dumps(actual,indent=2)+'\n');(w/'nonordinary1395_empirical_report.json').write_text(json.dumps({'status':'PASS','fields':len(actual),'measurements':len(actual['measurements']),'sources':len(actual['data_source_ids']),'full_output_and_hashes':True,'source_sha256':a['source_sha256']},indent=2)+'\n');print('PASS complete native terminal empirical validator matches V3',flush=True)
