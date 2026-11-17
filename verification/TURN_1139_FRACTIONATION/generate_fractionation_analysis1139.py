from pathlib import Path
import json
w=Path('work');r=w/'turn1064_recovery';old=(r/'SFT/Chemistry/IsotopeExchangeAnalysis.lean').read_text();spec=json.loads((w/'equilibriumfractionation1139_spec.json').read_text());q=lambda x:json.dumps(x,ensure_ascii=False)
s='''import SFT.Chemistry.RadiochemicalAnalysis
namespace SFT.Chemistry.EquilibriumIsotopeFractionationAnalysis
open SFT.Host SFT.Host.Canonical
open NuclideCarrierAnalysis hiding targetIds claimId authorities validateAuthorities verifySurfaces
'''
s+='def claimId : String := '+q(spec['claim_id'])+'\ndef targetIds : List String := ['+','.join(q(x['target_id'])for x in spec['target_rows'])+']\n'
s+='''def authorities := RadiochemicalAnalysis.authorities
def validateAuthorities := RadiochemicalAnalysis.validateAuthorities
def verifySurfaces := RadiochemicalAnalysis.verifySurfaces
def fractionationChecks (analysis row : Value) : Except String (List (String × Bool)) := do
 let definition ← field row "factor_definition" >>= text
 let table ← field row "complete_table_1_vector" >>= array
 let lastAlpha ← ConjugatedSupportAnalysis.valueAt table (table.length-1) >>= fun x => field x "alpha" >>= text
 let firstAlpha ← ConjugatedSupportAnalysis.valueAt table 0 >>= fun x => field x "alpha" >>= text
 let temperature ← field row "temperature_support" >>= array
 let temperatureText ← ConjugatedSupportAnalysis.valueAt temperature 1 >>= text
 let exchange ← field row "one_atom_exchange_correspondence" >>= text
 let alphas ← field row "complete_exchange_alpha_vector" >>= array
 let retained ← field row "all_fits_assumptions_estimated_curves_adverse_absent_unavailable_and_unresolved_rows_retained" >>= bool
 let adverse ← field row "adverse_record" >>= text
 let sourceCount ← field analysis "complete_source_count" >>= nat
 return [("SFT-CHEM-NUCHEM-007-ISOTOPE-RATIOS",(Text.chars "alpha_A-B").isPrefixOf (Text.chars definition)),
 ("SFT-CHEM-NUCHEM-007-PHASES",Text.contains definition "R_A/R_B"),
 ("SFT-CHEM-NUCHEM-007-FACTORS",table.length==12 && Text.equal lastAlpha "1.01980"),
 ("SFT-CHEM-NUCHEM-007-ORIENTATION",Text.equal firstAlpha "1.00000"),
 ("SFT-CHEM-NUCHEM-007-TEMPERATURE",temperature.length==2 && Text.contains temperatureText "figures 1 through 49"),
 ("SFT-CHEM-NUCHEM-007-EQUILIBRIUM",Text.equal exchange "for a one-atom exchange reaction K equals alpha" && alphas.length==4),
 ("SFT-CHEM-NUCHEM-007-ADVERSE-UNAVAILABLE",retained && Text.contains adverse "uncritically compiled"),
 ("SFT-CHEM-NUCHEM-007-COMPLETE-SOURCES",sourceCount==5)]
'''
part=old[old.index('def exactIsotopeAnalysis'):old.index('end SFT.Chemistry.IsotopeExchangeAnalysis')].replace('exactIsotopeAnalysis','exactFractionationAnalysis').replace('isotopeChecks','fractionationChecks').replace('nuchem_006','nuchem_007').replace('("exchange_alpha_rows",.integer 4),("isotope_ratio_rows",.integer 4),("example_conditions",.integer 5)','("comparison_table_rows",.integer 12),("exchange_alpha_rows",.integer 4),("registered_curve_figures",.integer 49)')
s+=part+'end SFT.Chemistry.EquilibriumIsotopeFractionationAnalysis\n';(r/'SFT/Chemistry/EquilibriumIsotopeFractionationAnalysis.lean').write_text(s)
s=(w/'generate_isotopeexchange1125_experiment.py').read_text().replace('ISOTOPE_EXCHANGE_SPEC','EQUILIBRIUM_FRACTIONATION_SPEC').replace('IsotopeExchange','EquilibriumIsotopeFractionation').replace('isotopeexchange1125','fractionation1139')
for a,b in [('carriersWitness','phasesWitness'),('conservationWitness','ratiosWitness'),('directionWitness','factorWitness'),('quotientWitness','orientationWitness'),('equilibriumWitness','coincidenceWitness'),('successorWitness','extensionWitness')]:s=s.replace(a,b)
(w/'generate_fractionation1139_experiment.py').write_text(s)
s=(r/'SFT/Chemistry/IsotopeExchangeValidation.lean').read_text().replace('IsotopeExchange','EquilibriumIsotopeFractionation').replace('exactIsotopeAnalysis','exactFractionationAnalysis');(r/'SFT/Chemistry/EquilibriumIsotopeFractionationValidation.lean').write_text(s)
for kind in ['analysis','validation']:
 s=(w/f'build_isotopeexchange1125_{kind}.py').read_text().replace('IsotopeExchange','EquilibriumIsotopeFractionation').replace('isotopeexchange1125','fractionation1139');(w/f'build_fractionation1139_{kind}.py').write_text(s)
