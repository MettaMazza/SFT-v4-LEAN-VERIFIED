from pathlib import Path
import json,re
r=Path('work/constants-recovery/SFT/Chemistry');old=json.load(open('work/polarity598_spec.json'));new=json.load(open('work/mass_spectral640_spec.json'));q=lambda x:json.dumps(x,ensure_ascii=False)
s=(r/'PolarityExperiment.lean').read_text().replace('Polarity','MassSpectral')
for k in ['claim_id','experiment_id','expected_observation_label','exact_result','falsification_condition','observation_registry_path']:s=s.replace(q(old[k]),q(new[k]))
for a,b in zip(old['target_rows'],new['target_rows']):
 for k in a:s=s.replace(q(a[k]),q(b[k]))
a=s.index('def specDimensions');b=s.index('\ndef validateSpec',a);s=s[:a]+'def specDimensions : List (String × List Bool) := ['+','.join('('+q(x['key'])+',['+','.join(str(c['admitted']).lower() for c in x['choices'])+'])' for x in new['dimensions'])+']\ndef specWitnesses : List Bool := ['+','.join(str(x[2]).lower() for x in new['operational_witnesses'])+']\n'+s[b:];(r/'MassSpectralExperiment.lean').write_text(s)
(r/'MassSpectralValidation.lean').write_text((r/'PolarityValidation.lean').read_text().replace('Polarity','MassSpectral'))
