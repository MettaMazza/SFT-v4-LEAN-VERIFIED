import SFT.Chemistry.SolidLocalFormulaDerivation
import SFT.Chemistry.SolidLocalGenerator
namespace SFT.Chemistry.DefectChemistry
open SFT.Host SFT.Physics.CapabilityValues
open InorganicColour (sameLabel)
abbrev FormulaEntry := SolidLocal.FormulaEntry
abbrev CountOrEmpty := ElectronCountSpin.CountOrEmpty
abbrev formulaEntry := SolidLocal.formulaEntry
structure ReferenceSite where
 site : HeldLabel
 expected : HeldLabel
structure Occupancy where
 reference : ReferenceSite
 occupant : Value
structure Interstitial where
 site : HeldLabel
 occurrence : HeldLabel
structure Reconciliation where
 species : HeldLabel
 referenceCount : CountOrEmpty
 observedCount : CountOrEmpty
 missing : CountOrEmpty
 added : CountOrEmpty
inductive Classes where
 | emptyOne : String → Classes
 | support : List HeldLabel → Classes
structure Defect where
 motif : HeldLabel
 references : List ReferenceSite
 occupancies : List Occupancy
 interstitials : List Interstitial
 referenceFormula : List FormulaEntry
 observedFormula : List FormulaEntry
 reconciliation : List Reconciliation
 classes : Classes
 origin : Value

def referenceSite (site expected : HeldLabel) : Except String ReferenceSite :=
 if !Text.equal site.family "reference-solid-site" then .error "reference site identity is invalid"
 else if !Text.equal expected.family "chemical-species" then .error "reference site requires one expected species"
 else .ok ⟨site,expected⟩
def isEmpty : Value → Bool
 | .emptyOne _ => true
 | .count _ | .ratio _ _ | .label _ | .word _ | .pair _ _ | .table _ => false
def occupancy (reference : ReferenceSite) (occupant : Value) : Except String Occupancy :=
 match occupant with
 | .emptyOne _ => .ok ⟨reference,occupant⟩
 | .label x => if Text.equal x.family "species-occurrence" then .ok ⟨reference,occupant⟩ else .error "site occupant must be a retained occurrence or structural EmptyOne"
 | .count _ | .ratio _ _ | .word _ | .pair _ _ | .table _ => .error "site occupant must be a retained occurrence or structural EmptyOne"
def interstitial (site occurrence : HeldLabel) : Except String Interstitial :=
 if !Text.equal site.family "interstitial-solid-site" then .error "interstitial site identity is invalid"
 else if !Text.equal occurrence.family "species-occurrence" then .error "interstitial support requires a species occurrence"
 else .ok ⟨site,occurrence⟩
def countEmpty : CountOrEmpty → Bool
 | .emptyOne _ => true | .count _ => false
def reconciliationRow (species : HeldLabel) (referenceCount observedCount missing added : CountOrEmpty) : Except String Reconciliation :=
 if !Text.equal species.family "chemical-species" then .error "reconciliation species is invalid"
 else if !countEmpty missing && !countEmpty added then .error "one species cannot be both missing and added"
 else .ok ⟨species,referenceCount,observedCount,missing,added⟩
def species (s : String) := heldLabel "chemical-species" s
def occurrence (s label : String) := heldLabel "species-occurrence" (Text.intercalate "#" [s,label])
def occurrenceSpecies : Value → Except String String
 | .label x =>
  if !Text.equal x.family "species-occurrence" || !Text.contains x.label "#" then .error "species occurrence is malformed"
  else .ok (SolidLocal.speciesName x)
 | .emptyOne _ | .count _ | .ratio _ _ | .word _ | .pair _ _ | .table _ => .error "species occurrence is malformed"
def positiveOrEmpty : Int → Except String CountOrEmpty
 | .ofNat n => .ok (MetalCluster.counted n)
 | .negSucc _ => .error "an SFT count must be a positive counted value"
def orderedLabels (labels : List String) : List String :=
 labels.foldl (fun acc x => if acc.any (Text.equal x) then acc else acc++[x]) []
