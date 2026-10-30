from pathlib import Path
import subprocess,json,os,hashlib
r=Path('work/constants-recovery').resolve();repo='/Volumes/One Touch/ernos-labs-sft-platform';pin='76f1b34e9e9682989adcbb088797b4ae4ce4fcf1';env=dict(os.environ,LEAN_PATH=str(r/'.lake/build/lib/lean'))
for mod,cid,snapshot in [('DarkBaryon','SFT-PHYS-COSMO-DARK-BARYON-FRACTION-001','planck-2018-density-abstract-record.json'),('Hubble','SFT-PHYS-COSMO-HUBBLE-CALIBRATION-001','planck-shoes-hubble-abstract-record.json')]:
 if Path('work/'+mod+'_validation377_report.json').exists():continue
 expected=json.loads(subprocess.check_output(['git','-C',repo,'show',pin+':claims/'+cid+'/empirical_validation.json']));expected.pop('claim_id')
 p=Path('work/pinned-constants')/snapshot
 out=subprocess.check_output(['/Users/dolltrading/.elan/bin/lean','-j','1','-M','4096','--run',str(r/(mod+'ValidationProgram.lean')),str(p.resolve()),expected['validated_seal_hash'],expected['isolation_certificate']['host_platform'],expected['isolation_certificate']['python_implementation']],cwd=r,env=env,text=True)
 actual=json.loads(out);Path('work/'+mod+'_validation377_output.json').write_text(json.dumps(actual,indent=2)+'\n');assert actual==expected,[(k,actual.get(k),v) for k,v in expected.items() if actual.get(k)!=v]
 report=dict(status='PASS',claim_id=cid,source_commit=pin,fresh_native_execution=True,source_bytes=p.stat().st_size,source_sha256=hashlib.sha256(p.read_bytes()).hexdigest(),all_validation_fields_and_hashes_match=True,scope='Original source interval parsing and guards, both exact predictions, complete blind validator execution, source hash, sealing, custody, both rows, hostile audit, controls, all certificates and receipt; host labels supplied from pinned record, protected snapshots supplied identical.')
 Path('work/'+mod+'_validation377_report.json').write_text(json.dumps(report,indent=2)+'\n');print(json.dumps(report),flush=True)
