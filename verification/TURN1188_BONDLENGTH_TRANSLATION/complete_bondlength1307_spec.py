from pathlib import Path
import json
w=Path('work');r=w/'turn1064_recovery';spec=json.loads((w/'bondlength1307_spec.json').read_text());q=lambda s:json.dumps(s,ensure_ascii=False)
p=r/'SFT/Chemistry/EquilibriumBondLengthExperiment.lean';s=p.read_text();end='end SFT.Chemistry.EquilibriumBondLengthExperiment\n';assert s.endswith(end)
s=s[:-len(end)]+'def expectedLabel : String := '+q(spec['expected_observation_label'])+'\n'
s+='def dimensions : List (String × List (String × Bool)) := ['+','.join('('+q(d['key'])+',['+','.join('('+q(c['name'])+','+str(c['admitted']).lower()+')'for c in d['choices'])+'])'for d in spec['dimensions'])+']\n'
s+='def snapshotHashes : List String := ['+','.join(q(x['snapshot_hash'])for x in spec['target_rows'])+']\n'
t=(r/'SFT/Chemistry/ConfigurationOrderExperiment.lean').read_text();a=t.index('def distinct');b=t.index('#print',a);t=t[a:b].replace('ConfigurationOrder','EquilibriumBondLength').replace('(NuclideCarrierSurface.trimLine (Text.chars expectedLabel)).isEmpty || (NuclideCarrierSurface.trimLine (Text.chars falsification)).isEmpty','!CapabilityValues.nonblank expectedLabel || !CapabilityValues.nonblank falsification').replace('[EquilibriumBondLength.basinWitness,EquilibriumBondLength.barrierWitness,EquilibriumBondLength.pathWitness,EquilibriumBondLength.invalidWitness]','[EquilibriumBondLength.commonBaseWitness.toOption.getD false,EquilibriumBondLength.typedCorrectionsWitness.toOption.getD false,EquilibriumBondLength.positiveOrderWitness.toOption.getD false]')
s+=t+'theorem registeredSpecValid : validateSpec = .ok () := rfl\n'+end;s=s.replace('import SFT.Host.Canonical','import SFT.Host.Canonical\nimport SFT.Physics.CapabilityValues').replace('open SFT.Host SFT.Host.Canonical','open SFT.Host SFT.Host.Canonical SFT.Physics');p.write_text(s)
print('Exact original EmpiricalChemistrySpec guards and registered validity proof staged.')
