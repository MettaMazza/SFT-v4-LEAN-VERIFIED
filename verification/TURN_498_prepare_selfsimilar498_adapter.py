from pathlib import Path
import ast,json,re
r=Path('work/constants-recovery');raw=Path('work/mathematics_lineage_laws497.py').read_text();tree=ast.parse(raw);spec=next(n.value for n in tree.body if isinstance(n,ast.Assign) and getattr(n.targets[0],'id','')=='SELF_SIMILAR_CONVERGENCE');kw={x.arg:x.value for x in spec.keywords};q=lambda x:json.dumps(x,ensure_ascii=False)
dims=[]
for x in kw['dimensions'].elts:
 k,bad,reason,good,why=map(ast.literal_eval,x.args);dims.append([k,k.replace('_',' ')+'?',bad,reason,good,why])
constants={n.targets[0].id:ast.literal_eval(n.value) for n in tree.body if isinstance(n,ast.Assign) and getattr(n.targets[0],'id','')=='COMMON_BOUNDARY'}
cs={'SURVIVOR':'__'.join(d[4] for d in dims),'GENERATION_RULE':ast.literal_eval(kw['generation_rule']),'GRAMMAR_BOUNDARY':ast.literal_eval(kw['grammar_boundary'])};fields=[];field=lambda x:x
for k,question,bad,reason,good,why in dims:cs[k.upper()]=[bad,good];fields.append((k,k.capitalize(),['rejected','admitted'],k.upper(),1))
s=Path('work/algebra_grammar085.py').read_text();s=s[s.index("template=Path('work/gen043.py')"):].replace('Algebra','SelfSimilar').replace("'i==8'","'i==7'").replace("'= 512'","'= 256'").replace('rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl','rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl').replace('h0,h1,h2,h3,h4,h5,h6,h7,h8','h0,h1,h2,h3,h4,h5,h6,h7').replace('cases h6; cases h7; cases h8','cases h6; cases h7');exec(s)
rows=[(ast.literal_eval(w.args[0]),ast.literal_eval(w.args[1])) for w in kw['witnesses'].elts]
exprs=['originalLocalWitness','originalSupportWitness','originalExponentWitness','originalGapWitness','originalBracketWitness']
proofs=['originalLocalWitnessPassed','originalSupportWitnessPassed','originalExponentWitnessPassed','originalGapWitnessPassed','originalBracketWitnessPassed']
s='import SFT.Mathematics.SelfSimilarConvergence\nnamespace SFT.Mathematics.SelfSimilarWitnesses\nstructure Witness where\n name : String\n statement : String\n passed : Bool\n'
for i,((key,statement),expr,proof) in enumerate(zip(rows,exprs,proofs)):
 s+=f'def check{i} : Bool := SelfSimilarConvergence.{expr}\ntheorem check{i}Passed : check{i} = true := SelfSimilarConvergence.{proof}\n'
s+='def witnesses : List Witness := ['+','.join('⟨'+q(key)+','+q(statement)+',check'+str(i)+'⟩' for i,(key,statement) in enumerate(rows))+']\ntheorem allWitnessesPass : witnesses.all Witness.passed = true := rfl\nend SFT.Mathematics.SelfSimilarWitnesses\n'
(r/'SFT/Mathematics/SelfSimilarWitnesses.lean').write_text(s)
s=(r/'SFT/Mathematics/AlgebraControls.lean').read_text().replace('Algebra','SelfSimilar').replace('with carrier :=','with scale :=')
for key in ['laws']:
 s=re.sub(r'^def '+key+r' : List String := .*$',lambda _: 'def '+key+' : List String := '+q(ast.literal_eval(kw[key])),s,flags=re.M)
s=re.sub(r'^def exclusions : List String := .*$',lambda _: 'def exclusions : List String := '+q(constants['COMMON_BOUNDARY']),s,flags=re.M)
for k in ['exact_result','induction_base','induction_step']:
 s=re.sub(r'\("'+k+r'",\.text ".*?"\)',lambda _: '('+q(k)+',.text '+q(ast.literal_eval(kw[k]))+')',s)
(r/'SFT/Mathematics/SelfSimilarControls.lean').write_text(s)
s=Path('work/algebra_evidence086.py').read_text();s=s[s.index("s=(r/'SFT/Foundation/FormEvidence.lean')"):].replace('Algebra','SelfSimilar').replace('SFT-MATH-ALGEBRA-001','SFT-MATH-SELF-SIMILAR-CONVERGENCE-002');exec(s)
s=Path('work/bounded_census379.py').read_text().replace('SFT/Physics','SFT/Mathematics').replace('SFT.Physics','SFT.Mathematics');a=s.index('for name,source in ');b=s.index(':\n s=Path(source)',a);s=s[:a]+"for name,source in [('SelfSimilar',str(root/'SelfSimilarGrammar.lean'))]"+s[b:];s=s.replace('work/bounded_census379_config.json','work/selfsimilar_census498_config.json');exec(s)
