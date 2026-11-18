from pathlib import Path
import json
w=Path('work');r=w/'turn1064_recovery/SFT/Chemistry';p=r/'EquilibriumBondLength.lean';s=p.read_text();marker='end SFT.Chemistry.EquilibriumBondLength\n';assert s.endswith(marker)
s=s[:-len(marker)]+'''def commonBaseWitness : Except String Bool := do
 let base ← LeptonRatios.divide (wholeRatio (← MolecularSpectroscopy.upSupport))
   (wholeRatio (← MolecularSpectroscopy.downSupport))
 pure (base.num == 7 && base.den == 5)
def typedCorrectionsWitness : Except String Bool := do
 let h := (← FoldFirstReturn.generatorPeriod) * (← MolecularSpectroscopy.upSupport)
 let d := (← MolecularSpectroscopy.terminalSupport) + (← MolecularSpectroscopy.upSupport) + 1
 pure (h == 21 && d == 24)
def positiveOrderWitness : Except String Bool := do
 let h ← equilibriumLengthMultiplier "H2"
 let d ← equilibriumLengthMultiplier "D2"
 pure (@decide (Int.lt (h.num * Int.ofNat d.den) (d.num * Int.ofNat h.den)) (Int.decLt _ _) &&
   @decide (Int.lt (Int.ofNat h.den) h.num) (Int.decLt _ _))
theorem commonBasePassed : commonBaseWitness = .ok true := rfl
theorem typedCorrectionsPassed : typedCorrectionsWitness = .ok true := rfl
theorem positiveOrderPassed : positiveOrderWitness = .ok true := rfl
'''+marker;p.write_text(s)
s=(w/'statesymmetry_spec1100.py').read_text().replace('from sft.chemistry.state_symmetry_batch_v1 import STATE_SYMMETRY_SPEC', '''import sft.chemistry
sft.chemistry.__path__=[str(Path('work/pinned1307/sft/chemistry').resolve())]+list(sft.chemistry.__path__)
from sft.chemistry.equilibrium_bond_length_batch_v1 import EQUILIBRIUM_BOND_LENGTH_SPEC as STATE_SYMMETRY_SPEC''').replace('statesymmetry1100','bondlength1307');(w/'bondlength_spec1307.py').write_text(s);ns={};exec(s,ns);spec=ns['spec'];q=ns['q']
for kind in ['grammar','evidence']:
 s=(w/('statesymmetry_'+kind+'1100.py')).read_text().replace('statesymmetry','bondlength').replace('StateSymmetry','EquilibriumBondLength').replace('1100','1307');(w/('bondlength_'+kind+'1307.py')).write_text(s);exec(s,{})
s=(w/'EquilibriumBondLengthGrammar1307.lean').read_text().replace('import «work».EquilibriumBondLengthCarrier1307','import SFT.Foundation.CommonRefinement').replace('SFT.Physics.EquilibriumBondLengthGrammar','SFT.Chemistry.EquilibriumBondLengthGrammar');s=s.replace('namespace SFT.Chemistry.EquilibriumBondLengthGrammar','namespace SFT.Chemistry.EquilibriumBondLengthGrammar\nset_option maxHeartbeats 100000000');(r/'EquilibriumBondLengthGrammar.lean').write_text(s)
s=(w/'EquilibriumBondLengthEvidence1307.lean').read_text().replace('import «work».EquilibriumBondLengthGrammar1307','import SFT.Chemistry.EquilibriumBondLengthGrammar\nimport SFT.Chemistry.EquilibriumBondLength').replace('SFT.Physics.EquilibriumBondLengthEvidence','SFT.Chemistry.EquilibriumBondLengthEvidence');a=s.index('def onePairWitness');b=s.index('def claimId',a)
names=['commonBaseWitness','typedCorrectionsWitness','positiveOrderWitness'];s=s[:a]+'def witnesses : Value := .array ['+','.join('.array [.text '+q(n)+',.text '+q(e)+',.boolean (EquilibriumBondLength.'+v+'.toOption.getD false)]'for(n,e,_),v in zip(spec.operational_witnesses,names))+']\n'+s[b:]
s=s.replace('branch := "physics"','branch := "chemistry"');s=s.replace('scope := .depthIndependent','scope := .finiteComplete').replace('generalityCertificateHash := some (identity closureValue)','generalityCertificateHash := none');s=s.replace('def closureValue : Value := .object [("claim_id",.text claimId),','def closureValue : Value := .object [("claim_id",.text claimId),("boundary",.text grammarBoundary),');s=s.replace('survivor with carrier :=','survivor with identity :=');(r/'EquilibriumBondLengthEvidence.lean').write_text(s)
s=(w/'factor_conjugated1078_grammar.py').read_text().replace('ConjugatedSupport','EquilibriumBondLength').replace("['carrier','connectivity','fibres','alternation','coverage','propagation','observation','extension']",repr([d.key for d in spec.dimensions]));exec(s,{})
p=w/'turn1064_recovery/EquilibriumBondLengthProgram1307.lean';p.write_text((w/'turn1064_recovery/MolecularMeasurementProgram1235.lean').read_text().replace('MolecularMeasurement','EquilibriumBondLength'))
s=(w/'check_quantum1235_program.py').read_text().replace('1235','1307').replace('quantum','bondlength').replace('MolecularMeasurement','EquilibriumBondLength').replace('molecular_measurement_batch_v1','equilibrium_bond_length_batch_v1').replace('MOLECULAR_MEASUREMENT_SPEC','EQUILIBRIUM_BOND_LENGTH_SPEC').replace('from sft.chemistry.generated_observational_law import GeneratedObservationalChemistryProgram','from sft.chemistry.equilibrium_bond_length_batch_v1 import GeneratedFiniteQuantitativeChemistryProgram as GeneratedObservationalChemistryProgram');a=s.index('fixed=');b=s.index('\nmanifest=',a);s=s[:a]+'fixed='+repr(tuple(json.loads((w/'bondlength1307_source_pin.json').read_text())['execution_files']))+s[b:];(w/'check_bondlength1307_program.py').write_text(s)
print('Original three witnesses,all256grammar forms,finite closure,controls and full-programme comparison translated; not compiled yet.')
