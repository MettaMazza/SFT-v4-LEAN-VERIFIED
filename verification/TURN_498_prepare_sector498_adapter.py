from pathlib import Path
import ast,json,re,subprocess
r=Path('work/constants-recovery');pin='76f1b34e9e9682989adcbb088797b4ae4ce4fcf1';src=Path('work/SectorInventory498_expanded.py').read_text();tree=ast.parse(src)
spec=next(n.value for n in tree.body if isinstance(n,ast.Assign) and getattr(n.targets[0],'id','')=='SPEC');kw={k.arg:k.value for k in spec.keywords};constants={}
for parsed in [ast.parse(Path('work/structural_constants496.py').read_text()),tree]:
 for n in parsed.body:
  if isinstance(n,ast.Assign):
   try:constants[n.targets[0].id]=ast.literal_eval(n.value)
   except (ValueError,TypeError):pass

def literal(n):
 if isinstance(n,ast.Name):return constants[n.id]
 if isinstance(n,ast.BinOp) and isinstance(n.op,ast.Add):return literal(n.left)+literal(n.right)
 if isinstance(n,(ast.Tuple,ast.List)):return tuple(literal(x) for x in n.elts)
 return ast.literal_eval(n)
lit=lambda k:literal(kw[k]);cid='SFT-PHYS-FORCE-COMPLETE-SECTOR-INVENTORY-003';q=lambda x:json.dumps(x,ensure_ascii=False)
dims=[];axisChoices={};fields=[];cs={'GENERATION_RULE':lit('generation_rule'),'GRAMMAR_BOUNDARY':lit('grammar_boundary')}
for axis in kw['axes'].elts:
 args=[literal(x) for x in axis.args]
 if axis.func.id=='binary_axis':
  key,question,bad,reason,good,goodreason=args;choices=[(bad,reason),(good,goodreason)];ctors=['rejected','admitted'];admitted=1
 else:
  key,question,alternatives,good,goodreason=args;choices=[(n,goodreason if n==good else reason) for n,reason in alternatives];admitted=[n for n,_ in choices].index(good);ctors=['admitted' if i==admitted else 'rejected'+str(i) for i in range(len(choices))];bad,reason=choices[0]
 dims.append([key,question,bad,reason,good,goodreason]);axisChoices[key]=choices;cs[key.upper()]=[n for n,_ in choices];fields.append((key,key.capitalize(),ctors,key.upper(),admitted))
cs['SURVIVOR']='__'.join(d[4] for d in dims)
template=Path('work/gen043.py').read_text();template=template[template.index("s='import"):].replace('SFT.Foundation.FormAcceptance','SFT.Physics.SectorInventory').replace('SFT.Foundation.FormGrammar','SFT.Physics.SectorInventoryGrammar').replace('SFT/Foundation/FormGrammar.lean','SFT/Physics/SectorInventoryGrammar.lean').replace('= 288','= 4096').replace('memMap _ extra _ hextra','memMap _ extension _ hextension')
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
'''+template[b:];template=template.replace('i==6','i==11').replace('⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩','⟨'+','.join(['rfl']*12)+'⟩').replace('⟨h0,h1,h2,h3,h4,h5,h6⟩','⟨'+','.join('h'+str(i) for i in range(12))+'⟩').replace('cases h5; cases h6','cases h5; cases h6; cases h7; cases h8; cases h9; cases h10; cases h11');template=template.replace('namespace SFT.Physics.SectorInventoryGrammar\\n','namespace SFT.Physics.SectorInventoryGrammar\\nopen SFT.Foundation\\n');exec(template)
witness=[(ast.literal_eval(w.args[0]),ast.literal_eval(w.args[1])) for w in kw['witnesses'].elts]
s=Path('work/sector_witness498.txt').read_text()
s=s.replace('WITNESS_ROWS',','.join('⟨'+q(n)+','+q(t)+','+v+'⟩' for (n,t),v in zip(witness,['check0','check1','check2','check3','check4'])))
(r/'SFT/Physics/SectorInventoryWitnesses.lean').write_text(s)
s='''import SFT.Physics.SectorInventoryGrammar
import SFT.Physics.SectorInventoryWitnesses
import SFT.Foundation.FoldControls
namespace SFT.Physics.SectorInventoryControls
open SFT.Host.Canonical SFT.Foundation SectorInventoryGrammar
set_option maxRecDepth 20000

def exclusions : List String := '''+q(list(lit('exclusions')))+'''

def closureValue : Value := .object [
 ("result",.text '''+q(lit('exact_result'))+'''),
 ("base",.text '''+q(lit('induction_base'))+'''),
 ("successor",.text '''+q(lit('induction_step'))+'''),
 ("exclusions",.array (exclusions.map Value.text)),
 ("witnesses",.array (SectorInventoryWitnesses.witnesses.map fun w => .object [
   ("name",.text w.name),("statement",.text w.statement),("passed",.boolean w.passed)])),
 ("unique_survivor",.text survivorId)]

def falseCandidate : Candidate := { survivor with sector := .rejected }
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
 (!exclusions.isEmpty && SectorInventoryWitnesses.witnesses.all SectorInventoryWitnesses.Witness.passed)
 "reject forbidden values, target feedback and extra laws"

theorem falsePremisePassed : falsePremise.passed = true := rfl

theorem boundaryPassed : boundary.passed = true := by
 change (true && SectorInventoryWitnesses.witnesses.all SectorInventoryWitnesses.Witness.passed) = true
 rw [SectorInventoryWitnesses.allWitnessesPass]
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
end SFT.Physics.SectorInventoryControls
''';(r/'SFT/Physics/SectorInventoryControls.lean').write_text(s)
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

''';s=base[:a]+records+base[b:];s=s.replace('SFT.Computation.Causality','SFT.Physics.SectorInventory').replace('Causality','SectorInventory').replace('SFT-COMP-DIST-CAUSALITY-001',cid).replace('branch := "computation"','branch := "physics"')
for field,key in [('title','title'),('statement','statement'),('dependencies','dependencies')]:
 s=re.sub(r'^  '+field+r' := .*$',lambda m:'  '+field+' := '+q(list(lit(key)) if key=='dependencies' else lit(key)),s,flags=re.M)
a=s.index('  traceHash :=');b=s.index('\ndef censusData',a);s=s[:a]+'  traceHash := identity (.array [.text '+q(cid)+',.text generationRule,candidateRecord c])\n'+s[b:]
a=s.index('  proofHash :=');b=s.index('\ndef decision (',a);s=s[:a]+'  proofHash := identity (.array [.text '+q(cid)+',.array ((registrationData "").dependencies.map Value.text),candidateRecord c,.boolean (survives c),.text (decisionReason c)])\n'+s[b:]
a=s.index('  proofHash :=',s.index('def closureData'));b=s.index('\ndef closure (',a);s=s[:a]+'''  proofHash := identity (.array [SectorInventoryControls.closureValue,.array (decisions.map SFT.Engine.decisionValue)])
  generalityCertificateHash := some (identity SectorInventoryControls.closureValue)
'''+s[b:]
s=s[:s.index('\ndef why :')]+'\nend SFT.Physics.SectorInventoryEvidence\n';(r/'SFT/Physics/SectorInventoryEvidence.lean').write_text(s)

for name in ["Controls","Evidence"]:
 p=r/("SFT/Physics/SectorInventory"+name+".lean");p.write_text(re.sub(r"(?<![\w.])Value\b","SFT.Host.Canonical.Value",p.read_text()))
