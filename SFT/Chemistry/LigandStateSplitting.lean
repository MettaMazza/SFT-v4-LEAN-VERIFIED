import SFT.Chemistry.CoordinationIsomerismWitnesses
namespace SFT.Chemistry.LigandStateSplitting
open SFT.Host SFT.Physics.CapabilityValues CoordinationIsomerism
structure Support where
 identity : HeldLabel
 kind : HeldLabel
 firstAxis : PositiveCount
 secondAxis : PositiveCount
def support (identity kind : HeldLabel) (first second : PositiveCount) : Except String Support := do
 if !Text.equal identity.family "rank-two-state-support" then
  throw "rank-two support requires a retained identity"
 if !Text.equal kind.family "rank-two-support-kind" ||
  !(Text.equal kind.label "held-axis-contrast" || Text.equal kind.label "boundary-axis-pair") then
  throw "rank-two support requires a generated kind"
 if first.value >= second.value || second.value > 3 then
  throw "rank-two support axes must be one generated pair in rank three"
 return ⟨identity,kind,first,second⟩
def generated : Except String (List Support) := do
 let make := fun (kind stem : String) (pair : Nat × Nat) => do
  support (← heldLabel "rank-two-state-support" (Text.intercalate "-" [stem,toString pair.1,toString pair.2]))
   (← heldLabel "rank-two-support-kind" kind) (← count pair.1) (← count pair.2)
 let contrasts ← [(1,2),(2,3)].mapM (make "held-axis-contrast" "held-contrast")
 let pairs ← [(1,2),(1,3),(2,3)].mapM (make "boundary-axis-pair" "boundary-pair")
 return contrasts++pairs
structure Geometry where
 centre : HeldLabel
 words : List (List Cell)
def sameWord := CoordinationIsomerismWitnesses.sameList CoordinationIsomerismWitnesses.sameCell
def distinctWords : List (List Cell) → Bool
 | [] => true
 | first::rest => !(rest.any (sameWord first)) && distinctWords rest
def geometry (centre : HeldLabel) (words : List (List Cell)) : Except String Geometry := do
 if !Text.equal centre.family "coordination-central-occurrence" then
  throw "ligand interaction requires one retained centre"
 if words.isEmpty then throw "ligand interaction geometry requires positive attached support"
 if !distinctWords words then throw "every attached ligand occurrence requires a distinct orientation word"
 let _ ← words.mapM fun word => do
  if word.length != 3 || word.all emptyCell then throw "each ligand requires a nonempty three-axis word"
  if !(word.all validCell) then throw "orientation admits only the two forced Fold fibres"
  pure ()
 return ⟨centre,words⟩
inductive Rank where
 | absent
 | positive (value : PositiveCount)
def rankNumber : Rank → Nat
 | .absent => 0
 | .positive n => n.value
def presentAt (word : List Cell) (n : Nat) : Bool :=
 match MolecularGraphEnumeration.atIndex word n with
 | some cell => !emptyCell cell
 | none => false
def interactionRank (s : Support) (g : Geometry) : Rank :=
 let matchingWords := g.words.filter fun word =>
  let first := presentAt word (s.firstAxis.value-1)
  let second := presentAt word (s.secondAxis.value-1)
  if Text.equal s.kind.label "held-axis-contrast" then first != second else first && second
 if h : 0 < matchingWords.length then .positive ⟨matchingWords.length,h⟩ else .absent
structure Level where
 rank : Rank
 members : List Support
def addSupport (s : Support) (rank : Rank) : List Level → List Level
 | [] => [⟨rank,[s]⟩]
 | level::rest => if rankNumber rank==rankNumber level.rank then
   ⟨rank,level.members++[s]⟩::rest else level::addSupport s rank rest
def insertLevel (value : Level) : List Level → List Level
 | [] => [value]
 | first::rest => if rankNumber value.rank <= rankNumber first.rank then value::first::rest
   else first::insertLevel value rest
