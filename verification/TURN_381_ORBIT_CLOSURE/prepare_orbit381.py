from pathlib import Path
import ast,json,re
r=Path('work/constants-recovery');raw=Path('work/pinned-constants/mathematics_lineage_laws.py').read_text();tree=ast.parse(raw);spec=next(n.value for n in tree.body if isinstance(n,ast.Assign) and getattr(n.targets[0],'id','')=='ORBIT_NUMBER_THEORY');kw={x.arg:x.value for x in spec.keywords};q=lambda x:json.dumps(x,ensure_ascii=False)
dims=[]
for x in kw['dimensions'].elts:
 k,bad,reason,good,why=map(ast.literal_eval,x.args);dims.append([k,k.replace('_',' ')+'?',bad,reason,good,why])
constants={n.targets[0].id:ast.literal_eval(n.value) for n in tree.body if isinstance(n,ast.Assign) and getattr(n.targets[0],'id','')=='COMMON_BOUNDARY'}
cs={'SURVIVOR':'__'.join(d[4] for d in dims),'GENERATION_RULE':ast.literal_eval(kw['generation_rule']),'GRAMMAR_BOUNDARY':ast.literal_eval(kw['grammar_boundary'])};fields=[];field=lambda x:x
for k,question,bad,reason,good,why in dims:cs[k.upper()]=[bad,good];fields.append((k,k.capitalize(),['rejected','admitted'],k.upper(),1))
s=Path('work/algebra_grammar085.py').read_text();s=s[s.index("template=Path('work/gen043.py')"):].replace('Algebra','Orbit').replace("'i==8'","'i==7'").replace("'= 512'","'= 256'").replace('rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl','rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl').replace('h0,h1,h2,h3,h4,h5,h6,h7,h8','h0,h1,h2,h3,h4,h5,h6,h7').replace('cases h6; cases h7; cases h8','cases h6; cases h7');exec(s)
# Wrapper records preserve the four original witness values; proofs reuse the
# completed original census rather than evaluating it again inside a wrapper.
rows=[(ast.literal_eval(w.args[0]),ast.literal_eval(w.args[1])) for w in kw['witnesses'].elts]
names=['orders','allReduced','primeDivision','tiling'];expressions=['orderExamples','allReducedRanks','primeDivision','orbitTiling'];proofs=['originalOrders','originalAllReducedRanks','originalPrimeDivision','originalOrbitTiling']
s='import SFT.Mathematics.OrbitNumberWitnesses\nimport SFT.Mathematics.OrbitLoopCompletion\nnamespace SFT.Mathematics.OrbitWitnesses\nstructure Witness where\n name : String\n statement : String\n passed : Bool\n'
for name,(key,statement),expr,proof in zip(names,rows,expressions,proofs):
 s+=f'def {name} : Witness := ⟨{q(key)},{q(statement)},OrbitNumberWitnesses.{expr}⟩\ntheorem {name}Passed : {name}.passed = true := OrbitNumberWitnesses.{proof}\n'
s+='def witnesses : List Witness := ['+','.join(names)+']\ntheorem allWitnessesPass : witnesses.all Witness.passed = true := by\n change ('+' && '.join(n+'.passed' for n in names)+' && true) = true\n rw ['+','.join(n+'Passed' for n in names)+']\n rfl\nend SFT.Mathematics.OrbitWitnesses\n'
# List.all is right-associated, unlike parsed && chains.
s=s.replace('change ('+' && '.join(n+'.passed' for n in names)+' && true) = true','change ('+''.join(n+'.passed && (' for n in names)+'true'+')'*len(names)+') = true')
(r/'SFT/Mathematics/OrbitWitnesses.lean').write_text(s)
s=(r/'SFT/Mathematics/AlgebraControls.lean').read_text().replace('Algebra','Orbit').replace('with carrier :=','with domain :=')
for key in ['laws']:
 s=re.sub(r'^def '+key+r' : List String := .*$',lambda _: 'def '+key+' : List String := '+q(ast.literal_eval(kw[key])),s,flags=re.M)
s=re.sub(r'^def exclusions : List String := .*$',lambda _: 'def exclusions : List String := '+q(constants['COMMON_BOUNDARY']),s,flags=re.M)
for k in ['exact_result','induction_base','induction_step']:
 s=re.sub(r'\("'+k+r'",\.text ".*?"\)',lambda _: '('+q(k)+',.text '+q(ast.literal_eval(kw[k]))+')',s)
(r/'SFT/Mathematics/OrbitControls.lean').write_text(s)
s=Path('work/algebra_evidence086.py').read_text();s=s[s.index("s=(r/'SFT/Foundation/FormEvidence.lean')"):].replace('Algebra','Orbit').replace('SFT-MATH-ALGEBRA-001','SFT-MATH-ORBIT-NUMBER-THEORY-002');exec(s)
s=Path('work/bounded_census379.py').read_text().replace('SFT/Physics','SFT/Mathematics').replace('SFT.Physics','SFT.Mathematics');a=s.index('for name,source in ');b=s.index(':\n s=Path(source)',a);s=s[:a]+"for name,source in [('Orbit',str(root/'OrbitGrammar.lean'))]"+s[b:];s=s.replace('work/bounded_census379_config.json','work/orbit_census381_config.json');exec(s)
