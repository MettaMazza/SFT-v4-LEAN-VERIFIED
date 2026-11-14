from pathlib import Path
import ast,json,re,subprocess
r=Path('work/constants-recovery');pin='76f1b34e9e9682989adcbb088797b4ae4ce4fcf1';src=subprocess.check_output(['git','-C','/Volumes/One Touch/ernos-labs-sft-platform','show',pin+':sft/physics/sector_inventory_validation_v1.py'],text=True);tree=ast.parse(src)
spec=next(n.value for n in tree.body if isinstance(n,ast.Assign) and getattr(n.targets[0],'id','')=='SPEC');kw={k.arg:k.value for k in spec.keywords};constants={n.targets[0].id:ast.literal_eval(n.value) for n in tree.body if isinstance(n,ast.Assign) and isinstance(n.value,ast.Constant) and isinstance(n.value.value,str)}
def literal(n):
 if isinstance(n,ast.Name):return constants[n.id]
 if isinstance(n,(ast.Tuple,ast.List)):return tuple(literal(x) for x in n.elts)
 return ast.literal_eval(n)
lit=lambda k:literal(kw[k]);cid='SFT-PHYS-SPACE-DIMENSION-THREE-001';q=lambda x:json.dumps(x,ensure_ascii=False)

empirical=subprocess.check_output(['git','-C','/Volumes/One Touch/ernos-labs-sft-platform','show',pin+':sft/physics/generated_empirical_law.py'],text=True)
fn=next(n for n in ast.parse(empirical).body if isinstance(n,ast.FunctionDef) and n.name=='empirical_dimensions')
bindings=dict(zip([a.arg for a in fn.args.args],kw['dimensions'].args))
class Substitute(ast.NodeTransformer):
 def visit_Name(self,node):return bindings.get(node.id,node)
axes=Substitute().visit(next(n.value for n in fn.body if isinstance(n,ast.Return)))
for axis in axes.elts:
 axis.func.id='binary_axis'
 axis.args.insert(1,ast.Constant(value=''))
kw['axes']=axes

dims=[];axisChoices={};fields=[];cs={'GENERATION_RULE':lit('generation_rule'),'GRAMMAR_BOUNDARY':lit('grammar_boundary')}
for axis in kw['axes'].elts:
 args=[literal(x) for x in axis.args]
 if axis.func.id=='binary_axis':
  key,question,bad,reason,good,goodreason=args;choices=[(bad,reason),(good,goodreason)];ctors=['rejected','admitted'];admitted=1
 else:
  key,question,alternatives,good,goodreason=args;choices=[(n,goodreason if n==good else reason) for n,reason in alternatives];admitted=[n for n,_ in choices].index(good);ctors=['admitted' if i==admitted else 'rejected'+str(i) for i in range(len(choices))];bad,reason=choices[0]
 dims.append([key,question,bad,reason,good,goodreason]);axisChoices[key]=choices;cs[key.upper()]=[n for n,_ in choices];fields.append((key,key.capitalize(),ctors,key.upper(),admitted))
cs['SURVIVOR']='__'.join(d[4] for d in dims)
template=Path('work/gen043.py').read_text();template=template[template.index("s='import"):].replace('SFT.Foundation.FormAcceptance','SFT.Physics.PrecisionValidationWitnesses').replace('SFT.Foundation.FormGrammar','SFT.Physics.SectorValidationGrammar').replace('SFT/Foundation/FormGrammar.lean','SFT/Physics/SectorValidationGrammar.lean').replace('i==6','i==7').replace('= 288','= 256').replace('memMap _ extra _ hextra','memMap _ extension _ hextension').replace('⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩','⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩').replace('⟨h0,h1,h2,h3,h4,h5,h6⟩','⟨h0,h1,h2,h3,h4,h5,h6,h7⟩').replace('cases h6\\n','cases h6; cases h7\\n')
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
'''+template[b:];template=template.replace('namespace SFT.Physics.SectorValidationGrammar\\n','namespace SFT.Physics.SectorValidationGrammar\\nopen SFT.Foundation\\n');exec(template)