def sortedLevels : List Level → List Level
 | [] => []
 | first::rest => insertLevel first (sortedLevels rest)
structure Part where
 numerator : PositiveCount
 denominator : PositiveCount
 throughOne : numerator.value ≤ denominator.value
def part (n d : Nat) : Except String Part := do
 if h : 0<n ∧ 0<d ∧ n≤d then
  let factor := Nat.gcd n d
  let numerator ← count (n/factor)
  let denominator ← count (d/factor)
  if h' : numerator.value≤denominator.value then return ⟨numerator,denominator,h'⟩
  else throw "an SFT part must lie in the exact positive domain through the One"
 else throw "an SFT part must lie in the exact positive domain through the One"
inductive Distance where
 | absent
 | part (value : Part)
structure Splitting where
 centre : HeldLabel
 unperturbed : PositiveCount
 levels : List Level
 separations : List Part
 lower : Distance
 upper : Distance
 completeMemberPreservation : Bool
def adjacent (width : Nat) : List Level → Except String (List Part)
 | [] | [_] => pure []
 | first::second::rest => do
  let gap ← part (rankNumber second.rank-rankNumber first.rank) width
  return gap::(← adjacent width (second::rest))
def sameSupport (a b : Support) : Bool :=
 Text.equal a.identity.family b.identity.family && Text.equal a.identity.label b.identity.label &&
 Text.equal a.kind.family b.kind.family && Text.equal a.kind.label b.kind.label &&
 a.firstAxis.value==b.firstAxis.value && a.secondAxis.value==b.secondAxis.value
def forced (g : Geometry) : Except String Splitting := do
 let supports ← generated
 let levels := sortedLevels (supports.foldl (fun groups s => addSupport s (interactionRank s g) groups) [])
 let separations ← adjacent g.words.length levels
 let (lower,upper) ← (match levels with
  | [] => pure (.absent,.absent)
  | a::tail => match tail with
   | [] => pure (.absent,.absent)
   | b::rest => match rest with
    | _::_ => pure (.absent,.absent)
    | [] => do
     let total := a.members.length+b.members.length
     pure (Distance.part (← part b.members.length total),Distance.part (← part a.members.length total)))
 let members := levels.flatMap Level.members
 return ⟨g.centre,← count supports.length,levels,separations,lower,upper,
  members.length==supports.length && supports.all (fun s => members.any (sameSupport s)) &&
   members.all (fun s => supports.any (sameSupport s))⟩
def removed (centre : HeldLabel) : Except String Splitting := do
 let supports ← generated
 return ⟨centre,⟨5,by decide⟩,[⟨.absent,supports⟩],[],.absent,.absent,true⟩
def fibre (name : String) : Except String Cell := do
 return .held (← heldLabel "fold-orientation-fibre" name)
def six : Except String Geometry := do
 let one ← fibre "fibre-one"
 let two ← fibre "fibre-two"
 let empty := Cell.empty "empty-One"
 geometry (← heldLabel "coordination-central-occurrence" "six-direct-axis-centre")
  [[one,empty,empty],[two,empty,empty],[empty,one,empty],[empty,two,empty],[empty,empty,one],[empty,empty,two]]
def four : Except String Geometry := do
 let one ← fibre "fibre-one"
 let two ← fibre "fibre-two"
 geometry (← heldLabel "coordination-central-occurrence" "four-complete-axis-centre")
  [[one,one,one],[one,two,two],[two,one,two],[two,two,one]]
def widths (r : Except String Splitting) : List Nat :=
 match r with | .error _ => [] | .ok s => s.levels.map (fun level => level.members.length)
def sixResult : Except String Splitting := do forced (← six)
def fourResult : Except String Splitting := do forced (← four)
theorem sixMultiplicities : widths sixResult = [3,2] := by decide
theorem fourMultiplicities : widths fourResult = [2,3] := by decide
end SFT.Chemistry.LigandStateSplitting
