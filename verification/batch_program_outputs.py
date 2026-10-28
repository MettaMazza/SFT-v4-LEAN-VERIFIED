"""Run all existing complete program drivers against pinned V3; no scientific Python execution."""
from pathlib import Path
from concurrent.futures import ThreadPoolExecutor, as_completed
import json,subprocess,hashlib,resource,sys
from current_checks import PROJECT as r, LAKE, source
info,v=source();pin=info['commit'];out=r/'verification/current/batch_programs';out.mkdir(parents=True,exist_ok=True)
subprocess.run([sys.executable,str(r/'verification/batch_existing_work.py')],cwd=r,check=True)
subprocess.run([LAKE,'build','SFT:static'],cwd=r,check=True,stdout=(out/'NATIVE_BUILD.log').open('w'),stderr=subprocess.STDOUT)
# Existing exact full-program drivers. The two multi-program source adapters are split
# into equivalent individual drivers only to give each comparison one JSON output.
base=(r/'verification/TURN_050_ArithmeticProgram.lean').read_text()
for label in ['FormEnforcement','Measurement']:
 (out/(label+'.lean')).write_text(base.replace('SFT.Mathematics','SFT.Foundation').replace('ExactArithmetic',label))
root=(r/'verification/TURN_112_OneProgram.lean').read_text().replace('One','Root');(out/'Root.lean').write_text(root)
entries=[
('SFT-ROOT-THERE-IS-NO-NOTHING',out/'Root.lean'),
('SFT-FOUNDATION-ONE-001',r/'verification/TURN_112_OneProgram.lean'),
('SFT-FOUNDATION-COUNT-001',r/'verification/TURN_112_CountProgram.lean'),
('SFT-FOUNDATION-PART-001',r/'verification/TURN_113_PartProgram.lean'),
('SFT-FOUNDATION-PART-EQUIVALENCE-001',r/'verification/TURN_116_PartEquivalenceProgram.lean'),
('SFT-FOUNDATION-EXACT-OPERATIONS-001',r/'verification/TURN_119_ExactOperationsProgram.lean'),
('SFT-FOUNDATION-HALF-ONE-001',r/'verification/TURN_119_HalfOneProgram.lean'),
('SFT-FOUNDATION-FOLD-001',r/'verification/TURN_114_FoldProgram.lean'),
('SFT-FOUNDATION-FOLD-ASSEMBLY-001',r/'verification/AssemblyEvidenceParity.lean'),
('SFT-FOUNDATION-FORM-GRAMMAR-001',r/'verification/TURN_044_FormProgram.lean'),
('SFT-FOUNDATION-FORM-ENFORCEMENT-001',out/'FormEnforcement.lean'),
('SFT-FOUNDATION-MEASURED-VALUE-BOUNDARY-001',out/'Measurement.lean'),
('SFT-MATH-EXACT-ARITHMETIC-001',r/'verification/TURN_050_ArithmeticProgram.lean'),
('SFT-MATH-DISCRETE-001',r/'verification/TURN_057_DiscreteProgram.lean'),
('SFT-MATH-COMBINATORICS-001',r/'verification/TURN_070_CombinatoricsProgram.lean'),
('SFT-MATH-ALGEBRA-001',r/'verification/TURN_086_AlgebraProgram.lean'),
('SFT-MATH-ORDER-LATTICE-001',r/'verification/TURN_096_OrderProgram.lean'),
('SFT-MATH-GRAPH-NETWORK-001',r/'verification/TURN_107_GraphProgram.lean'),
('SFT-MATH-GEOMETRY-TOPOLOGY-001',r/'verification/TURN_124_GeometryProgram.lean'),
('SFT-MATH-PROBABILITY-STATISTICS-001',r/'verification/TURN_127_ProbabilityProgram.lean'),
('SFT-MATH-LOGIC-PROOF-001',r/'verification/TURN_131_LogicProgram.lean'),
('SFT-MATH-CATEGORY-TYPE-COMPOSITION-001',r/'verification/TURN_133_CategoryProgram.lean'),
('SFT-INFO-SYMBOL-DISTINCTION-001',r/'verification/TURN_135_SymbolProgram.lean'),
('SFT-INFO-ENCODING-DECODING-001',r/'verification/TURN_138_EncodingProgram.lean'),
('SFT-INFO-QUANTITY-001',r/'verification/TURN_140_QuantityProgram.lean'),
('SFT-INFO-ENTROPY-UNCERTAINTY-001',r/'verification/TURN_143_EntropyProgram.lean'),
('SFT-INFO-COMPRESSION-REDUNDANCY-001',r/'verification/TURN_145_CompressionProgram.lean'),
('SFT-INFO-QUANTUM-CORRESPONDENCE-001',r/'verification/TURN_176_QuantumProgram.lean'),
('SFT-COMP-CBL-HALTING-001',r/'verification/TURN_202_HaltingProgram.lean'),
('SFT-COMP-CBL-RECOGNITION-DECISION-001',r/'verification/TURN_201_RecognitionProgram.lean'),
('SFT-COMP-FORM-UNIVERSALITY-001',r/'verification/TURN_200_UniversalProgram.lean'),
('SFT-COMP-FORM-MODEL-EQUIVALENCE-001',r/'verification/TURN_199_ModelProgram.lean'),
('SFT-COMP-FORM-COMPOSITION-001',r/'verification/TURN_197_AssemblyProgram.lean'),
('SFT-COMP-FORM-OPERATIONAL-PROCESS-001',r/'verification/TURN_196_ProcessProgram.lean'),
('SFT-COMP-FORM-CIRCUIT-001',r/'verification/TURN_195_CircuitProgram.lean'),
('SFT-COMP-FORM-ABSTRACT-MACHINE-001',r/'verification/TURN_194_MachineProgram.lean'),
('SFT-COMP-FORM-LAMBDA-CALCULUS-001',r/'verification/TURN_191_BindingProgram.lean'),
('SFT-COMP-FORM-RECURSIVE-FUNCTION-001',r/'verification/TURN_187_RecursionProgram.lean'),
('SFT-COMP-FORM-REWRITING-001',r/'verification/TURN_186_RewritingProgram.lean'),
('SFT-COMP-FORM-AUTOMATON-001',r/'verification/TURN_184_AutomatonProgram.lean'),
('SFT-COMP-FORM-LANGUAGE-GRAMMAR-001',r/'verification/TURN_183_LanguageProgram.lean'),
('SFT-COMP-FORM-STATE-TRANSITION-001',r/'verification/TURN_182_StateProgram.lean'),
('SFT-INFO-CLASSICAL-PROBABILISTIC-001',r/'verification/TURN_170_ClassicalProgram.lean'),
('SFT-INFO-CONSERVATION-LOSS-001',r/'verification/TURN_164_ConservationProgram.lean'),
('SFT-INFO-MUTUAL-CONDITIONAL-001',r/'verification/TURN_158_MutualProgram.lean'),
('SFT-INFO-CODING-001',r/'verification/TURN_153_CodingProgram.lean'),
('SFT-INFO-NOISE-ERROR-001',r/'verification/TURN_150_NoiseProgram.lean'),
('SFT-INFO-CHANNEL-CAPACITY-001',r/'verification/TURN_148_ChannelProgram.lean'),
('SFT-MATH-DYNAMICAL-SYSTEMS-001',r/'verification/TURN_130_DynamicsProgram.lean'),
('SFT-MATH-OPTIMIZATION-001',r/'verification/TURN_128_OptimizationProgram.lean'),
('SFT-FOUNDATION-FOLD-DYNAMICS-001',r/'verification/TURN_040_FoldDynamicsProgram.lean'),
('SFT-FOUNDATION-PRIMITIVE-MAP-UNIQUENESS-001',r/'verification/TURN_061_PrimitiveProgram.lean'),
('SFT-FOUNDATION-DERIVATION-TRACE-001',r/'verification/TURN_065_TraceProgram.lean')]
def read(claim,file):return json.loads(subprocess.check_output(['git','-C',str(v),'show',pin+':claims/'+claim+'/'+file]))
def check(item):
 claim,driver=item;log=(out/(claim+'.log')).open('w');cp=out/(claim+'.c');exe=out/claim
 try:
  for command in [[LAKE,'env','lean','-c',str(cp),str(driver)],[LAKE,'env','leanc','-o',str(exe),str(cp),str(r/'.lake/build/lib/libsft__v4_SFT.a')]]:subprocess.run(command,cwd=r,check=True,stdout=log,stderr=subprocess.STDOUT)
  source_hash=read(claim,'certificate.json')['source_manifest_hash'];raw=subprocess.check_output([str(exe),source_hash],cwd=r,text=True,stderr=log);actual=json.loads(raw)
  (out/(claim+'.output.json')).write_text(json.dumps(actual,indent=2)+'\n')
  census=read(claim,'candidate_census.json');census.pop('claim_id');receipt=read(claim,'elimination_receipt.json');reg=read(claim,'registration.json')
  expected={'census':census,'decisions':receipt['decisions'],'closure':receipt['closure'],'controls':read(claim,'controls.json')['controls']}
  for k,value in expected.items():assert actual[k]==value,k+' differs'
  for k in ['claim_id','title','branch','statement','dependencies']:assert actual['registration'][k]==reg[k],k+' differs'
  rr=actual['registration'];assert rr['source_hash']==source_hash and rr['evidence_mode']=='formal';assert rr['axioms']==rr['free_parameters']==[];assert rr['root_theorems']==([] if claim=='SFT-ROOT-THERE-IS-NO-NOTHING' else ['SFT-ROOT-THERE-IS-NO-NOTHING']);assert rr['provenance']==reg['provenance_classes'],'provenance differs from pinned registration'
  if 'unknown_rejected' in actual:assert actual['unknown_rejected'] is True
  if 'unknown_id' in actual:assert actual['unknown_id']=='StopIteration' or actual['unknown_id'].startswith('KeyError:')
  result={'claim_id':claim,'status':'PASS','candidate_rows':len(actual['decisions']),'source_manifest_hash':source_hash,'driver':str(driver.relative_to(r)),'driver_sha256':hashlib.sha256(driver.read_bytes()).hexdigest(),'matched':['registration','complete census','all decisions','closure','four controls','every embedded hash'],'unknown_identifier_check':'PASS' if 'unknown_id' in actual or 'unknown_rejected' in actual else 'separate Root HostChecks'}
 except Exception as exc:result={'claim_id':claim,'status':'FAIL','error':str(exc)}
 finally:log.close()
 (out/(claim+'.report.json')).write_text(json.dumps(result,indent=2)+'\n');print(json.dumps(result),flush=True);return result
results=[]
with ThreadPoolExecutor(max_workers=3) as pool:
 for future in as_completed([pool.submit(check,x) for x in entries]):results.append(future.result())
coverage=json.loads((r/'COVERAGE.json').read_text());implemented={x[0] for x in entries};missing=[x['claim_id'] for x in coverage['claims'] if x['lean_status']!='pending' and x['claim_id'] not in implemented]
report={'source_commit':pin,'status':'PASS' if all(x['status']=='PASS' for x in results) else 'FAIL','programs_checked':len(results),'programs_missing':missing,'results':sorted(results,key=lambda x:x['claim_id']),'semantic_completion':'Output checks supplement native derivation proofs; source-component review is separate and is not inferred from output parity.'}
(out/'REPORT.json').write_text(json.dumps(report,indent=2)+'\n');print(json.dumps({'status':report['status'],'programs_checked':len(results),'programs_missing':missing}),flush=True)
