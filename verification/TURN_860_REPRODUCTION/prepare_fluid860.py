from pathlib import Path
s=Path('work/bounded_spec859.py').read_text().replace('bounded859','fluid860').replace('BOUNDED_N_BODY','FLOORED_FLUID');Path('work/fluid_spec860.py').write_text(s)
s=Path('work/prepare_bounded_grammar859.py').read_text().replace('BOUNDED_N_BODY','FLOORED_FLUID').replace('BoundedNBody','FlooredFluid').replace('BoundedFoldTransient','FlooredFluid').replace('memMap _ addition _ haddition','memMap _ scope _ hscope');Path('work/prepare_fluid_grammar860.py').write_text(s)
s=Path('work/prepare_bounded_evidence859.py').read_text().replace('bounded_spec859','fluid_spec860').replace('BoundedNBody','FlooredFluid').replace('BoundedFoldTransient','FlooredFluid').replace('state_domain :=','lattice :=')
a=s.index('def witness0');b=s.index('theorem witness0Passed',a)
s=s[:a]+'''def witness0 : Bool := (FlooredFluid.gradient (FlooredFluid.minimumEdge 5 0 1)).numerator == 32 && (FlooredFluid.gradient (FlooredFluid.minimumEdge 5 0 1)).denominator == 1
def witness1 : Bool := (List.range 14).all (fun n => let g := FlooredFluid.gradient (FlooredFluid.minimumEdge (n+1) 0 1); g.numerator == 2^(n+1) && g.denominator == 1)
def witness2 : Bool := (75+75 : Nat) == 150
'''+s[b:];Path('work/prepare_fluid_evidence860.py').write_text(s)
