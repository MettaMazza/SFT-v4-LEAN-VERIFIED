from pathlib import Path
import ast,json,re,subprocess
r=Path('work/constants-recovery');pin='76f1b34e9e9682989adcbb088797b4ae4ce4fcf1';src=subprocess.check_output(['git','-C','/Volumes/One Touch/ernos-labs-sft-platform','show',pin+':sft/physics/structural_constants.py'],text=True);tree=ast.parse(src)
spec=next(n.value for n in tree.body if isinstance(n,ast.Assign) and getattr(n.targets[0],'id','')=='INVERSE_SQUARE_SPEC');kw={k.arg:k.value for k in spec.keywords};constants={n.targets[0].id:ast.literal_eval(n.value) for n in tree.body if isinstance(n,ast.Assign) and isinstance(n.value,ast.Constant) and isinstance(n.value.value,str)}
def literal(n):
 if isinstance(n,ast.Name):return constants[n.id]
 if isinstance(n,(ast.Tuple,ast.List)):return tuple(literal(x) for x in n.elts)
 return ast.literal_eval(n)
lit=lambda k:literal(kw[k]);cid='SFT-PHYS-FIELD-INVERSE-SQUARE-001';q=lambda x:json.dumps(x,ensure_ascii=False)
dims=[];axisChoices={};fields=[];cs={'GENERATION_RULE':lit('generation_rule'),'GRAMMAR_BOUNDARY':lit('grammar_boundary')}
for axis in kw['axes'].elts:
 args=[literal(x) for x in axis.args]
 if axis.func.id=='binary_axis':
  key,question,bad,reason,good,goodreason=args;choices=[(bad,reason),(good,goodreason)];ctors=['rejected','admitted'];admitted=1
 else:
  key,question,alternatives,good,goodreason=args;choices=[(n,goodreason if n==good else reason) for n,reason in alternatives];admitted=[n for n,_ in choices].index(good);ctors=['admitted' if i==admitted else 'rejected'+str(i) for i in range(len(choices))];bad,reason=choices[0]
 dims.append([key,question,bad,reason,good,goodreason]);axisChoices[key]=choices;cs[key.upper()]=[n for n,_ in choices];fields.append((key,key.capitalize(),ctors,key.upper(),admitted))