def labelCount (labels : List String) (s : String) : Nat := (labels.filter (Text.equal s)).length
def primitiveFormula (labels : List String) : Except String (List FormulaEntry) := do
 if labels.isEmpty then throw "a formula requires positive occurrence support"
 let ordered := orderedLabels labels
 let counts := ordered.map (labelCount labels)
 let divisor := match counts with | [] => 0 | n::ns => ns.foldl Nat.gcd n
 ordered.mapM fun label => do
  let s ← species label
  let n ← count (labelCount labels label/divisor)
  formulaEntry s n

def observedLabels (occupancies : List Occupancy) (interstitials : List Interstitial) : Except String (List String) := do
 let localLabels ← (occupancies.filter (fun row => !isEmpty row.occupant)).mapM (fun row => occurrenceSpecies row.occupant)
 let otherLabels ← interstitials.mapM (fun row => occurrenceSpecies (.label row.occurrence))
 return localLabels++otherLabels

def reconcile (references : List ReferenceSite) (occupancies : List Occupancy) (interstitials : List Interstitial) : Except String (List Reconciliation) := do
 let reference := references.map (fun r => r.expected.label)
 let observed ← observedLabels occupancies interstitials
 (orderedLabels (reference++observed)).mapM fun label => do
  let r := labelCount reference label
  let o := labelCount observed label
  reconciliationRow (← species label) (MetalCluster.counted r) (MetalCluster.counted o)
   (if r>o then MetalCluster.counted (r-o) else .emptyOne "empty-One")
   (if o>r then MetalCluster.counted (o-r) else .emptyOne "empty-One")

def hasSubstitution : List Occupancy → Except String Bool
 | [] => .ok false
 | row::rows => if isEmpty row.occupant then hasSubstitution rows else do
  let label ← occurrenceSpecies row.occupant
  if !Text.equal label row.reference.expected.label then return true
  hasSubstitution rows

def classify (occupancies : List Occupancy) (interstitials : List Interstitial) : Except String Classes := do
 let vacancy := if occupancies.any (fun row => isEmpty row.occupant) then [⟨"defect-class","vacancy",rfl,rfl⟩] else []
 let substitution ← hasSubstitution occupancies
 let classes := vacancy++(if substitution then [⟨"defect-class","substitution",rfl,rfl⟩] else [])++(if interstitials.isEmpty then [] else [⟨"defect-class","interstitial",rfl,rfl⟩])
 return if classes.isEmpty then .emptyOne "empty-One" else .support classes

def origin (references : List ReferenceSite) (occupancies : List Occupancy) (interstitials : List Interstitial) : Except String Value := do
 let classes ← classify occupancies interstitials
 match classes with
 | .emptyOne _ => return .emptyOne "empty-One"
 | .support _ =>
  let observed ← observedLabels occupancies interstitials
  let reference := references.map (fun r => r.expected.label)
  let name := if observed.any (fun label => !(reference.any (Text.equal label))) then "extrinsic" else "intrinsic"
  return .label (← heldLabel "defect-origin" name)

def sameReference (a b : ReferenceSite) : Bool := sameLabel a.site b.site && sameLabel a.expected b.expected
def distinctReferences : List ReferenceSite → Bool
 | [] => true | r::rs => !(rs.any (sameReference r)) && distinctReferences rs
def sameReferences : List ReferenceSite → List ReferenceSite → Bool
 | [],[] => true
 | a::as,b::bs => sameReference a b && sameReferences as bs
 | [],_::_ | _::_,[] => false
def sameRows : List Reconciliation → List Reconciliation → Bool
 | [],[] => true
 | a::as,b::bs => sameLabel a.species b.species && MetalCluster.sameCount a.referenceCount b.referenceCount && MetalCluster.sameCount a.observedCount b.observedCount && MetalCluster.sameCount a.missing b.missing && MetalCluster.sameCount a.added b.added && sameRows as bs
 | [],_::_ | _::_,[] => false
def sameLabels : List HeldLabel → List HeldLabel → Bool
 | [],[] => true | a::as,b::bs => sameLabel a b && sameLabels as bs
 | [],_::_ | _::_,[] => false
