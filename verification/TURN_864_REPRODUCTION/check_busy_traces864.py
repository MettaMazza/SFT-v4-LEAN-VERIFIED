from pathlib import Path
import subprocess,json,os,hashlib
ns={};exec(Path('work/busy_spec864.py').read_text(),ns)
source=ns['ns'];root=Path('work/constants-recovery').resolve();compiler='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean';env=dict(os.environ,LEAN_PATH=str(root/'.lake/build/lib/lean'))
p=subprocess.Popen([compiler,'--run',str(root/'NativeBusyProgram864.lean'),'trace-check','traces'],stdout=subprocess.PIPE,stderr=subprocess.PIPE,text=True,env=env)
digest=hashlib.sha256();count=0;states=0
for word in source['words_through_depth'](14):
 line=p.stdout.readline();assert line,('missing native row',count,p.stderr.read());actual=json.loads(line);expected=source['closing_trace'](word);assert actual['word']==list(word),(count,'word');assert actual['trace']==[list(x) for x in expected],(count,'trace');digest.update(line.encode());count+=1;states+=len(expected)
assert p.stdout.read()=='','extra native rows';errors=p.stderr.read();assert p.wait()==0,errors
maxima=[source['native_busy_beaver'](k) for k in range(1,15)];Path('work/busy864_original_maxima.json').write_text(json.dumps(maxima))
report=dict(status='PASS',source_commit=ns['pin'],source_operations=['words_at_depth','words_through_depth','closing_trace','native_busy_beaver'],complete_positive_depths=list(range(1,15)),all_distinct_native_words=count,all_retained_trace_states=states,actual_native_output_sha256=digest.hexdigest(),original_maxima=maxima,scope='Every ordered original closing word through14 and every complete original suffix trace including terminal empty-One; all14 maxima from original source execution.')
Path('work/busy864_trace_report.json').write_text(json.dumps(report,indent=2));print(json.dumps(report))
