from pathlib import Path
import ast,json,re
r=Path('work/constants-recovery');raw=Path('work/pinned-constants/mathematics_lineage_laws.py').read_text();tree=ast.parse(raw);spec=next(n.value for n in tree.body if isinstance(n,ast.Assign) and getattr(n.targets[0],'id','')=='EXACT_RELATIONS');kw={x.arg:x.value for x in spec.keywords};q=lambda x:json.dumps(x,ensure_ascii=False)
dims=[]
for x in kw['dimensions'].elts:
 k,bad,reason,good,why=map(ast.literal_eval,x.args);dims.append([k,k.replace('_',' ')+'?',bad,reason,good,why])
constants={n.targets[0].id:ast.literal_eval(n.value) for n in tree.body if isinstance(n,ast.Assign) and getattr(n.targets[0],'id','')=='COMMON_BOUNDARY'}
cs={'SURVIVOR':'__'.join(d[4] for d in dims),'GENERATION_RULE':ast.literal_eval(kw['generation_rule']),'GRAMMAR_BOUNDARY':ast.literal_eval(kw['grammar_boundary'])};fields=[];field=lambda x:x
for k,question,bad,reason,good,why in dims:cs[k.upper()]=[bad,good];fields.append((k,k.capitalize(),['rejected','admitted'],k.upper(),1))
s=Path('work/algebra_grammar085.py').read_text();s=s[s.index("template=Path('work/gen043.py')"):].replace('Algebra','ExactRelations').replace("'i==8'","'i==7'").replace("'= 512'","'= 256'").replace('rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl','rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl').replace('h0,h1,h2,h3,h4,h5,h6,h7,h8','h0,h1,h2,h3,h4,h5,h6,h7').replace('cases h6; cases h7; cases h8','cases h6; cases h7');exec(s)
# Exact source witness computations.
rows=[(ast.literal_eval(w.args[0]),ast.literal_eval(w.args[1])) for w in kw['witnesses'].elts]
exprs=["let z := compose (ratio 3 2 (by decide) (by decide)) (ratio 2 3 (by decide) (by decide)); z.numerator == 1 && z.denominator == 1",
"let z := compose (ratio 8 1 (by decide) (by decide)) (ratio 1 8 (by decide) (by decide)); z.numerator == 1 && z.denominator == 1",
"let z := compose (ratio 5 3 (by decide) (by decide)) (ratio 3 2 (by decide) (by decide)); z.numerator == 5 && z.denominator == 2",
"let z := HoldingComplement.complement 0; z.numerator == 1 && z.denominator == 2",
"Nat.lcm (Nat.lcm 2 3) 4 == 12"]
s='import SFT.Mathematics.HoldingComplement\nimport Init.Data.Nat.Lcm\nnamespace SFT.Mathematics.ExactRelationsWitnesses\nopen ExactRatioRelations\nstructure Witness where\n name : String\n statement : String\n passed : Bool\n'
for i,((key,statement),expr) in enumerate(zip(rows,exprs)):
 s+=f'def check{i} : Bool := {expr}\ntheorem check{i}Passed : check{i} = true := rfl\n'
s+='def witnesses : List Witness := ['+','.join('⟨'+q(key)+','+q(statement)+',check'+str(i)+'⟩' for i,(key,statement) in enumerate(rows))+']\ntheorem allWitnessesPass : witnesses.all Witness.passed = true := rfl\nend SFT.Mathematics.ExactRelationsWitnesses\n'
(r/'SFT/Mathematics/ExactRelationsWitnesses.lean').write_text(s)
s=(r/'SFT/Mathematics/AlgebraControls.lean').read_text().replace('Algebra','ExactRelations').replace('with carrier :=','with provenance :=')
for key in ['laws']:
 s=re.sub(r'^def '+key+r' : List String := .*$',lambda _: 'def '+key+' : List String := '+q(ast.literal_eval(kw[key])),s,flags=re.M)
s=re.sub(r'^def exclusions : List String := .*$',lambda _: 'def exclusions : List String := '+q(constants['COMMON_BOUNDARY']),s,flags=re.M)
for k in ['exact_result','induction_base','induction_step']:
 s=re.sub(r'\("'+k+r'",\.text ".*?"\)',lambda _: '('+q(k)+',.text '+q(ast.literal_eval(kw[k]))+')',s)
(r/'SFT/Mathematics/ExactRelationsControls.lean').write_text(s)
s=Path('work/algebra_evidence086.py').read_text();s=s[s.index("s=(r/'SFT/Foundation/FormEvidence.lean')"):].replace('Algebra','ExactRelations').replace('SFT-MATH-ALGEBRA-001','SFT-MATH-EXACT-RELATIONS-002');exec(s)
s=Path('work/bounded_census379.py').read_text().replace('SFT/Physics','SFT/Mathematics').replace('SFT.Physics','SFT.Mathematics');a=s.index('for name,source in ');b=s.index(':\n s=Path(source)',a);s=s[:a]+"for name,source in [('ExactRelations',str(root/'ExactRelationsGrammar.lean'))]"+s[b:];s=s.replace('work/bounded_census379_config.json','work/exactrelations_census389_config.json');exec(s)
