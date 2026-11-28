from pathlib import Path
import json
w=Path('work');out=w/'turn1064_recovery/SFT/AstronomyCosmology';out.mkdir(parents=True,exist_ok=True)
s='''from pathlib import Path
import sys,json,dataclasses,ast
sys.path.insert(0,str(Path('work/v3-runtime500').resolve()))
from sft.astronomy_cosmology.empirical_program import ASTRONOMY_SPECS
spec=next(x for x in ASTRONOMY_SPECS if x.claim_id=='SFT-ASTRO-CATALOG-001')
spec.validate();values=dataclasses.asdict(spec.blueprint);values['dimensions']=[dataclasses.asdict(d)for d in spec.dimensions]
q=lambda x:json.dumps(x,ensure_ascii=False)
dims=[[d.key,'',d.choices[0].name,d.choices[0].reason,d.choices[1].name,d.choices[1].reason]for d in spec.dimensions]
kw={k:ast.parse(repr(v),mode='eval').body for k,v in values.items()}
Path('work/astrocatalog1589_spec.json').write_text(json.dumps(values,indent=2))
cid=spec.claim_id
''';(w/'astrocatalog_spec1589.py').write_text(s);ns={};exec(s,ns);spec=ns['spec'];q=ns['q']
from sft.astronomy_cosmology.obligations import ASTRONOMY_OBLIGATIONS
row=next(x for x in ASTRONOMY_OBLIGATIONS if x.claim_id==spec.claim_id);fields=['claim_id','title','family','carrier','relation','retained_record','evidence_boundary','statement','falsification_condition']
core='import SFT.AstronomyCosmology.StructuralModel\nnamespace SFT.AstronomyCosmology.AstronomicalCatalog\nstructure Obligation where\n'+''.join(' '+f+' : String\n'for f in fields)
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
end SFT.AstronomyCosmology.AstronomicalCatalog
'''
assert not(out/'AstronomicalCatalog.lean').exists();(out/'AstronomicalCatalog.lean').write_text(core)
for kind in ['grammar','evidence']:
 s=(w/f'statesymmetry_{kind}1100.py').read_text().replace('statesymmetry','astrocatalog').replace('StateSymmetry','AstronomicalCatalog').replace('1100','1589');(w/f'astrocatalog_{kind}1589.py').write_text(s);exec(s,{})
s=(w/'AstronomicalCatalogGrammar1589.lean').read_text().replace('import «work».AstronomicalCatalogCarrier1589','import SFT.Foundation.CommonRefinement').replace('SFT.Physics.AstronomicalCatalogGrammar','SFT.AstronomyCosmology.AstronomicalCatalogGrammar');(out/'AstronomicalCatalogGrammar.lean').write_text(s)
s=(w/'AstronomicalCatalogEvidence1589.lean').read_text().replace('import «work».AstronomicalCatalogGrammar1589','import SFT.AstronomyCosmology.AstronomicalCatalogGrammar\nimport SFT.AstronomyCosmology.AstronomicalCatalog').replace('SFT.Physics.AstronomicalCatalogEvidence','SFT.AstronomyCosmology.AstronomicalCatalogEvidence').replace('branch := "physics"','branch := "astronomy_cosmology"').replace('provenance := [.observationalDerivation]','provenance := [.forwardForcing]')
a=s.index('def onePairWitness');b=s.index('def claimId',a);s=s[:a]+'def witnesses : Value := .array ['+','.join('.array [.text '+q(n)+',.text '+q(e)+',.boolean AstronomicalCatalog.'+v+']'for(n,e,_),v in zip(spec.operational_witnesses,['carrierWitness','relationWitness','boundaryWitness','exactFoldWitness']))+']\n'+s[b:];(out/'AstronomicalCatalogEvidence.lean').write_text(s)
s=(w/'factor_conjugated1078_grammar.py').read_text().replace('ConjugatedSupport','AstronomicalCatalog').replace('SFT/Chemistry','SFT/AstronomyCosmology').replace('SFT.Chemistry','SFT.AstronomyCosmology').replace("['carrier','connectivity','fibres','alternation','coverage','propagation','observation','extension']",repr([d.key for d in spec.dimensions]));exec(s,{})
print('Staged AstronomicalCatalog original obligation,fourwitnesses and256candidate grammar/programme')
