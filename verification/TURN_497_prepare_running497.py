from pathlib import Path
import ast,copy,json
entries=[('StrongRunning','STRONG_RUNNING_SPEC','lineage_particle_laws','common_axes','SFT-PHYS-STRONG-RUNNING-DIRECTION-002'),('VacuumPolarization','VACUUM_POLARIZATION_SPEC','vacuum_lineage_laws_v1','vacuum_axes','SFT-PHYS-VACUUM-POLARIZATION-RUNNING-003')]
for stem,spec,source,axes,cid in entries:
 text=Path('work/'+source+'497.py').read_text();tree=ast.parse(text)
 call=next(n.value for n in tree.body if isinstance(n,ast.Assign) and getattr(n.targets[0],'id','')==spec)
 kw={k.arg:k.value for k in call.keywords};fn=next(n for n in tree.body if isinstance(n,ast.FunctionDef) and n.name==axes)
 values=dict(zip([a.arg for a in fn.args.args],kw['axes'].args))
 class Replace(ast.NodeTransformer):
  def visit_Name(self,n):return copy.deepcopy(values.get(n.id,n))
 expanded=Replace().visit(copy.deepcopy(next(n.value for n in fn.body if isinstance(n,ast.Return))))
 for k in call.keywords:
  if k.arg=='axes':k.value=expanded
 Path('work/'+stem+'497_expanded.py').write_text(ast.unparse(tree))
 template=Path('work/prepare_colour496.py').read_text().replace('ColourCouplingDerivation',stem).replace('ColourCoupling',stem).replace('COLOUR_COUPLING_SPEC',spec).replace('SFT-PHYS-NUCLEAR-COLOUR-COUPLING-001',cid).replace("src=subprocess.check_output(['git','-C','/Volumes/One Touch/ernos-labs-sft-platform','show',pin+':sft/physics/atomic_constants.py'],text=True)","src=Path('work/"+stem+"497_expanded.py').read_text()")
 template=template.replace("ast.parse(Path('work/structural_constants496.py').read_text()),tree","ast.parse(Path('work/structural_constants496.py').read_text()),ast.parse(Path('work/atomic_constants496.py').read_text()),tree").replace("if isinstance(n,(ast.Tuple,ast.List)):","if isinstance(n,ast.BinOp) and isinstance(n.op,ast.Add):return literal(n.left)+literal(n.right)\n if isinstance(n,(ast.Tuple,ast.List)):")
 template=template.replace("template=template.replace('namespace","template=template.replace('i==6','i==7').replace('⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩','⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩').replace('⟨h0,h1,h2,h3,h4,h5,h6⟩','⟨h0,h1,h2,h3,h4,h5,h6,h7⟩').replace('cases h5; cases h6','cases h5; cases h6; cases h7');template=template.replace('namespace")
 template=template.replace("'= 128'","'= 256'").replace("work/colour_witness496.txt","work/"+stem+"_witness497.txt")
 Path('work/prepare_'+stem+'497.py').write_text(template)
 if stem=='StrongRunning':
  checks=['colourPrefix 4 == [1,3,5,7]','(List.zip (colourPrefix 7) ((colourPrefix 7).drop 1)).all (fun p => p.2 - p.1 == 2)','neutralPrefix 7 == [1,1,1,1,1,1,1]']
 else:
  checks=['match support with | .error _ => false | .ok p => p.1.numerator == 1 && p.1.denominator == 2','match support with | .error _ => false | .ok p => p.2.numerator == 1 && p.2.denominator == 1','match support with | .error _ => false | .ok p => p.1.numerator * p.2.denominator < p.2.numerator * p.1.denominator']
 names=['exactCheck','reducedCheck','independentCheck']
 s='import SFT.Physics.'+stem+'\nnamespace SFT.Physics.'+stem+'Witnesses\nopen '+stem+'\nstructure Witness where\n name : String\n statement : String\n passed : Bool\n'
 for n,c in zip(names,checks):s+='def '+n+' : Bool := '+c+'\ntheorem '+n+'Passed : '+n+' = true := rfl\n'
 s+='def witnesses : List Witness := [WITNESS_ROWS]\ntheorem allWitnessesPass : witnesses.all Witness.passed = true := rfl\nend SFT.Physics.'+stem+'Witnesses\n'
 Path('work/'+stem+'_witness497.txt').write_text(s)
 exec(compile(template,'generator','exec'),{})
Path('work/running497_entries.json').write_text(json.dumps(entries,indent=2))
