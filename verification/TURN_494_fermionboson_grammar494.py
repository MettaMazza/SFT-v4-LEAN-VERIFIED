from pathlib import Path
exec(Path('work/fermionboson_spec494.py').read_text())
cs={'SURVIVOR':'__'.join(d[4] for d in dims),'GENERATION_RULE':ast.literal_eval(kw['generation_rule']),'GRAMMAR_BOUNDARY':ast.literal_eval(kw['grammar_boundary'])};fields=[]
field=lambda x:'returns' if x=='return' else x
for key,question,bad,reason,good,goodreason in dims:cs[key.upper()]=[bad,good];fields.append((field(key),key.capitalize(),['rejected','admitted'],key.upper(),1))
q=lambda x:json.dumps(x,ensure_ascii=False)
template=Path('work/gen043.py').read_text();template=template[template.index("s='import"):];template=template.replace('SFT.Foundation.FormAcceptance','«work».FermionBosonCarrier494').replace('SFT.Foundation.FormGrammar','SFT.Physics.FermionBosonGrammar').replace('SFT/Foundation/FormGrammar.lean','SFT/Physics/FermionBosonGrammar.lean').replace('i==6','i==7').replace('= 288','= 256').replace('memMap _ extra _ hextra','memMap _ extension _ hextension').replace('⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩','⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩').replace('⟨h0,h1,h2,h3,h4,h5,h6⟩','⟨h0,h1,h2,h3,h4,h5,h6,h7⟩').replace('cases h6\\n','cases h6; cases h7\\n')
a=template.index("s+='def candidateId");b=template.index("s+='def survivorId",a)
template=template[:a]+'''s+='def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)\\n'
s+='def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " ['+', '.join('SFT.Host.Text.append '+q(key+'=')+' ('+field(key)+'Name c.'+field(key)+')' for key,*_ in dims)+']\\n'
'''+template[b:]
a=template.index('fn=next');b=template.index("s+='def generationRule",a)
template=template[:a]+'''s+='def decisionReason (c : Candidate) : String :=\\n'
for key,question,bad,reason,good,goodreason in dims:s+='  if !(SFT.Host.Text.equal ('+field(key)+'Name c.'+field(key)+') '+q(good)+') then '+q(reason)+' else\\n'
s+='  '+q(ast.literal_eval(kw['exact_result']))+'\\n\\n'
'''+template[b:]
template=template.replace('namespace SFT.Physics.FermionBosonGrammar\\n','namespace SFT.Physics.FermionBosonGrammar\\nopen SFT.Foundation\\n')
template=template.replace("(r/'SFT/Physics/FermionBosonGrammar.lean')","Path('work/FermionBosonGrammar494.lean')")
exec(template)
