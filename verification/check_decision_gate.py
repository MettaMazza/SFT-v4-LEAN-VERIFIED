"""Fresh typed forcing-gate checks against engine.py's four ordered conditions.
Uses only Python standard-library comparison code; never imports V3 modules.
"""
from pathlib import Path
import hashlib,json,itertools
from current_checks import PROJECT as p,OUTPUT,source,run,fresh_audit
info,src=source();audit=fresh_audit()
cor=json.loads((p/'reference/CORRESPONDENCE.json').read_text())
for m in cor.get('engine_modules',[]):
 assert hashlib.sha256((src/m['source_path']).read_bytes()).hexdigest()==m['source_sha256']
def text(s):return 'String.ofList (['+','.join(str(ord(c)) for c in s)+'].map Char.ofNat)'
good='sha256:'+'a'*64
ids_options=[['a','b'],['b','a'],['a'],['a','b','c']]
flags=list(itertools.product([False,True],repeat=2))
reasons=['proof','',' \t\u2003','\u200b']
hashes=[good,'SHA256:'+'a'*64,'sha256:'+'A'*64,'sha256:'+'z'*64,'sha256:'+'a'*63,'sha256:'+'é'*64]
inputs=[];expected=[]
for ids,fs,reason,digest in itertools.product(ids_options,flags,reasons,hashes):
 ds=[{'candidate_id':v,'survives':fs[i%2],'reason':reason,'proof_hash':digest} for i,v in enumerate(ids)]
 errors=[]
 if ids!=['a','b']:errors.append('decisions do not correspond one-for-one with the generated census')
 if sum(d['survives'] for d in ds)!=1:errors.append('forcing did not leave exactly one survivor')
 if any(not d['reason'].strip() for d in ds):errors.append('every candidate decision requires an explicit reason')
 if any(not (d['proof_hash'].startswith('sha256:') and len(d['proof_hash'][7:])==64 and all(c in '0123456789abcdef' for c in d['proof_hash'][7:])) for d in ds):errors.append('every candidate decision requires a proof hash')
 expected.append(errors)
 inputs.append('['+','.join('⟨'+text(d['candidate_id'])+','+str(d['survives']).lower()+','+text(reason)+','+text(digest)+'⟩' for d in ds)+']')
code='''import SFT
open SFT.Engine SFT.Host.Canonical
set_option maxRecDepth 10000
set_option maxHeartbeats 0
def casesToCheck : List (List CandidateDecision) := [
'''+',\n'.join(inputs)+''']
def main : IO Unit := do
 let cs : List Candidate := [⟨"a","form","trace"⟩,⟨"b","form","trace"⟩]
 for ds in casesToCheck do IO.println (render (.array ((decisionViolations cs ds).map Value.text)))
 IO.println (render (.array ((decisionViolations SFT.Foundation.Root.Gate.censusCandidates SFT.Foundation.Root.Gate.decisions).map Value.text)))
 IO.println (render (.array ((decisionViolations SFT.Foundation.Root.Gate.censusCandidates SFT.Foundation.Root.Gate.tamperedDecisions).map Value.text)))
 let spaces := (List.range 1114112).filter fun n => pythonWhitespace (Char.ofNat n)
 IO.println (render (.array (spaces.map (fun n => .integer (Int.ofNat n)))))
'''
program=OUTPUT/'DecisionGateCases.lean';program.write_text(code)
lines=run('env','lean','--run',str(program)).splitlines()
actual=[json.loads(line) for line in lines]
assert actual[:-3]==expected,'typed forcing-gate output differs in content or order'
assert actual[-3]==[],'normal Root decisions rejected'
assert actual[-2]==['forcing did not leave exactly one survivor'],'Root tamper response differs'
assert actual[-1]==[n for n in range(0x110000) if chr(n).isspace()],'Unicode whitespace domain differs'
report={'status':'PASS','source_commit':info['commit'],**audit,'forcing_gate_cases':len(expected),'root_normal':'accepted by forcing gate','root_tampered':'rejected by forcing gate','unicode_whitespace_codepoints_checked':0x110000,'scope':'typed Candidate/CandidateDecision dataclass domains; not complete engine admission'}
(OUTPUT/'DECISION_GATE_REPORT.json').write_text(json.dumps(report,indent=2)+'\n');print(json.dumps(report,indent=2))
