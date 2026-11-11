from pathlib import Path
import subprocess,time,json,concurrent.futures
w=Path('work');status=w/'inverse_batch646_status.json'
def record(stage,**extra):status.write_text(json.dumps(dict(stage=stage,**extra),indent=2));print(stage,flush=True)
record('waiting_for_original_build',pid=24888,session=62880)
while True:
 p=subprocess.run(['ps','-p','24888','-o','command='],capture_output=True,text=True)
 if 'work/build_inverse_square644.py' not in p.stdout:break
 time.sleep(5)
assert 'PASS InverseSquareEvidence' in (w/'inverse_square644_native_repair.log').read_text(),'Original build did not pass; inspect original log without restarting'
def run(name,args):
 with (w/name).open('w') as f:subprocess.run(args,stdout=f,stderr=subprocess.STDOUT,check=True)
record('full_program_and_axiom_audit')
with concurrent.futures.ThreadPoolExecutor(max_workers=2) as pool:
 jobs=[pool.submit(run,'inverse_square646_program.log',['python3','work/run_inverse_square643.py']),pool.submit(run,'inverse_square646_audit_driver.log',['python3','work/audit_inverse_square646.py'])]
 for job in jobs:job.result()
record('independent_controls')
run('inverse_square646_independent.log',['python3','work/check_independent645.py','inverse_square','SFT-PHYS-FIELD-INVERSE-SQUARE-001','work/inverse_square_program643_output.json'])
record('register_law430')
run('inverse_square646_registration.log',['python3','work/register_inverse_batch646.py','law'])
record('register_interval431')
run('interval646_registration.log',['python3','work/register_inverse_batch646.py','interval'])
record('complete_ready_to_push',completed_entries=431)
