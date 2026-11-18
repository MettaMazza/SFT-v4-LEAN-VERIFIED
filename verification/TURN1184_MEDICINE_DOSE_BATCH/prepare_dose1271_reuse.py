from pathlib import Path
import json,hashlib
w=Path('work');r=w/'turn1064_recovery';a=json.loads((w/'patient1234_empirical_report.json').read_text());assert a['status']=='PASS'
p='SFT/Medicine/PatientIdentitySeal.lean';h=a['source_sha256'][p];assert hashlib.sha256((r/p).read_bytes()).hexdigest()==h
old=json.loads((w/'patient1234_empirical_input.json').read_text());new=json.loads((w/'dose1271_empirical_input.json').read_text());assert old['pre_source_payload']==new['pre_source_payload']
(w/'dose1271_reused_source_evidence.json').write_text(json.dumps(dict(status='PASS',shared_module_sha256={p:h},same_pre_source_payload=True,scope='Only existing Medicine pre-source seal reused. Dose performs its own three-fragment source extraction and full native empirical comparison.'),indent=2)+'\n')