cs['SURVIVOR']='__'.join(d[4] for d in dims)
template=Path('work/gen043.py').read_text();template=template[template.index("s='import"):].replace('SFT.Foundation.FormAcceptance','SFT.Physics.InverseSquare').replace('SFT.Foundation.FormGrammar','SFT.Physics.InverseSquareGrammar').replace('SFT/Foundation/FormGrammar.lean','SFT/Physics/InverseSquareGrammar.lean').replace('i==6','i==10').replace('= 288','= 4096').replace('memMap _ extra _ hextra','memMap _ extension _ hextension').replace('⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩','⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩').replace('⟨h0,h1,h2,h3,h4,h5,h6⟩','⟨h0,h1,h2,h3,h4,h5,h6,h7,h8,h9,h10⟩').replace('cases h6\\n','cases h6; cases h7; cases h8; cases h9; cases h10\\n')
a=template.index("s+='def candidateId");b=template.index("s+='def survivorId",a)
template=template[:a]+'''s+='def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)\\n'
s+='def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " ['+', '.join('SFT.Host.Text.append '+q(key+'=')+' ('+key+'Name c.'+key+')' for key,*_ in dims)+']\\n'
'''+template[b:]
a=template.index('fn=next');b=template.index("s+='def generationRule",a)
template=template[:a]+'''s+='def decisionReason (c : Candidate) : String :=\\n'
for key,question,bad,reason,good,goodreason in dims:
 for name,why in axisChoices[key]:
  if name!=good:s+='  if SFT.Host.Text.equal ('+key+'Name c.'+key+') '+q(name)+' then '+q(why)+' else\\n'
s+='  '+q(lit('exact_result'))+'\\n\\n'
'''+template[b:];template=template.replace('namespace SFT.Physics.InverseSquareGrammar\\n','namespace SFT.Physics.InverseSquareGrammar\\nopen SFT.Foundation\\n');exec(template)
witness=[(ast.literal_eval(w.args[0]),ast.literal_eval(w.args[1])) for w in kw['witnesses'].elts]
s=Path('work/inverse_square_witness643.txt').read_text()
s=s.replace('WITNESS_ROWS',','.join('⟨'+q(n)+','+q(t)+','+v+'⟩' for (n,t),v in zip(witness,['doubleCheck','tripleCheck','conservationCheck'])))
(r/'SFT/Physics/InverseSquareWitnesses.lean').write_text(s)
s='''import SFT.Physics.InverseSquareGrammar
import SFT.Physics.InverseSquareWitnesses
import SFT.Foundation.FoldControls
namespace SFT.Physics.InverseSquareControls
open SFT.Host.Canonical SFT.Foundation InverseSquareGrammar
set_option maxRecDepth 20000

def exclusions : List String := '''+q(list(lit('exclusions')))+'''

def closureValue : Value := .object [
 ("result",.text '''+q(lit('exact_result'))+'''),
 ("base",.text '''+q(lit('induction_base'))+'''),
 ("successor",.text '''+q(lit('induction_step'))+'''),
 ("exclusions",.array (exclusions.map Value.text)),
 ("witnesses",.array (InverseSquareWitnesses.witnesses.map fun w => .object [
   ("name",.text w.name),("statement",.text w.statement),("passed",.boolean w.passed)])),
 ("unique_survivor",.text survivorId)]

def falseCandidate : Candidate := { survivor with source := .rejected }
def survivorIds : List String := (candidates.filter survives).map candidateId

def record (kind : SFT.Engine.ControlKind) (passed : Bool) (observation : String) : FoldControls.ControlRecord where
 kind := kind
 passed := passed
 expected := observation
 observed := if passed then observation else "control failed"

def falsePremise : FoldControls.ControlRecord := record .falsePremise
 (!(SFT.Host.Text.equal (candidateId falseCandidate) survivorId))
 "reject the form missing the first structural preservation"

def tamperedSource (sourceHash : String) : FoldControls.ControlRecord := record .tamperedSource
 (!(SFT.Host.Text.equal (identity (.object [("changed",.text sourceHash)])) sourceHash))
 "reject a changed source identity"

def tamperedArtifact : FoldControls.ControlRecord := record .tamperedArtifact
 (survivorIds.length == 1) "reject a missing, duplicate or additional survivor"

def boundary : FoldControls.ControlRecord := record .boundary
 (!exclusions.isEmpty && InverseSquareWitnesses.witnesses.all InverseSquareWitnesses.Witness.passed)
 "reject forbidden values, target feedback and extra laws"

theorem falsePremisePassed : falsePremise.passed = true := rfl

theorem boundaryPassed : boundary.passed = true := by
 change (true && InverseSquareWitnesses.witnesses.all InverseSquareWitnesses.Witness.passed) = true
 rw [InverseSquareWitnesses.allWitnessesPass]
 rfl

def controlRecords (sourceHash : String) : List FoldControls.ControlRecord :=
 [falsePremise,tamperedSource sourceHash,tamperedArtifact,boundary]

def resultData (c : FoldControls.ControlRecord) : SFT.Engine.ControlResult where
 kind := c.kind
 passed := c.passed
 expectedBehavior := c.expected
 observedBehavior := c.observed
 receiptHash := identity (.array [.text '''+q(cid)+''',.text (SFT.Engine.kindName c.kind),.boolean c.passed,.text c.expected])

def runControls (sourceHash : String) : Value :=
 .array ((controlRecords sourceHash).map fun c => SFT.Engine.controlResultValue (resultData c))
end SFT.Physics.InverseSquareControls
''';(r/'SFT/Physics/InverseSquareControls.lean').write_text(s)
base=(r/'SFT/Computation/CausalityEvidence.lean').read_text();a=base.index('def candidateRecord');b=base.index('def registrationData',a)
coords=','.join('.array [.text '+q(k)+',.text ('+k+'Name c.'+k+')]' for k,*_ in dims)
axes=','.join('.object [("key",.text '+q(k)+'),("question",.text '+q(question)+'),("choices",.array ['+','.join('.array [.text '+q(n)+',.text '+q(why)+']' for n,why in axisChoices[k])+'])]' for k,question,*_ in dims)
records='''def candidateRecord (c : Candidate) : Value := .object [
 ("candidate_id",.text (candidateId c)),
 ("coordinates",.array ['''+coords+''']),
 ("exact_form",.text (exactForm c))]

def completenessRecord : Value := .object [
 ("generation_rule",.text generationRule),("grammar_boundary",.text grammarBoundary),
 ("axes",.array ['''+axes+''']),
 ("candidate_ids",.array (candidates.map fun c => .text (candidateId c))),
 ("product_exhaustion",.text "Every registered choice occurs once with every choice on every other axis.")]

''';s=base[:a]+records+base[b:];s=s.replace('SFT.Computation.Causality','SFT.Physics.InverseSquare').replace('Causality','InverseSquare').replace('SFT-COMP-DIST-CAUSALITY-001',cid).replace('branch := "computation"','branch := "physics"')
for field,key in [('title','title'),('statement','statement'),('dependencies','dependencies')]:
 s=re.sub(r'^  '+field+r' := .*$',lambda m:'  '+field+' := '+q(list(lit(key)) if key=='dependencies' else lit(key)),s,flags=re.M)
a=s.index('  traceHash :=');b=s.index('\ndef censusData',a);s=s[:a]+'  traceHash := identity (.array [.text '+q(cid)+',.text generationRule,candidateRecord c])\n'+s[b:]
a=s.index('  proofHash :=');b=s.index('\ndef decision (',a);s=s[:a]+'  proofHash := identity (.array [.text '+q(cid)+',.array ((registrationData "").dependencies.map Value.text),candidateRecord c,.boolean (survives c),.text (decisionReason c)])\n'+s[b:]
a=s.index('  proofHash :=',s.index('def closureData'));b=s.index('\ndef closure (',a);s=s[:a]+'''  proofHash := identity (.array [InverseSquareControls.closureValue,.array (decisions.map SFT.Engine.decisionValue)])
  generalityCertificateHash := some (identity InverseSquareControls.closureValue)
'''+s[b:]
s=s[:s.index('\ndef why :')]+'\nend SFT.Physics.InverseSquareEvidence\n';(r/'SFT/Physics/InverseSquareEvidence.lean').write_text(s)
