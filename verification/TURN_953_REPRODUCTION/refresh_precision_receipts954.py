from pathlib import Path
import json,hashlib,shutil,datetime
w=Path('work');c=Path('/Volumes/One Touch/SFT v4 Full model LEAN');assert 'PASS corrected original validator order and passed guard terminallamb 951' in (w/'precision954_wrapper_rechecks.log').read_text();assert 'PASS corrected original validator order and passed guard terminalfine 952' in (w/'precision954_wrapper_rechecks.log').read_text()
corr=json.loads((c/'reference/CORRESPONDENCE.json').read_text());now=datetime.datetime.now(datetime.timezone.utc).isoformat()
for low,n,tag,label in [('terminallamb',951,'TerminalLamb','TERMINAL_LAMB'),('terminalfine',952,'TerminalFine','TERMINAL_FINE')]:
 cfg=json.loads((w/f'{low}{n}_all_proofs_config.json').read_text());module=f'SFT/Physics/{tag}EmpiricalValidation.lean';sha=hashlib.sha256((c/module).read_bytes()).hexdigest();assert cfg['source_sha256'][tag+'EmpiricalValidation']==sha
 for group in ['modules','evidence_modules']:
  for row in corr[group]:
   if row.get('module')==module:row['lean_source_sha256']=sha
 p=c/f'verification/TURN_{n}_{label}_COMPLETION.json';receipt=json.loads(p.read_text());receipt['lean_source_sha256']=cfg['source_sha256'];receipt['validator_order_reverified_at']=now;receipt['validator_order_reverification']='Original blind validator first,then source classification,then classification mismatch or failed-validation rejection. Full affected native empirical comparison rerun against fresh original;full declaration audit empty.';p.write_text(json.dumps(receipt,indent=2)+'\n')
 for name in [f'{low}{n}_all_proofs_config.json',f'{low}{n}_all_audit.log',f'{low}empirical{n}_empirical_report.json',f'{low}empirical{n}_empirical_output.json']:
  shutil.copy2(w/name,c/f'verification/TURN_{n}_{name}')
 paths=set(json.loads((w/f'checkpoint{n}_paths.json').read_text()))
 for name in [f'{low}{n}_wrapper_recheck.log','precision954_wrapper_correction_build.log']:
  dest=f'verification/TURN_{n}_{name}';shutil.copy2(w/name,c/dest);paths.add(dest)
 (w/f'checkpoint{n}_paths.json').write_text(json.dumps(sorted(paths)))
(c/'reference/CORRESPONDENCE.json').write_text(json.dumps(corr,indent=2)+'\n')
with (c/'TIMELINE.txt').open('a') as f:f.write('\n'+now+' — Corrected the terminal atomic validator wrapper order to the exact V3 AtomicPrecisionValidator: blind validation first,then classification and passed-flag rejection. This was an assistant template translation error,not a V3 limitation. Rebuilt only changed wrapper modules,reran all-declaration audits and affected native empirical comparisons against original source in parallel. Lamb951 and fine952 passed;their source-hash-bound receipts and correspondence now identify the corrected code. Counts and scientific equations unchanged. No incorrect frozen620tree was committed or published;uploaded superseded blobs remain unreachable until corrected snapshot replaces them.\n')
print('PASS corrected951/952receipts refreshed without repeating scientific derivations')
