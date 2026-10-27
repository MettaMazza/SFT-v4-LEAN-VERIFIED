"""Batch inventory and validation of all existing entries using the established checks.
Source-component inventory does not automatically assert scientific equivalence.
"""
from pathlib import Path
import ast,json,re,subprocess,hashlib,sys
from current_checks import PROJECT as r, source
info,v=source();pin=info['commit']
subprocess.run([sys.executable,str(r/'verification/check_current_parity.py')],cwd=r,check=True)
c=json.loads((r/'COVERAGE.json').read_text());co=json.loads((r/'reference/CORRESPONDENCE.json').read_text());mods=[m for k in ['modules','evidence_modules','engine_modules','host_modules'] for m in co.get(k,[])]
a=json.loads((r/'verification/current/PARITY_REPORT.json').read_text());assert a['status']=='PASS' and a['axiom_dependencies']==0
# Inventory every existing source entry together, reusing the one fresh global build/audit/parity.
# Explicit aliases cover source program interfaces, not a claim of semantic equivalence.
alias={'registration':{'registration','registrationData'},'generate_candidates':{'generateCandidates','generateCandidatesData','census','censusData'},'decide_candidate':{'decideCandidate'},'closure_evidence':{'closureEvidence','closureEvidenceData','closureData'},'run_controls':{'runControls'}}
rows=[]
complete={x['claim_id'] for x in c['claims'] if x['lean_status']=='complete'}
for x in c['claims']:
 if x['lean_status']=='pending':continue
 source=next(m['source_path'] for m in mods if m.get('v3_claim')==x['claim_id'])
 raw=subprocess.check_output(['git','-C',str(v),'show',pin+':'+source]);tree=ast.parse(raw)
 relevant=[m for m in mods if m['source_path']==source];decls=set(n for m in relevant for n in m['implemented'])
 for m in relevant:assert hashlib.sha256((r/m['module']).read_bytes()).hexdigest()==m['lean_source_sha256']
 functions=[{'name':n.name,'line':n.lineno} for n in tree.body if isinstance(n,ast.FunctionDef)]
 methods=[{'name':cl.name+'.'+n.name,'method':n.name,'line':n.lineno} for cl in tree.body if isinstance(cl,ast.ClassDef) for n in cl.body if isinstance(n,ast.FunctionDef)]
 missing=[z for z in methods if z['method'] in alias and not (alias[z['method']] & decls)]
 deps=x['v3_registration']['dependencies'];unclosed=[d for d in deps if d not in complete]
 row={'claim_id':x['claim_id'],'source_path':source,'source_sha256':hashlib.sha256(raw).hexdigest(),'source_functions':functions,'source_methods':methods,'lean_modules':[m['module'] for m in relevant],'fresh_build_axiom_and_candidate_checks':'PASS','missing_program_methods':missing,'dependencies_not_yet_completed':unclosed,'completion_status':x['lean_status'],'completion_evidence':x.get('completion_evidence'),'interpretation':'Interface presence is inventory only; full source completion requires the source-specific derivation and program evidence. No new proof obligation is introduced.'}
 rows.append(row)

ready=[x['claim_id'] for x in rows if x['completion_status']!='complete' and not x['dependencies_not_yet_completed']]
report={'source_commit':pin,'entries_checked':len(rows),'global_checks':a,'fully_completed_entries':sorted(complete),'incomplete_dependency_ready_entries':ready,'entries':rows}
(r/'verification/current/BATCH_EXISTING_WORK.json').write_text(json.dumps(report,indent=2)+'\n')
print(json.dumps({'entries_checked':len(rows),'completed':sorted(complete),'ready':ready,'entries_missing_program_methods':sum(bool(x['missing_program_methods']) for x in rows)},indent=2))
