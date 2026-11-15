from pathlib import Path
import json,sys
w=Path('work');c=Path('/Volumes/One Touch/SFT v4 Full model LEAN');sys.path.insert(0,str((w/'v3-runtime500').resolve()));from sft.physics import static_exterior_clock_terminal_law_v1 as src
q=json.dumps;axes=[('horizon','horizon','HORIZON_NORMALIZATIONS','exactFacts'),('field','field','FIELD_LAWS','exactFacts'),('well','well','WELL_LAWS','exactFacts'),('coefficient','coefficient','COEFFICIENT_LAWS','exactFacts'),('clock','clock','CLOCK_LAWS','exactFacts'),('boundary','boundary','BOUNDARY_LAWS','exactFacts'),('target','target','TARGET_BOUNDARIES','true'),('extension','extension','EXTENSIONS','true')]
ns='StaticExteriorClock';s=f'''import SFT.Physics.{ns}Certificate
import SFT.Foundation.CommonRefinement
namespace SFT.Physics.{ns}Grammar
open {ns}Certificate
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
'''
for k,label,const,var in axes:
 vals=getattr(src,const);s+=f'inductive {k.capitalize()} where\n'+''.join(f' | c{i}\n' for i in range(len(vals)))+f'def {k}Name : {k.capitalize()} → String\n'+''.join(f' | .c{i} => {q(v)}\n' for i,v in enumerate(vals))+f'def {k}Passed : {k.capitalize()} → Bool\n'+''.join(f' | .c{i} => {str(i==0).lower()}\n' for i,v in enumerate(vals))
keys=[x[0] for x in axes];s+='structure Candidate where\n'+''.join(f' {k} : {k.capitalize()}\n' for k in keys)
s+='def sourceFields (c : Candidate) : List String := ['+','.join(f'{k}Name c.{k}' for k in keys)+']\ndef candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)\ndef candidateFacts (c : Candidate) : Except String (List (String × Bool)) := do\n let exactFacts ← certificateFacts\n pure ['+','.join('('+q(label)+','+(f'{k}Passed c.{k}' if var=='true' else f'({k}Passed c.{k} && ({var}))')+')' for k,label,_,var in axes)+']\ndef computedFacts (c : Candidate) : List (String × Bool) := ['+','.join('('+q(label)+','+f'{k}Passed c.{k})' for k,label,_,_ in axes)+']\ntheorem factsComputed (c : Candidate) : candidateFacts c=.ok (computedFacts c) := by\n unfold candidateFacts\n rw [originalComputedFacts]\n cases c with\n | mk '+ ' '.join(keys)+' =>\n  '+' <;> '.join('cases '+k for k in keys)+' <;> rfl\ndef survives (c : Candidate) : Bool := (computedFacts c).all Prod.snd\ndef sourceSurvives (c : Candidate) : Except String Bool := do pure ((← candidateFacts c).all Prod.snd)\ntheorem sourceDecision (c : Candidate) : sourceSurvives c=.ok (survives c) := by\n unfold sourceSurvives\n rw [factsComputed]\n rfl\ndef candidates : List Candidate :=\n'
for i,(k,_,const,_) in enumerate(axes):s+=' ['+','.join('.c'+str(j) for j in range(len(getattr(src,const))))+'].'+('map' if i==7 else 'flatMap')+' (fun '+k+' =>'+('\n' if i!=7 else ' ⟨'+','.join(keys)+'⟩'+')'*8+'\n')
s+='def survivor : Candidate := ⟨'+','.join(['.c0']*8)+'⟩\ntheorem candidateCount : candidates.length=2916 := rfl\ntheorem uniqueSurvivor (c : Candidate) : survives c=true → c=survivor := by\n rcases c with ⟨'+','.join(keys)+'⟩\n '+' <;> '.join('cases '+k for k in keys)+' <;> intro h <;> first | rfl | contradiction\ntheorem survivorAccepted : survives survivor=true := rfl\ntheorem candidatesComplete (c : Candidate) : c∈candidates := by\n rcases c with ⟨'+','.join(keys)+'⟩\n'
for k,_,const,_ in axes:s+=f' have h{k} : {k}∈['+','.join(k.capitalize()+'.c'+str(j) for j in range(len(getattr(src,const))))+f'] := by\n  cases {k} <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail\n'
s+=' unfold candidates\n'+''.join(f' apply SFT.Foundation.CommonRefinement.memFlatMap _ _ {k} _ h{k}\n' for k in keys[:-1])+f' exact SFT.Foundation.Count.TraceDerivation.memMap _ extension _ hextension\ndef generationRule : String := {q(src.GENERATION_RULE)}\ndef grammarBoundary : String := {q(src.GRAMMAR_BOUNDARY)}\nend SFT.Physics.{ns}Grammar\n'
for r in [c,w/'constants-recovery']:
 p=r/f'SFT/Physics/{ns}Grammar.lean';assert not p.exists();p.write_text(s)
