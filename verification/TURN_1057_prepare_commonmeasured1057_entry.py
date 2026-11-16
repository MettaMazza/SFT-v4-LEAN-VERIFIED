from pathlib import Path
w=Path('work');s=(w/'prepare_spinobservation1049_entry.py').read_text().replace('from sft.physics.spin_statistics_condensation_empirical_v1 import SPEC','from sft.physics.common_scale_measured_value_successor_v1 import SPEC').replace('SpinCondensation','CommonMeasured').replace('spinobservation1049','commonmeasured1057')
a=s.index("s='import SFT.Physics.SpinStatisticsCertificateProof");b=s.index("(r/f'{tag}Witnesses.lean').write_text(s)",a)
s=s[:a]+'''s='import SFT.Physics.CommonMeasuredAnalysis\\nnamespace SFT.Physics.CommonMeasuredWitnesses\\nopen CommonMeasuredAnalysis\\nset_option maxRecDepth 20000\\nset_option maxHeartbeats 100000000\\nstructure Witness where\\n name : String\\n statement : String\\n passed : Bool\\n'
s+='def formalShare : Bool := match supportEightWitness with | .error _ => false | .ok b => b\\n'
s+='def formalTerminal : Bool := match CommonScaleAxis.terminalElectroweakChain with | .error _ => false | .ok q => (LeptonIntervals.normalize 1 5 (by decide)).blt q.terminalShare && q.terminalShare.blt (LeptonIntervals.normalize 1 4 (by decide))\\n'
s+='def witnesses : List Witness := ['+','.join('⟨'+q(row[0])+','+q(row[1])+','+check+'⟩' for row,check in zip(witnesses,['formalShare','formalTerminal']))+']\\n'
s+='theorem formalSharePassed : formalShare=true := rfl\\ntheorem formalTerminalPassed : formalTerminal=true := rfl\\ntheorem allWitnessesPass : witnesses.all Witness.passed=true := rfl\\nend SFT.Physics.CommonMeasuredWitnesses\\n'
'''+s[b:]
exec(compile(s,'original053entry','exec'))
