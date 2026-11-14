from pathlib import Path
import subprocess,json,os,concurrent.futures
w=Path('work');root=(w/'v3-runtime500').resolve();pin='76f1b34e9e9682989adcbb088797b4ae4ce4fcf1'
def run(item):
 tag,low,n,cid=item;expected=json.load(open(w/f'{low}{n}_original_empirical.json'));frozen=json.loads(subprocess.check_output(['git','-C','/Volumes/One Touch/ernos-labs-sft-platform','show',pin+':claims/'+cid+'/empirical_validation.json']));frozen.pop('claim_id');assert expected==frozen
 exe=(w/'circuit866_native_objects'/f'{tag}Empirical{n}').resolve();out=subprocess.check_output([str(exe),str(root),expected['validated_seal_hash'],expected['isolation_certificate']['host_platform'],expected['isolation_certificate']['python_implementation']],text=True);actual=json.loads(out);(w/f'{low}{n}_empirical_output.json').write_text(json.dumps(actual,indent=2));assert actual==expected,[(k,actual.get(k),v) for k,v in expected.items() if actual.get(k)!=v]
 report=dict(status='PASS',source_commit=pin,fresh_native_lean_execution=True,fresh_original_package_execution=True,all_empirical_fields_and_hashes_match=True,pinned_original_record_also_matches=True,scope='Complete original external precheck and blind empirical pipeline:source hashes/rows,original spec,program,sealing,custody,comparison vector,unfavorable control,isolation/custody certificates and receipt. Existing source protocol machinery reused.')
 (w/f'{low}{n}_empirical_report.json').write_text(json.dumps(report,indent=2));print(tag,'complete empirical comparison PASS',flush=True)
items=[('GravityHorizonValidation','gravityhorizonvalidation',914,'SFT-PHYS-VALIDATION-GRAVITY-HORIZONS-003')]
with concurrent.futures.ThreadPoolExecutor(max_workers=2) as p:list(p.map(run,items))