def sameClasses : Classes → Classes → Bool
 | .emptyOne a,.emptyOne b => Text.equal a b
 | .support a,.support b => sameLabels a b
 | .emptyOne _,.support _ | .support _,.emptyOne _ => false
def sameOrigin : Value → Value → Bool
 | .emptyOne a,.emptyOne b => Text.equal a b
 | .label a,.label b => sameLabel a b
 | .emptyOne _, .count _ | .emptyOne _, .ratio _ _ | .emptyOne _, .label _ | .emptyOne _, .word _ | .emptyOne _, .pair _ _ | .emptyOne _, .table _ => false
 | .label _, .emptyOne _ | .label _, .count _ | .label _, .ratio _ _ | .label _, .word _ | .label _, .pair _ _ | .label _, .table _ => false
 | .count _, _ | .ratio _ _, _ | .word _, _ | .pair _ _, _ | .table _, _ => false

def defect (motif : HeldLabel) (references : List ReferenceSite) (occupancies : List Occupancy) (interstitials : List Interstitial)
 (referenceFormula observedFormula : List FormulaEntry) (rows : List Reconciliation) (classes : Classes) (originClass : Value) : Except String Defect := do
 if !Text.equal motif.family "local-solid-motif" then throw "defect chemistry requires one local solid motif"
 if references.isEmpty || !distinctReferences references then throw "reference support must be positive, finite and complete"
 if !sameReferences (occupancies.map Occupancy.reference) references then throw "every reference site requires exactly one occupancy record"
 if !InorganicColour.distinctLabels (interstitials.map Interstitial.site) then throw "interstitial site support is duplicated"
 let ref ← primitiveFormula (references.map (fun r => r.expected.label))
 if !SolidLocal.sameFormula referenceFormula ref then throw "reference formula is not the exact primitive site ratio"
 let labels ← observedLabels occupancies interstitials
 if labels.isEmpty then throw "an observed local motif must retain positive chemical support"
 let obs ← primitiveFormula labels
 if !SolidLocal.sameFormula observedFormula obs then throw "observed formula is not the exact primitive occurrence ratio"
 let exactRows ← reconcile references occupancies interstitials
 if !sameRows rows exactRows then throw "reference and observed supports do not reconcile exactly"
 let exactClasses ← classify occupancies interstitials
 if !sameClasses classes exactClasses then throw "defect class support is incomplete"
 let exactOrigin ← origin references occupancies interstitials
 if !sameOrigin originClass exactOrigin then throw "intrinsic/extrinsic composition classification changed"
 return ⟨motif,references,occupancies,interstitials,referenceFormula,observedFormula,rows,classes,originClass⟩

-- Non-EmptyOne source inputs are supplied as their original str(observed) representation.
inductive ObservedInput where
 | emptyOne : String → ObservedInput
 | text : String → ObservedInput

def defectState (motif : String) (expected : List String) (observed : List ObservedInput) (extra : List String := []) : Except String Defect := do
 if expected.length != observed.length then throw "reference and occupancy boundaries differ"
 let references ← expected.zipIdx.mapM fun (label,i) => do
  referenceSite (← heldLabel "reference-solid-site" (Text.append "site-" (toString (i+1)))) (← species label)
 let occupancies ← (references.zip observed).zipIdx.mapM fun ((r,observed),i) => do
  let value ← (match observed with
   | .emptyOne _ => .ok (Value.emptyOne "empty-One")
   | .text label => do return Value.label (← occurrence label (Text.append "site-" (toString (i+1))))
   : Except String Value)
  occupancy r value
 let interstitials ← extra.zipIdx.mapM fun (label,i) => do
  interstitial (← heldLabel "interstitial-solid-site" (Text.append "interstitial-" (toString (i+1)))) (← occurrence label (Text.append "interstitial-" (toString (i+1))))
 let labels ← observedLabels occupancies interstitials
 let entity ← heldLabel "local-solid-motif" motif
 let rf ← primitiveFormula expected
 let of ← primitiveFormula labels
 let rows ← reconcile references occupancies interstitials
 let classes ← classify occupancies interstitials
 let org ← origin references occupancies interstitials
 defect entity references occupancies interstitials rf of rows classes org
end SFT.Chemistry.DefectChemistry
