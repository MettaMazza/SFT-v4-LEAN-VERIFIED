from pathlib import Path
import json,hashlib
w=Path('work');r=w/'turn1064_recovery';H=lambda p:hashlib.sha256(p.read_bytes()).hexdigest()
report=json.loads((w/'xray1163_empirical_report.json').read_text());assert report['status']=='PASS'
assert json.loads((w/'xray1163_empirical_output.json').read_text())==json.loads((w/'xray1163_original_empirical.json').read_text())
audit=json.loads((w/'xray1163_full_audit_report.json').read_text());assert audit['status']=='PASS'
for rel,h in audit['source_sha256'].items():assert H(r/rel)==h,rel
pin=json.loads((w/'massvector1310_source_pin.json').read_text());verified=[]
for row in pin['shared_source_files']:
 p=w/'pinned1310'/row['path'];prior=w/'pinned1163'/row['path'];assert H(p)==H(prior)==row['sha256'],row['path'];verified.append(row)
path='experiments/external_sources/chemistry/snapshots/anal-012-022-whole-subfield-v1/complete-postseal-analysis-v1.json';a=json.loads((w/'pinned1310'/path).read_text());surf=a['source_surface']
input=json.loads((w/'massvector1310_empirical_input.json').read_text());input['source_prefix']=dict(count=surf['unique_artifact_count'],bytes=surf['unique_source_bytes'],pages=surf['pdf_page_count'],htmls=surf['html_document_count'],vector_hash=a['complete_result_vector_sha256']);(w/'massvector1310_resolved_input.json').write_text(json.dumps(input,ensure_ascii=False))
(w/'massvector1310_reused_source_evidence.json').write_text(json.dumps(dict(status='PASS',prior_actual_native_output_sha256=H(w/'xray1163_empirical_output.json'),prior_original_output_sha256=H(w/'xray1163_original_empirical.json'),prior_full_native='xray1163_empirical_report.json',same_native_source=audit['source_sha256'],same_source_files=verified,reused_operation='SFT.Chemistry.XrayDiffractionAnalysis.sourcePrefix',source_prefix=input['source_prefix'],remaining_fresh='Mass independent JCAMP reconstruction, all eight own targets, full custody/isolation comparison and original controls'),indent=2)+'\n')
print('Reused unchanged actual native family source-prefix execution; entry-specific reconstruction remains fresh.')
