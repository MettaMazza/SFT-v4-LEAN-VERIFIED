import SFT.Chemistry.SequentialMechanism
namespace SFT.Chemistry.KineticIsotopeEffect
open SFT.Host SFT.Physics SFT.Physics.CapabilityValues SFT.Chemistry.DihedralTorsion
open SequentialMechanism
set_option maxRecDepth 30000
set_option maxHeartbeats 100000000
structure ExactPositiveEventRate where
 completedEvents : PositiveCount
 observationParts : PositiveCount
 value : Rat
inductive RateInput where
 | rate (value : ExactPositiveEventRate)
 | other
inductive FractionInput where
 | fraction (value : Rat)
 | other
def makeRate (events parts : PositiveCount) (input : FractionInput) : Except String ExactPositiveEventRate := do
 let value ← match input with
  | .fraction r=>pure r
  | .other=>throw "isotopologue event rate must be exact and positive"
 if value.num ≤ 0 then throw "isotopologue event rate must be exact and positive"
 if value.num * Int.ofNat parts.value != Int.ofNat (events.value * value.den) then
  throw "isotopologue event rate must equal its complete exact count relation"
 pure ⟨events,parts,value⟩
def rateFromCounts (events parts : SequentialMechanism.CountInput) : Except String ExactPositiveEventRate := do
 let events ← match events with
  | .count v=>pure v
  | .other=>throw "isotopologue rate requires exact positive counts"
 let parts ← match parts with
  | .count v=>pure v
  | .other=>throw "isotopologue rate requires exact positive counts"
 makeRate events parts (.fraction (LeptonIntervals.normalize (.ofNat events.value) parts.value parts.positive))
structure RetainedIsotopologuePath where
 reactionIdentity : HeldLabel
 pathIdentity : HeldLabel
 isotopologueIdentity : HeldLabel
 orderedPathRoles : List HeldLabel
 conditionIdentity : HeldLabel
 eventRate : ExactPositiveEventRate
 evidenceStatus : HeldLabel
def makePath (reaction path isotope : LabelInput) (roles : List LabelInput) (condition : LabelInput) (rate : RateInput) (status : LabelInput) : Except String RetainedIsotopologuePath := do
 let reaction ← match reaction with
  | .held l=>if Text.equal l.family "held-isotope-reaction-identity" then pure l else throw "isotope reaction identity must remain held"
  | .other=>throw "isotope reaction identity must remain held"
 let path ← match path with
  | .held l=>if Text.equal l.family "held-complete-reaction-path" then pure l else throw "complete reaction path identity must remain held"
  | .other=>throw "complete reaction path identity must remain held"
 let isotope ← match isotope with
  | .held l=>if Text.equal l.family "held-isotopologue-identity" then pure l else throw "isotopologue identity must remain held"
  | .other=>throw "isotopologue identity must remain held"
 if roles.length<2 then throw "isotopologue comparison requires a complete finite reaction path"
 let roles ← roles.mapM fun role=>match role with
  | .held l=>if Text.equal l.family "registered-reaction-path-role" then pure l else throw "isotopologue comparison requires a complete finite reaction path"
  | .other=>throw "isotopologue comparison requires a complete finite reaction path"
 if (roles.foldl (fun found x=>if found.any (equalLabel x) then found else found++[x]) []).length != roles.length then
  throw "reaction path roles must remain distinct and ordered"
 let condition ← match condition with
  | .held l=>if Text.equal l.family "held-isotope-reaction-condition" then pure l else throw "isotopologue condition must remain held"
  | .other=>throw "isotopologue condition must remain held"
 let rate ← match rate with
  | .rate r=>pure r
  | .other=>throw "isotopologue path requires an exact positive event rate"
 let status ← match status with
  | .held l=>if Text.equal l.family "held-isotope-rate-status" then pure l else throw "isotopologue evidence status must remain held"
  | .other=>throw "isotopologue evidence status must remain held"
 pure ⟨reaction,path,isotope,roles,condition,rate,status⟩
inductive PathInput where
 | path (value : RetainedIsotopologuePath)
 | other
structure CompleteIsotopologueRatePair where
 orderedPairIdentity : HeldLabel
 numeratorPath : RetainedIsotopologuePath
 denominatorPath : RetainedIsotopologuePath
def equalRoles (a b : List HeldLabel) : Bool :=
 a.length==b.length && (a.zip b).all (fun (x,y)=>equalLabel x y)
