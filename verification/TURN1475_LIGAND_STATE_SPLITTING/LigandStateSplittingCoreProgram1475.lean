import SFT.Chemistry.LigandStateSplitting
open SFT.Host SFT.Physics.CapabilityValues SFT.Chemistry.LigandStateSplitting
def number (n : Nat) : Canonical.Value := .integer (Int.ofNat n)
def labelJSON (x : HeldLabel) : Canonical.Value := .object [("family",.text x.family),("label",.text x.label)]
def supportJSON (s : Support) : Canonical.Value := .object [("support_identity",labelJSON s.identity),("support_kind",labelJSON s.kind),("first_axis",number s.firstAxis.value),("second_axis",number s.secondAxis.value)]
def rankJSON : Rank → Canonical.Value
 | .absent => .object [("empty",.text "empty-One")]
 | .positive n => number n.value
def partJSON (p : Part) : Canonical.Value := .array [number p.numerator.value,number p.denominator.value]
def distanceJSON : Distance → Canonical.Value
 | .absent => .object [("empty",.text "empty-One")]
 | .part p => partJSON p
def splittingJSON (s : Splitting) : Canonical.Value := .object [
 ("central_identity",labelJSON s.centre),("unperturbed_positive_multiplicity",number s.unperturbed.value),
 ("levels",.array (s.levels.map fun l=>.object [("interaction_rank",rankJSON l.rank),("members",.array (l.members.map supportJSON))])),
 ("adjacent_positive_separations",.array (s.separations.map partJSON)),
 ("lower_distance_from_unsplit_or_absence",distanceJSON s.lower),("upper_distance_from_unsplit_or_absence",distanceJSON s.upper),
 ("complete_member_preservation",.boolean s.completeMemberPreservation)]
def out (r : Except String Splitting) : Canonical.Value := match r with
 | .ok s => .object [("ok",splittingJSON s)]
 | .error e => .object [("error",.text e)]
def main : IO Unit := do
 let removedResult := do removed (← heldLabel "coordination-central-occurrence" "removed-ligand-centre")
 IO.println (Canonical.render (.array ([sixResult,fourResult,removedResult].map out)))
