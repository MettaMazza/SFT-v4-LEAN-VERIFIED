from pathlib import Path
import ast,json,subprocess
r=Path('/Volumes/One Touch/SFT v4 Full model LEAN');pin=json.loads((r/'reference/SOURCE.json').read_text())['commit'];src=subprocess.check_output(['git','-C','/Volumes/One Touch/ernos-labs-sft-platform','show',pin+':sft/foundation/form_grammar.py']).decode();tree=ast.parse(src);cs={}
for n in tree.body:
 if isinstance(n,ast.Assign):
  try:cs[n.targets[0].id]=ast.literal_eval(n.value)
  except (ValueError,TypeError):pass
fields=[('base','Base',['excluded','included'],'BASE',1),('arity','Arity',['oneChild','twoChildren','laterArity'],'CHILD_ARITY',1),('labels','Labels',['absent','same','distinctHeld'],'LABELS',2),('children','Children',['ungenerated','generated'],'CHILD_SOURCE',1),('returns','Return',['absent','present'],'RETURN',1),('termination','Termination',['absent','finiteLeaf'],'TERMINATION',1),('extra','Extra',['noExtra','hasExtra'],'EXTRA',0)]
q=lambda x:json.dumps(x,ensure_ascii=False)
s='import SFT.Foundation.FormAcceptance\nimport SFT.Foundation.CommonRefinement\nnamespace SFT.Foundation.FormGrammar\nset_option maxRecDepth 20000\n\n'
for f,t,ctors,k,a in fields:
 s+=f'inductive {t} where\n  | '+' | '.join(ctors)+'\n\n'+f'def {f}Name : {t} → String\n'+''.join(f'  | .{c} => {q(v)}\n' for c,v in zip(ctors,cs[k]))+'\n'
s+='structure Candidate where\n'+''.join(f'  {f} : {t}\n' for f,t,*_ in fields)+'\n'
s+='def sourceFields (c : Candidate) : List String := ['+', '.join(f'{f}Name c.{f}' for f,*_ in fields)+']\n\n'
s+='def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)\ndef exactForm (c : Candidate) : String := SFT.Host.Text.join ["Grammar proposal has ", SFT.Host.Text.intercalate ", " (sourceFields c), "."]\n'
s+='def survivorId : String := '+q(cs['SURVIVOR'])+'\ndef survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId\n'
s+='def criteriaDecision (c : Candidate) : Bool :=\n  '+' &&\n  '.join(f'SFT.Host.Text.equal ({f}Name c.{f}) {q(cs[k][a])}' for f,t,ctors,k,a in fields)+'\n\n'
fn=next(n for n in tree.body if isinstance(n,ast.FunctionDef) and n.name=='decision_reason');checks=fn.body[0].value.elts;s+='def decisionReason (c : Candidate) : String :=\n'
for pair in checks:
 condition,reason=pair.elts;field=ast.literal_eval(condition.left.slice);field='returns' if field=='return' else field;value=ast.literal_eval(condition.comparators[0]);s+=f'  if SFT.Host.Text.equal ({field}Name c.{field}) {q(value)} then {q(ast.literal_eval(reason))} else\n'
s+='  '+q(ast.literal_eval(fn.body[-1].value))+'\n\n'
s+='def generationRule : String := '+q(cs['GENERATION_RULE'])+'\ndef grammarBoundary : String := '+q(cs['GRAMMAR_BOUNDARY'])+'\n\n'
ls=lambda t,ctors:'['+','.join(t+'.'+c for c in ctors)+']'
s+='def candidates : List Candidate :=\n'+''.join('  ('+ls(t,ctors)+').'+('map' if i==6 else 'flatMap')+f' fun {f} =>\n' for i,(f,t,ctors,k,a) in enumerate(fields))+'  ⟨'+','.join(f[0] for f in fields)+'⟩\n\n'
s+='def survivor : Candidate := ⟨'+','.join('.'+ctors[a] for f,t,ctors,k,a in fields)+'⟩\n\ntheorem generatedCardinality : candidates.length = 288 := rfl\n\n'
vs=' '.join(f[0] for f in fields);s+=f'theorem candidatesComplete (c : Candidate) : c ∈ candidates := by\n  cases c with\n  | mk {vs} =>\n'
for f,t,ctors,k,a in fields:s+=f'    have h{f} : {f} ∈ {ls(t,ctors)} := by\n      cases {f} <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail\n'
s+='    unfold candidates\n'+''.join(f'    apply CommonRefinement.memFlatMap _ _ {f} _ h{f}\n' for f,*_ in fields[:-1])+'    exact Count.TraceDerivation.memMap _ extra _ hextra\n\n'
cases=' <;> '.join('cases '+f[0] for f in fields)
s+=f'set_option maxHeartbeats 20000000 in\ntheorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by\n  cases c with\n  | mk {vs} =>\n    {cases}\n    all_goals rfl\n\n'
s+=f'set_option maxHeartbeats 10000000 in\ntheorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by\n  cases c with\n  | mk {vs} =>\n    {cases}\n    all_goals constructor <;> intro h <;> first | rfl | cases h\n\n'
s+='theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by\n  rw [sourceDecisionMatchesCriteria]\n  exact uniqueCriteriaSurvivor c\n\ntheorem survivorAccepted : survives survivor = true := rfl\n\n'
s+='def ExactCriteria (c : Candidate) : Prop :=\n  '+' ∧ '.join(f'c.{f} = .{ctors[a]}' for f,t,ctors,k,a in fields)+'\n\n'
s+='theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by\n  constructor\n  · intro h\n    have eq := (uniqueSurvivor c).mp h\n    cases eq\n    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩\n  · intro h\n    cases c with\n'+f'    | mk {vs} =>\n      obtain ⟨h0,h1,h2,h3,h4,h5,h6⟩ := h\n      cases h0; cases h1; cases h2; cases h3; cases h4; cases h5; cases h6\n      rfl\n\n'
for f,t,ctors,k,a in fields:
 for bad in [c for i,c in enumerate(ctors) if i!=a]:
  s+=f'theorem {f}_{bad}_rejected (c : Candidate) (h : c.{f} = .{bad}) : survives c = false := by\n  cases hs : survives c with\n  | false => rfl\n  | true =>\n    have eq := (uniqueSurvivor c).mp hs\n    have field := congrArg Candidate.{f} eq\n    rw [h] at field\n    cases field\n\n'
s+='end SFT.Foundation.FormGrammar\n';(r/'SFT/Foundation/FormGrammar.lean').write_text(s)
