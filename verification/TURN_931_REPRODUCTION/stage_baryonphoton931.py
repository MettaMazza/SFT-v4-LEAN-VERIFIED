from pathlib import Path
import subprocess,json
w=Path('work');r=w/'constants-recovery';c=Path('/Volumes/One Touch/SFT v4 Full model LEAN');v=w/'v3-runtime500';repo='/Volumes/One Touch/ernos-labs-sft-platform';pin='76f1b34e9e9682989adcbb088797b4ae4ce4fcf1'
for path in ['sft/physics/matter_flavour_completion_laws_v1.py','sft/physics/matter_flavour_completion_execution_v1.py','generated/physics/matter_flavour_completion_validator_v1.py']:
 data=subprocess.check_output(['git','-C',repo,'show',pin+':'+path]);p=v/path
 if p.exists():assert p.read_bytes()==data
 else:p.parent.mkdir(parents=True,exist_ok=True);p.write_bytes(data)
s='''import SFT.Physics.MatterIdentityGraphs
import SFT.Physics.CPPhase
namespace SFT.Physics.BaryonPhotonTransport
open LeptonIntervals VacuumLedgerProofs
structure Relation where
 cpMeasure : String
 imbalanceShare : Rat
 etaRelation : String
 rootPolicy : String

def baryonPhotonRelation : Except String Relation := do
 let binary ← AlphaCovers.binaryCount
 let share ← LeptonRatios.divide (wholeRatio 1) (wholeRatio binary)
 pure ⟨"jarlskog-square-from-sealed-quark-root-mixing-graph",share,
  "jarlskog-square-times-half-One","exact-polynomials-and-rational-enclosures-only"⟩

def originalRelation : Relation :=
 ⟨"jarlskog-square-from-sealed-quark-root-mixing-graph",normalize 1 2 (by decide),
  "jarlskog-square-times-half-One","exact-polynomials-and-rational-enclosures-only"⟩
theorem completeSourceRelation : baryonPhotonRelation = .ok originalRelation := rfl
theorem exactImbalanceShare : (baryonPhotonRelation.map Relation.imbalanceShare) = .ok (normalize 1 2 (by decide)) := rfl
theorem twoFoldSharesClose : add originalRelation.imbalanceShare originalRelation.imbalanceShare = wholeRatio 1 := rfl
end SFT.Physics.BaryonPhotonTransport
'''
for root in [r,c]:(root/'SFT/Physics/BaryonPhotonTransport.lean').write_text(s)
print('Pinned original completion source/binding/validator and staged exact four-field transport relation')
