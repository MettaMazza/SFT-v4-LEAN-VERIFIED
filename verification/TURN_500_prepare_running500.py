from pathlib import Path
import ast,json,itertools
r=Path('work/constants-recovery/SFT/Physics');source=Path('work/coupling_running_convergence_terminal_law_v1499.py').read_text();tree=ast.parse(source)
const={n.targets[0].id:ast.literal_eval(n.value) for n in tree.body if isinstance(n,ast.Assign) and isinstance(n.targets[0],ast.Name) and isinstance(n.value,(ast.Tuple,ast.Constant))}
fields=['sectorDomain','scaleGeneration','couplingForm','successorLaw','pairGapLaw','convergenceLaw','physicalTranslation','targetBoundary','extension']
keys=['sector_domain','scale_generation','coupling_form','successor_law','pair_gap_law','convergence_law','physical_translation','target_boundary','extension']
cs=['SECTOR_DOMAINS','SCALE_GENERATIONS','COUPLING_FORMS','SUCCESSOR_LAWS','PAIR_GAP_LAWS','CONVERGENCE_LAWS','PHYSICAL_TRANSLATIONS','TARGET_BOUNDARIES','EXTENSIONS'];types=[x[0].upper()+x[1:] for x in fields]
q=lambda s:json.dumps(s,ensure_ascii=False)
out='import SFT.Physics.RunningConvergence\nimport SFT.Foundation.CommonRefinement\nnamespace SFT.Physics.RunningConvergenceGrammar\nopen SFT.Foundation SFT.Physics.RunningConvergence\nset_option maxRecDepth 20000\n'
for f,t,c in zip(fields,types,cs):
 choices=const[c];out+='\ninductive '+t+' where\n | '+ ' | '.join('c'+str(i) for i in range(len(choices)))+'\n\ndef '+f+'Name : '+t+' → String\n'+''.join(' | .c'+str(i)+' => '+q(s)+'\n' for i,s in enumerate(choices))
out+='\nstructure Candidate where\n'+''.join(' '+f+' : '+t+'\n' for f,t in zip(fields,types))
out+='\ndef sourceFields (c : Candidate) : List String := ['+','.join(f+'Name c.'+f for f in fields)+']\ndef candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)\n'
labels=['sectors','scale','coupling','successor','gap','convergence','translation','target','extension']
out+='def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " ['+','.join('SFT.Host.Text.append '+q(l+'=')+' ('+f+'Name c.'+f+')' for f,l in zip(fields,labels))+']\n'
out+='\ndef candidates : List Candidate :=\n'
for i,(f,t,c) in enumerate(zip(fields,types,cs)):
 out+=' (['+','.join(t+'.c'+str(n) for n in range(len(const[c])))+']).'+('map' if i==8 else 'flatMap')+' fun '+f+' =>\n'
out+=' ⟨'+','.join(fields)+'⟩\n\ndef survivor : Candidate := ⟨'+','.join(['.c0']*9)+'⟩\n'
out+='\ndef generationRule : String := '+q(const['GENERATION_RULE'])+'\ndef grammarBoundary : String := '+q(const['GRAMMAR_BOUNDARY'])+'\n'
out+='\nset_option maxRecDepth 100000 in\nset_option maxHeartbeats 4000000 in\ntheorem generatedCardinality : candidates.length = 8748 := rfl\n\ntheorem candidatesComplete (c : Candidate) : c ∈ candidates := by\n cases c with\n | mk '+' '.join(fields)+' =>\n'
for f,t,c in zip(fields,types,cs):
 out+='  have h'+f+' : '+f+' ∈ ['+','.join(t+'.c'+str(n) for n in range(len(const[c])))+'] := by\n   cases '+f+' <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail\n'
out+='  unfold candidates\n'
for f in fields[:-1]:out+='  apply CommonRefinement.memFlatMap _ _ '+f+' _ h'+f+'\n'
out+='  exact Count.TraceDerivation.memMap _ extension _ hextension\n\n'
out+=Path('work/running500_predicates.txt').read_text()
out+='\ndef candidateFacts (c : Candidate) : List (String × Bool) := ['+','.join('('+q(k)+','+f+'IsForced c.'+f+')' for k,f in zip(keys,fields))+']\n'
out+='def survives (c : Candidate) : Bool := (candidateFacts c).all (fun kv => kv.2)\n'
reason=next(n for n in tree.body if isinstance(n,ast.FunctionDef) and n.name=='decision_reason');reason=ast.literal_eval(reason.body[-1].value)
out+='def decisionReason (c : Candidate) : String :=\n let failures := ((candidateFacts c).filter (fun kv => !kv.2)).map Prod.fst\n if failures.isEmpty then '+q(reason)+'\n else SFT.Host.Text.append "Rejected by computed Fold predicates: " (SFT.Host.Text.append (SFT.Host.Text.intercalate ", " failures) ".")\n'
out+='\nend SFT.Physics.RunningConvergenceGrammar\n';(r/'RunningConvergenceGrammarBase.lean').write_text(out)
Path('work/running500_axes.json').write_text(json.dumps(dict(fields=fields,types=types,keys=keys,choices=[const[c] for c in cs]),indent=2))