def makePair (identity : LabelInput) (numerator denominator : PathInput) : Except String CompleteIsotopologueRatePair := do
 let identity ← match identity with
  | .held l=>if Text.equal l.family "registered-ordered-isotopologue-pair" then pure l else throw "isotopologue comparison pair must be registered"
  | .other=>throw "isotopologue comparison pair must be registered"
 let numerator ← match numerator with
  | .path p=>pure p
  | .other=>throw "isotopologue comparison requires two retained paths"
 let denominator ← match denominator with
  | .path p=>pure p
  | .other=>throw "isotopologue comparison requires two retained paths"
 if equalLabel numerator.isotopologueIdentity denominator.isotopologueIdentity then
  throw "isotopologue comparison requires two distinct held isotope identities"
 if !equalLabel numerator.reactionIdentity denominator.reactionIdentity ||
    !equalLabel numerator.pathIdentity denominator.pathIdentity ||
    !equalRoles numerator.orderedPathRoles denominator.orderedPathRoles ||
    !equalLabel numerator.conditionIdentity denominator.conditionIdentity then
  throw "isotopologue rates must retain the same reaction, path and condition"
 pure ⟨identity,numerator,denominator⟩
inductive PairInput where
 | pair (value : CompleteIsotopologueRatePair)
 | other
structure ExactKineticIsotopeEffectRelation where
 orderedPairIdentity : HeldLabel
 numeratorIsotopologue : HeldLabel
 denominatorIsotopologue : HeldLabel
 completeReactionPath : List HeldLabel
 exactRateRatio : Rat
 ratioOrientation : HeldLabel
def makeRelation (identity numerator denominator : HeldLabel) (roles : List HeldLabel) (input : FractionInput) (orientation : HeldLabel) : Except String ExactKineticIsotopeEffectRelation := do
 let ratio ← match input with
  | .fraction r=>pure r
  | .other=>throw "kinetic isotope-effect relation must be exact and positive"
 if ratio.num ≤ 0 then throw "kinetic isotope-effect relation must be exact and positive"
 pure ⟨identity,numerator,denominator,roles,ratio,orientation⟩
def forcedKineticIsotopeEffectRelation (input : PairInput) : Except String ExactKineticIsotopeEffectRelation := do
 let pair ← match input with
  | .pair p=>pure p
  | .other=>throw "kinetic isotope relation requires one complete ordered isotopologue pair"
 let numerator := pair.numeratorPath.eventRate
 let denominator := pair.denominatorPath.eventRate
 let ratio := LeptonIntervals.normalize (.ofNat (numerator.completedEvents.value * denominator.observationParts.value))
  (numerator.observationParts.value * denominator.completedEvents.value)
  (Nat.mul_pos numerator.observationParts.positive denominator.completedEvents.positive)
 let orientation := if ratio.num > Int.ofNat ratio.den then "numerator-rate-greater"
  else if ratio.num < Int.ofNat ratio.den then "denominator-rate-greater" else "rates-exactly-equal"
 let orientation ← heldLabel "held-rate-ratio-orientation" orientation
 makeRelation pair.orderedPairIdentity pair.numeratorPath.isotopologueIdentity pair.denominatorPath.isotopologueIdentity
  pair.numeratorPath.orderedPathRoles (.fraction ratio) orientation
structure RegisteredIsotopologuePairOccurrence where
 sourceOccurrence : PositiveCount
 pair : CompleteIsotopologueRatePair
def makeOccurrence (source : SequentialMechanism.CountInput) (input : PairInput) : Except String RegisteredIsotopologuePairOccurrence := do
 let source ← match source with
  | .count v=>pure v
  | .other=>throw "isotopologue pair source occurrence must be positive"
 let _ ← forcedKineticIsotopeEffectRelation input
 let pair ← match input with
  | .pair p=>pure p
  | .other=>throw "kinetic isotope relation requires one complete ordered isotopologue pair"
 pure ⟨source,pair⟩
inductive OccurrenceInput where
 | occurrence (value : RegisteredIsotopologuePairOccurrence)
 | other
structure CompleteKineticIsotopeFamily where
 orderedOccurrences : List RegisteredIsotopologuePairOccurrence
def makeFamily (rows : List OccurrenceInput) : Except String CompleteKineticIsotopeFamily := do
 if rows.isEmpty then throw "kinetic isotope family requires at least one complete pair"
 let rows ← rows.mapM fun row=>match row with
  | .occurrence o=>pure o
  | .other=>throw "kinetic isotope family requires at least one complete pair"
 if !(rows.zipIdx.all fun (o,i)=>o.sourceOccurrence.value==i+1) then throw "kinetic isotope pair occurrences must be complete and gap-free"
 pure ⟨rows⟩
