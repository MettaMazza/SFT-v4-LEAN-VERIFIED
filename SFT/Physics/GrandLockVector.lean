import SFT.Physics.UnifiedConstantsTerminal
import SFT.Physics.UnifiedConstantsCertificate
namespace SFT.Physics.GrandLockVector
open UnifiedConstantsFoundation UnifiedConstantsHelpers LeptonIntervals
open SFT.Host.Canonical
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def leastBinaryCover (carrier binary : CountInput) : Except String Nat :=
 (minimalBinaryCover carrier binary).mapError (fun _=>"cover requires positive carrier and generated fibre count")
def positiveTake (whole part : Rat) : Except String Rat :=
 if part.blt whole && zero.blt part then .ok (subtract whole part)
 else .error "positive take requires an ordered positive part"
def power (a : Rat) : Nat → Rat
 | 0=>normalize 1 1 (by decide)
 | n+1=>multiply (power a n) a
-- Source reversed(rungs[1:-1]); the last rung is the initial continuation.
def continuation (rungs : List Nat) (chain : Rat) : Except String Rat := do
 match rungs with
 | []=>pure chain
 | rung::rest=>
  let reciprocal ← LeptonRatios.divide (normalize 1 1 (by decide)) chain
  continuation rest (add (normalize (.ofNat rung) 1 (by decide)) reciprocal)
def generatorValueVector : CountInput → Except String Fields
 | .boolean _=>.error "the perturbation census requires generator or successor"
 | .integer (.negSucc _) =>.error "the perturbation census requires generator or successor"
 | .integer (.ofNat g)=>do
  if g<3 then throw "the perturbation census requires generator or successor"
  let one := normalize 1 1 (by decide)
  let down ← leastBinaryCover (count (g^3)) (count 2)
  let up ← leastBinaryCover (count (g^4)) (count 2)
  let tower := 2^up
  let boundary := g^2
  let cover := 2*(down^g)
  let rungs := (List.range (g+1)).map (fun p=>down^(g-p)*up^p)
  let last ← match rungs.reverse with | []=>.error "IndexError" | n::_=>fraction n 1
  let chain ← continuation ((rungs.drop 1).take (g-1)).reverse last
  let reciprocal ← LeptonRatios.divide one chain
  let effective := add (normalize (.ofNat cover) 1 (by decide)) reciprocal
  let numerator := multiply (normalize (.ofNat boundary) 1 (by decide)) (add effective one)
  let alphaPart ← LeptonRatios.divide numerator effective
  let inverseAlpha := add (normalize (.ofNat tower) 1 (by decide)) alphaPart
  let alpha ← LeptonRatios.divide one inverseAlpha
  let denominator := 2*g^(g+2)-1
  let part ← fraction 1 g
  let sharpenedDenominator ← positiveTake (normalize (.ofNat denominator) 1 (by decide)) part
  let sharpened ← LeptonRatios.divide one sharpenedDenominator
  let upShare ← fraction up g
  let correctionNumerator := multiply (power alpha g) (add (normalize (.ofNat down) 1 (by decide)) (multiply upShare alpha))
  let correction ← LeptonRatios.divide correctionNumerator (normalize (.ofNat (g^g)) 1 (by decide))
  let terminal ← positiveTake sharpened correction
  let volume := g^3
  let support := 2^down
  let orbitTerm ← fraction 1 (support-1)
  let darkRefined ← LeptonRatios.divide (normalize (.ofNat volume) 1 (by decide)) (add (normalize (.ofNat down) 1 (by decide)) orbitTerm)
  let vacuum ← fraction (g-1) g
  let spatial ← fraction 8 1
  let hubblePart ← LeptonRatios.divide vacuum spatial
  let deepTerm ← fraction 1 (tower-1)
  let hubbleRefinedPart ← LeptonRatios.divide (add vacuum deepTerm) spatial
  let factor ← fraction 2 g
  let planckFactor ← positiveTake one (multiply factor alpha)
  let planck := multiply (normalize (.ofNat (2^(tower-1))) 1 (by decide)) planckFactor
  let amplitude ← fraction 1 (2^(2*down))
  pure [("generator",.count g),("down_cover_depth",.count down),("up_cover_depth",.count up),
   ("inverse_fine_structure_terminal",.fraction inverseAlpha),
   ("charged_lepton_pair_invariant",.fraction (← fraction 1 (2*g))),
   ("charged_lepton_leading_product",.fraction (← fraction 1 denominator)),
   ("charged_lepton_sharpened_product",.fraction sharpened),("charged_lepton_terminal_product",.fraction terminal),
   ("quark_down_pair_invariant",.fraction (← fraction 1 (2*(g+1)))),
   ("quark_up_pair_invariant",.fraction (← fraction 1 (2*(g+g)))),
   ("quark_down_product_invariant",.fraction (← fraction 1 (g*2^up-1))),
   ("quark_up_product_invariant",.fraction (← fraction 1 (g*2^(up+g)-1))),
   ("dark_baryon_leading_ratio",.fraction (← fraction volume down)),("dark_baryon_refined_ratio",.fraction darkRefined),
   ("dark_share",.fraction (← fraction volume support)),("baryon_share",.fraction (← fraction down support)),
   ("hubble_leading_ratio",.fraction (add one hubblePart)),("hubble_refined_ratio",.fraction (add one hubbleRefinedPart)),
   ("planck_proton_terminal_squared_hierarchy",.fraction planck),
   ("local_vacuum_amplitude_floor",.fraction amplitude),("local_vacuum_energy_floor",.fraction (multiply amplitude amplitude))]
#print axioms leastBinaryCover
#print axioms positiveTake
#print axioms power
#print axioms continuation
#print axioms generatorValueVector
end SFT.Physics.GrandLockVector
