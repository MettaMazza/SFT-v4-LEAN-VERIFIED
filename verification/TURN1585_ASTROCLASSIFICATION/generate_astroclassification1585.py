from pathlib import Path
import json
w=Path('work');out=w/'turn1064_recovery/SFT/AstronomyCosmology';out.mkdir(parents=True,exist_ok=True)
s='''from pathlib import Path
import sys,json,dataclasses,ast
sys.path.insert(0,str(Path('work/v3-runtime500').resolve()))
from sft.astronomy_cosmology.empirical_program import ASTRONOMY_SPECS
spec=next(x for x in ASTRONOMY_SPECS if x.claim_id=='SFT-ASTRO-CLASSIFICATION-001')
spec.validate();values=dataclasses.asdict(spec.blueprint);values['dimensions']=[dataclasses.asdict(d)for d in spec.dimensions]
q=lambda x:json.dumps(x,ensure_ascii=False)
dims=[[d.key,'',d.choices[0].name,d.choices[0].reason,d.choices[1].name,d.choices[1].reason]for d in spec.dimensions]
kw={k:ast.parse(repr(v),mode='eval').body for k,v in values.items()}
Path('work/astroclassification1585_spec.json').write_text(json.dumps(values,indent=2))
cid=spec.claim_id
''';(w/'astroclassification_spec1585.py').write_text(s);ns={};exec(s,ns);spec=ns['spec'];q=ns['q']
from sft.astronomy_cosmology.obligations import ASTRONOMY_OBLIGATIONS
row=next(x for x in ASTRONOMY_OBLIGATIONS if x.claim_id==spec.claim_id);fields=['claim_id','title','family','carrier','relation','retained_record','evidence_boundary','statement','falsification_condition']
core='import SFT.AstronomyCosmology.StructuralModel\nnamespace SFT.AstronomyCosmology.AstronomicalClassification\nstructure Obligation where\n'+''.join(' '+f+' : String\n'for f in fields)
core+='def original : Obligation := ⟨'+','.join(q(getattr(row,f))for f in fields)+'⟩\n'
core+='''def carrierWitness : Bool := !original.carrier.isEmpty
def relationWitness : Bool := !(SFT.Host.Text.equal original.carrier original.relation)
def boundaryWitness : Bool := !(SFT.Host.Text.equal original.evidence_boundary original.carrier)
def exactFoldWitness : Bool :=
 match StructuralModel.structuralWitnesses.find? (fun row => SFT.Host.Text.equal row.1 "evidence_classes_distinct") with
 | none => false
 | some row => row.2
theorem carrierWitnessPassed : carrierWitness = true := rfl
theorem relationWitnessPassed : relationWitness = true := rfl
theorem boundaryWitnessPassed : boundaryWitness = true := rfl
theorem exactFoldWitnessPassed : exactFoldWitness = true := by rfl
end SFT.AstronomyCosmology.AstronomicalClassification
'''
assert not(out/'AstronomicalClassification.lean').exists();(out/'AstronomicalClassification.lean').write_text(core)
for kind in ['grammar','evidence']:
 s=(w/f'statesymmetry_{kind}1100.py').read_text().replace('statesymmetry','astroclassification').replace('StateSymmetry','AstronomicalClassification').replace('1100','1585');(w/f'astroclassification_{kind}1585.py').write_text(s);exec(s,{})
s=(w/'AstronomicalClassificationGrammar1585.lean').read_text().replace('import «work».AstronomicalClassificationCarrier1585','import SFT.Foundation.CommonRefinement').replace('SFT.Physics.AstronomicalClassificationGrammar','SFT.AstronomyCosmology.AstronomicalClassificationGrammar');(out/'AstronomicalClassificationGrammar.lean').write_text(s)
s=(w/'AstronomicalClassificationEvidence1585.lean').read_text().replace('import «work».AstronomicalClassificationGrammar1585','import SFT.AstronomyCosmology.AstronomicalClassificationGrammar\nimport SFT.AstronomyCosmology.AstronomicalClassification').replace('SFT.Physics.AstronomicalClassificationEvidence','SFT.AstronomyCosmology.AstronomicalClassificationEvidence').replace('branch := "physics"','branch := "astronomy_cosmology"').replace('provenance := [.observationalDerivation]','provenance := [.forwardForcing]')
a=s.index('def onePairWitness');b=s.index('def claimId',a);s=s[:a]+'def witnesses : Value := .array ['+','.join('.array [.text '+q(n)+',.text '+q(e)+',.boolean AstronomicalClassification.'+v+']'for(n,e,_),v in zip(spec.operational_witnesses,['carrierWitness','relationWitness','boundaryWitness','exactFoldWitness']))+']\n'+s[b:];(out/'AstronomicalClassificationEvidence.lean').write_text(s)
s=(w/'factor_conjugated1078_grammar.py').read_text().replace('ConjugatedSupport','AstronomicalClassification').replace('SFT/Chemistry','SFT/AstronomyCosmology').replace('SFT.Chemistry','SFT.AstronomyCosmology').replace("['carrier','connectivity','fibres','alternation','coverage','propagation','observation','extension']",repr([d.key for d in spec.dimensions]));exec(s,{})
print('Staged AstronomicalClassification original obligation,fourwitnesses and256candidate grammar/programme')
