from pathlib import Path
spec='''from pathlib import Path
import sys,json,dataclasses,ast
runtime=Path('work/v3-runtime500');sys.path.insert(0,str(runtime.resolve()))
import sft.materials
sft.materials.__path__.insert(0,str(Path('work/pinned_bulkwater1499/sft/materials').resolve()))
from sft.materials.successor_derivation import MATERIALS_SUCCESSOR_BLUEPRINTS
spec=next(x for x in MATERIALS_SUCCESSOR_BLUEPRINTS if x.claim_id=='SFT-MAT-BULK-WATER-RESPONSE-002');spec.validate();values=dataclasses.asdict(spec);q=lambda x:json.dumps(x,ensure_ascii=False)
dims=[[d.key,'',d.choices[0].name,d.choices[0].reason,d.choices[1].name,d.choices[1].reason]for d in spec.dimensions]
kw={k:ast.parse(repr(v),mode='eval').body for k,v in values.items()}
Path('work/bulkwater1499_spec.json').write_text(json.dumps(values,indent=2))
cid=spec.claim_id
''';Path('work/bulkwater_spec1499.py').write_text(spec)
for kind in ['grammar','evidence']:
 s=Path('work/resonance_'+kind+'1088.py').read_text().replace('resonance','bulkwater').replace('ResonanceEquivalent','BulkWater').replace('1088','1499');Path('work/bulkwater_'+kind+'1499.py').write_text(s)
exec(Path('work/bulkwater_grammar1499.py').read_text());exec(Path('work/bulkwater_evidence1499.py').read_text())
r=Path('work/turn1064_recovery/SFT/Materials')
s=Path('work/BulkWaterGrammar1499.lean').read_text().replace('import «work».BulkWaterCarrier1499','import SFT.Foundation.CommonRefinement').replace('SFT.Physics.BulkWaterGrammar','SFT.Materials.BulkWaterGrammar').replace('namespace SFT.Materials.BulkWaterGrammar','namespace SFT.Materials.BulkWaterGrammar\nset_option maxHeartbeats 20000000');(r/'BulkWaterGrammar.lean').write_text(s)
s=Path('work/BulkWaterEvidence1499.lean').read_text().replace('import «work».BulkWaterGrammar1499','import SFT.Materials.BulkWaterGrammar\nimport SFT.Materials.BulkWater').replace('SFT.Physics.BulkWaterEvidence','SFT.Materials.BulkWaterEvidence').replace('branch := "physics"','branch := "materials"')
a=s.index('def onePairWitness');b=s.index('def claimId',a);n,e,v=spec.operational_witnesses[0];s=s[:a]+'def witnesses : Value := .array [.array [.text '+q(n)+',.text '+q(e)+',.boolean true]]\n'+s[b:];(r/'BulkWaterEvidence.lean').write_text(s)
s=Path('work/factor_conjugated1078_grammar.py').read_text().replace('SFT/Chemistry/ConjugatedSupport','SFT/Materials/BulkWater').replace("['carrier','connectivity','fibres','alternation','coverage','propagation','observation','extension']","['carrier','relation','organization','observation','record','provenance','generality','extension']");exec(s)
s=Path('work/build_resonance1088.py').read_text().replace('ResonanceEquivalent','BulkWater').replace('resonance1088','bulkwater1499').replace('SFT/Chemistry','SFT/Materials').replace('SFT.Chemistry','SFT.Materials').replace('ResonanceAudit1088','PhononAudit1499');Path('work/build_bulkwater1499.py').write_text(s)
print('Generated original eight-axis grammar, all256 candidates and actual mode-support witness.')

p=Path("work/turn1064_recovery/SFT/Materials/BulkWaterEvidence.lean");p.write_text(p.read_text().replace(".boolean true]]", ".boolean BulkWater.witness]]"))
