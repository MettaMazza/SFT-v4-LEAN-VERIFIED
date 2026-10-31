import SFT.Physics.AlphaRatio

namespace SFT.Physics.CosmicRatios
open SFT.Foundation.ExactOperations SFT.Foundation.ExactPartCarrier
open AlphaRatio AlphaBlocks AlphaCovers GeneratorOperations FoldFirstReturn
set_option maxRecDepth 100000
set_option maxHeartbeats 2000000

def pair (p : PositiveFraction) : Nat × Nat := (p.numerator,p.denominator)
def partPair (p : Part) : Nat × Nat := (p.numerator,p.denominator)

structure DarkBaryon where
 volume : Nat
 depth : Nat
 tower : Nat
 baryonShare : PositiveFraction
 darkShare : PositiveFraction
 leadingRatio : PositiveFraction
 orbitFloor : Nat
 orbitTrace : List Part
 refinedRatio : PositiveFraction

/-- The original dark_baryon_structure, with its admitted source computations. -/
def darkBaryonStructure : Except String DarkBaryon :=
 match hc : generatorPeriod with
 | .error e => .error e
 | .ok c =>
  have ce : c = 3 := Except.ok.inj (hc.symm.trans generatorPeriodThree)
  match hb : fineStructureBlocks with
  | .error e => .error e
  | .ok blocks =>
   have be : blocks = ⟨2,3,5,7,128,9,250⟩ := Except.ok.inj (hb.symm.trans forcedBlocks)
   let binary := blocks.binary
   let volume := c^c
   let depth := blocks.down
   let tower := binary^depth
   let floor := tower-1
   have vp : 0 < volume := by dsimp [volume]; rw [ce]; decide
   have dp : 0 < depth := by dsimp [depth]; rw [be]; decide
   have tp : 0 < tower := by dsimp [tower,binary,depth]; rw [be]; decide
   have fp : 0 < floor := by dsimp [floor,tower,binary,depth]; rw [be]; decide
   let orbitSource := normalizePart 1 floor (by decide) fp
   do
    let trace ← firstReturn orbitSource
    .ok ⟨volume,depth,tower,normalizePositive depth tower dp tp,
      normalizePositive volume tower vp tp,normalizePositive volume depth vp dp,
      floor,trace,divide (whole volume vp) (add (whole depth dp) (normalizePositive 1 floor (by decide) fp))⟩

structure Hubble where
 matterShare : PositiveFraction
 vacuumShare : PositiveFraction
 coveringTower : Nat
 leadingCorrection : PositiveFraction
 leadingRatio : PositiveFraction
 deepDepth : Nat
 orbitFloor : Nat
 orbitTrace : List Part
 refinedCorrection : PositiveFraction
 refinedRatio : PositiveFraction

/-- The original hubble_calibration_structure; no measurement is an input. -/
def hubbleStructure : Except String Hubble :=
 match hc : generatorPeriod with
 | .error e => .error e
 | .ok c =>
  have ce : c = 3 := Except.ok.inj (hc.symm.trans generatorPeriodThree)
  match hb : fineStructureBlocks with
  | .error e => .error e
  | .ok blocks =>
   have be : blocks = ⟨2,3,5,7,128,9,250⟩ := Except.ok.inj (hb.symm.trans forcedBlocks)
   have cp : 0 < c := by rw [ce]; decide
   let binary := blocks.binary
   have bp : 0 < binary := by dsimp [binary]; rw [be]; decide
   let tower := binary^c
   let depth := blocks.up
   let floor := binary^depth-1
   have tp : 0 < tower := by dsimp [tower,binary]; rw [ce,be]; decide
   have fp : 0 < floor := by dsimp [floor,binary,depth]; rw [be]; decide
   let matter := normalizePositive 1 c (by decide) cp
   let vacuum := normalizePositive binary c bp cp
   let leading := divide vacuum (whole tower tp)
   let refined := divide (add vacuum (normalizePositive 1 floor (by decide) fp)) (whole tower tp)
   do
    let trace ← firstReturn (normalizePart 1 floor (by decide) fp)
    .ok ⟨matter,vacuum,tower,leading,add one leading,depth,floor,trace,refined,add one refined⟩

def darkRecord (d : DarkBaryon) :=
 (d.volume,d.depth,d.tower,pair d.baryonShare,pair d.darkShare,pair d.leadingRatio,
  d.orbitFloor,d.orbitTrace.map partPair,pair d.refinedRatio)
def hubbleRecord (h : Hubble) :=
 (pair h.matterShare,pair h.vacuumShare,h.coveringTower,pair h.leadingCorrection,
 pair h.leadingRatio,h.deepDepth,h.orbitFloor,h.orbitTrace.map partPair,
 pair h.refinedCorrection,pair h.refinedRatio)

theorem darkExact : darkBaryonStructure.map darkRecord = .ok
 (27,5,32,(5,32),(27,32),(27,5),31,[(2,31),(4,31),(8,31),(16,31),(1,31)],(279,52)) := rfl

theorem hubbleExact : hubbleStructure.map hubbleRecord = .ok
 ((1,3),(2,3),8,(1,12),(13,12),7,127,
 [(2,127),(4,127),(8,127),(16,127),(32,127),(64,127),(1,127)],(257,3048),(3305,3048)) := rfl

theorem darkLeastCover : 27 ≤ 2^5 ∧ ∀ k, 0 < k → k < 5 → 2^k < 27 := downMinimal

theorem hubbleLeastDeepCover : 81 ≤ 2^7 ∧ ∀ k, 0 < k → k < 7 → 2^k < 81 := upMinimal

theorem darkFirstReturn : GeneratorThreeDerivation.FirstReturn
 (normalizePart 1 31 (by decide) (by decide))
 [normalizePart 2 31 (by decide) (by decide),normalizePart 4 31 (by decide) (by decide),
 normalizePart 8 31 (by decide) (by decide),normalizePart 16 31 (by decide) (by decide),
 normalizePart 1 31 (by decide) (by decide)] := nativeFirstReturn _ _ rfl

theorem hubbleFirstReturn : GeneratorThreeDerivation.FirstReturn
 (normalizePart 1 127 (by decide) (by decide))
 [normalizePart 2 127 (by decide) (by decide),normalizePart 4 127 (by decide) (by decide),
 normalizePart 8 127 (by decide) (by decide),normalizePart 16 127 (by decide) (by decide),
 normalizePart 32 127 (by decide) (by decide),normalizePart 64 127 (by decide) (by decide),
 normalizePart 1 127 (by decide) (by decide)] := nativeFirstReturn _ _ rfl

end SFT.Physics.CosmicRatios
