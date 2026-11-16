from pathlib import Path
w=Path('work');s=(w/'prepare_spinobservation1049_entry.py').read_text().replace('from sft.physics.spin_statistics_condensation_empirical_v1 import SPEC','from sft.physics.electroweak_measured_value_successor_v1 import SPEC').replace('SpinCondensation','ElectroweakMeasured').replace('spinobservation1049','electroweak1056')
a=s.index("s='import SFT.Physics.SpinStatisticsCertificateProof");b=s.index("(r/f'{tag}Witnesses.lean').write_text(s)",a)
s=s[:a]+'''s='import SFT.Physics.ElectroweakMeasuredAnalysis\\nnamespace SFT.Physics.ElectroweakMeasuredWitnesses\\nopen ElectroweakMeasuredAnalysis\\nset_option maxRecDepth 20000\\nset_option maxHeartbeats 100000000\\nstructure Witness where\\n name : String\\n statement : String\\n passed : Bool\\n'
s+='def formalShare : Bool := match exactTerminalWitness with | .error _ => false | .ok b => b\\n'
s+='def formalComplement : Bool := match ElectroweakTerminalRatio.completeShare with | .error _ => false | .ok q => q.numerator == q.denominator\\n'
s+='def witnesses : List Witness := ['+','.join('⟨'+q(row[0])+','+q(row[1])+','+check+'⟩' for row,check in zip(witnesses,['formalShare','formalComplement']))+']\\n'
s+='theorem formalSharePassed : formalShare=true := rfl\\ntheorem formalComplementPassed : formalComplement=true := rfl\\ntheorem allWitnessesPass : witnesses.all Witness.passed=true := rfl\\nend SFT.Physics.ElectroweakMeasuredWitnesses\\n'
'''+s[b:]
s=s.replace('targetRows.length = 3','targetRows.length = 2').replace('[expectedLabel,expectedLabel,expectedLabel]','[expectedLabel,expectedLabel]')
exec(compile(s,'original053entry','exec'))