def equalRelation (a b : ExactKineticIsotopeEffectRelation) : Bool :=
 equalLabel a.orderedPairIdentity b.orderedPairIdentity && equalLabel a.numeratorIsotopologue b.numeratorIsotopologue &&
 equalLabel a.denominatorIsotopologue b.denominatorIsotopologue && equalRoles a.completeReactionPath b.completeReactionPath &&
 a.exactRateRatio.num==b.exactRateRatio.num && a.exactRateRatio.den==b.exactRateRatio.den && equalLabel a.ratioOrientation b.ratioOrientation
def appendIsotopologuePairPreservesCompleteFamily (family : CompleteKineticIsotopeFamily) (successor : RegisteredIsotopologuePairOccurrence) : Except String Bool := do
 if successor.sourceOccurrence.value != family.orderedOccurrences.length+1 then throw "kinetic isotope successor must be the next positive occurrence"
 let prior ← family.orderedOccurrences.mapM fun row=>forcedKineticIsotopeEffectRelation (.pair row.pair)
 let extended ← makeFamily ((family.orderedOccurrences++[successor]).map OccurrenceInput.occurrence)
 let results ← extended.orderedOccurrences.mapM fun row=>forcedKineticIsotopeEffectRelation (.pair row.pair)
 let retained := results.take prior.length
 pure (retained.length==prior.length && (retained.zip prior).all (fun (a,b)=>equalRelation a b) && results.length==prior.length+1)
def witnessPath (isotope : String) (events parts : PositiveCount) (label : String := "pair-a") : Except String RetainedIsotopologuePath := do
 let roles ← ["entry","boundary","event","product"].mapM (heldLabel "registered-reaction-path-role")
 makePath (.held ⟨"held-isotope-reaction-identity","reaction-a",rfl,rfl⟩) (.held ⟨"held-complete-reaction-path","path-a",rfl,rfl⟩)
  (.held (← heldLabel "held-isotopologue-identity" isotope)) (roles.map MolecularFormationEnergy.LabelInput.held)
  (.held ⟨"held-isotope-reaction-condition","condition-a",rfl,rfl⟩) (.rate (← rateFromCounts (.count events) (.count parts)))
  (.held (← heldLabel "held-isotope-rate-status" label))
def witnessPair (label : String) (first second : PositiveCount) : Except String CompleteIsotopologueRatePair := do
 makePair (.held (← heldLabel "registered-ordered-isotopologue-pair" label))
  (.path (← witnessPath "light-held-label" first ⟨5,by decide⟩ label)) (.path (← witnessPath "heavy-held-label" second ⟨5,by decide⟩ label))
def base : Except String CompleteIsotopologueRatePair := witnessPair "pair-a" ⟨3,by decide⟩ ⟨2,by decide⟩
def heldIdentitiesWitness : Except String Bool := do
 let pair ← base
 pure (!equalLabel pair.numeratorPath.isotopologueIdentity pair.denominatorPath.isotopologueIdentity)
def exactRatioWitness : Except String Bool := do
 let result ← forcedKineticIsotopeEffectRelation (.pair (← base))
 pure (result.exactRateRatio.num==3 && result.exactRateRatio.den==2)
def orientationWitness : Except String Bool := do
 let result ← forcedKineticIsotopeEffectRelation (.pair (← base))
 pure (Text.equal result.ratioOrientation.label "numerator-rate-greater")
def successorWitness : Except String Bool := do
 let prior ← makeOccurrence (.count ⟨1,by decide⟩) (.pair (← base))
 let family ← makeFamily [.occurrence prior]
 let next ← witnessPair "pair-b" ⟨2,by decide⟩ ⟨3,by decide⟩
 let successor ← makeOccurrence (.count ⟨2,by decide⟩) (.pair next)
 appendIsotopologuePairPreservesCompleteFamily family successor
theorem heldIdentities : heldIdentitiesWitness=.ok true := rfl
theorem exactRatio : exactRatioWitness=.ok true := rfl
theorem heldOrientation : orientationWitness=.ok true := rfl
theorem completeSuccessorFamily : successorWitness=.ok true := rfl
end SFT.Chemistry.KineticIsotopeEffect
