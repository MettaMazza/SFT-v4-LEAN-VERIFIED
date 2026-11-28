import SFT.Applications.Discovery.Source
import SFT.Applications.Discovery.Display
import SFT.Host.SHA256
namespace SFT.Applications.Discovery.Reports
open SFT.Host.Text
open SFT.Applications.Discovery
open SFT.Applications.Discovery.Explorer
open SFT.Applications.Discovery.Carry
open SFT.Applications.Discovery.Source
open SFT.Applications.Discovery.Display

def digit (c : Char) : Bool := decide (48 ≤ c.toNat ∧ c.toNat ≤ 57)
def decimal (xs : List Char) : Int := Int.ofNat (xs.foldl (fun n c => n*10+c.toNat-48) 0)
def namedRatios : Nat → List Char → Bool → List Fraction
 | 0, _, _ => []
 | fuel+1, cs, previousWord => match cs with
  | [] => []
  | c::rest =>
   if digit c && !previousWord then
    let numerator := cs.takeWhile digit
    let tail := (cs.drop numerator.length).dropWhile whitespace
    if hasPrefixChars ['/'] tail then
     let rhs := (tail.drop 1).dropWhile whitespace
     let denominator := rhs.takeWhile digit
     let after := rhs.drop denominator.length
     if !denominator.isEmpty && !(after.head?.map wordChar).getD false then
      let more := namedRatios fuel after true
      if decimal denominator = 0 then more else fraction (decimal numerator) (decimal denominator)::more
     else namedRatios fuel rest (wordChar c)
    else namedRatios fuel rest (wordChar c)
   else namedRatios fuel rest (wordChar c)
def corpusNamedParts (corpus : Corpus) : List Fraction :=
 corpus.entries.foldl (fun out entry =>
  if SFT.Host.Text.equal entry.status "E" then
   let cs := chars entry.description
   (namedRatios cs.length cs false).foldl Explorer.insert out
  else out) []

def fractionLE (a b : Fraction) : Bool := decide (a.numerator*b.denominator ≤ b.numerator*a.denominator)
def insertFraction (x : Fraction) : List Fraction → List Fraction
 | [] => [x]
 | first::rest => bif fractionLE x first then x::first::rest else first::insertFraction x rest
def sortFractions : List Fraction → List Fraction
 | [] => []
 | x::xs => insertFraction x (sortFractions xs)
def setEqual (xs ys : List Fraction) : Bool := xs.all (fun x => Explorer.contains ys x) && ys.all (fun y => Explorer.contains xs y)
structure OrbitGroup where
 key : List Fraction
 members : List Fraction

def insertGroup (x : Fraction) (key : List Fraction) : List OrbitGroup → List OrbitGroup
 | [] => [{key,members := [x]}]
 | first::rest => bif setEqual key first.key then {first with members := first.members++[x]}::rest else first::insertGroup x key rest

def groupBefore (a b : OrbitGroup) : Bool :=
 if a.members.length = b.members.length then SFT.Host.Text.le (fractionText (a.members.headD (fraction 1 1))) (fractionText (b.members.headD (fraction 1 1)))
 else decide (a.members.length > b.members.length)
def insertOrderedGroup (x : OrbitGroup) : List OrbitGroup → List OrbitGroup
 | [] => [x]
 | first::rest => bif groupBefore x first then x::first::rest else first::insertOrderedGroup x rest
def sortGroups : List OrbitGroup → List OrbitGroup
 | [] => []
 | x::xs => insertOrderedGroup x (sortGroups xs)
structure Analysis where
 named : List Fraction
 closed : List Fraction
 claimed : List Fraction
 unclaimed : List Fraction
 groups : List OrbitGroup
 unanchored : List OrbitGroup

def analyze (corpus : Corpus) : Analysis :=
 let named := corpusNamedParts corpus
 let closed := sortFractions (closedSet)
 let claimed := closed.filter (fun x => Explorer.contains named x)
 let unclaimed := closed.filter (fun x => !(Explorer.contains named x))
 let groups := sortGroups (unclaimed.foldl (fun groups x => insertGroup x (binaryOrbitSet x) groups) [])
 let unanchored := groups.filter (fun g => !(claimed.any (fun x => Explorer.contains g.key x)))
 {named,closed,claimed,unclaimed,groups,unanchored}
structure CarryRow where
 tag : String
 result : Result
def carryRows (corpus : Corpus) : List CarryRow :=
 (corpus.entries.filter (fun e => SFT.Host.Text.equal e.status "E")).map (fun e => {tag := e.tag,result := carryVerdict (entrySource corpus e)})
def countVerdict (rows : List CarryRow) (name : String) : Nat :=
 (rows.filter (fun row => SFT.Host.Text.equal (verdictName row.result.verdict) name)).length

def n (x : Nat) : String := number (Int.ofNat x)
def padRight (width : Nat) (s : String) : String := append s (String.ofList (List.replicate (width-(chars s).length) ' '))
def padLeft (width : Nat) (s : String) : String := append (String.ofList (List.replicate (width-(chars s).length) ' ')) s
def fractionList (xs : List Fraction) : String := intercalate ", " (xs.map fractionText)
def insertInt (x : Int) : List Int → List Int
 | [] => [x]
 | y::ys => if x ≤ y then x::y::ys else y::insertInt x ys
def sortInts : List Int → List Int
 | [] => []
 | x::xs => insertInt x (sortInts xs)
def integerList (xs : List Int) : String := join ["[",intercalate ", " (xs.map number),"]"]
def yesNo (x : Bool) : String := bif x then "True" else "False"
def checkText : Option Bool → String
 | none => "-"
 | some b => bif b then "Y" else "n"
def selfHash (root : String) : IO String := do
 let bytes ← IO.FS.readBinFile (System.FilePath.mk (append root "/pure/discovery.py"))
 return SFT.Host.SHA256.digest bytes

def each {α : Type} : List α → (α → IO Unit) → IO Unit
 | [], _ => pure ()
 | x::xs, f => do
  f x
  each xs f

def foldIO {α β : Type} : List α → β → (β → α → IO β) → IO β
 | [], state, _ => pure state
 | x::xs, state, f => do
  let next ← f state x
  foldIO xs next f

def reportMain (hash : String) (corpus : Corpus) (full : Bool) : IO Unit := do
 let rows := carryRows corpus
 line (append "discovery self-hash: " (String.ofList ((chars hash).take 16)))
 line (join ["engine: ratio.py (exact)   registered results: ",n rows.length,"\n"])
 line "=== PER-RESULT CARRY — where each construction's math carries further than the claim ==="
 line (join ["  examined: ",n rows.length," (all registered results)   coverage: COMPLETE"])
 each ["CARRIES_FURTHER","RESOLVES_AT_PIN","NO_SWEEP"] fun name => do
  line (join ["  ",padRight 16 name," ",n (countVerdict rows name)])
 line ""
 if full then
  each rows fun row => do
   let extra := match row.result.family with
    | none => ""
    | some f => join [" family=",familyName f," pin=",(row.result.pin.map number).getD "None"," distinct_beyond=",n row.result.distinctBeyond]
   line (join ["  ",padRight 9 row.tag," ",padRight 16 (verdictName row.result.verdict),extra])
 else
  line "  results whose construction CARRIES FURTHER (math goes past where the claim stopped):"
  each rows fun row => do
   match row.result.verdict with
   | .noSweep => pure ()
   | .resolvesAtPin => pure ()
   | .carriesFurther =>
    line (join ["    ",padRight 9 row.tag," family=",padRight 14 ((row.result.family.map familyName).getD "None")," pinned~",(row.result.pin.map number).getD "None","  distinct structures beyond pin: ",n row.result.distinctBeyond])
  line "  (run with --full for every result's verdict)"
 line "\n=== AXIS 1 — per-expression resolution ==="
 let tally := axis1 40
 let total := tally.returnsOne+tally.fixed+tally.cycle+tally.unresolved
 each [("RETURNS_ONE",tally.returnsOne),("FIXED",tally.fixed),("CYCLE",tally.cycle),("UNRESOLVED",tally.unresolved)] fun (name,count) => do
  line (join ["  ",padRight 12 name," ",padLeft 7 (n count)," of ",n total])
 line "\n=== AXIS 2 — generated structure across increasing sweeps (placements) ==="
 let (_,growing) ← foldIO [30,60,120,240] ((none,true) : Option Nat × Bool) fun (previous,growing) sweep => do
  let placements := placementsTo sweep
  let grows := match previous with | none => true | some old => decide (placements > old)
  line (join ["  sweep 2..",padLeft 3 (n sweep),": ",n placements," placements"])
  pure (some placements,growing && grows)
 line (append "  -> keeps growing without settling: " (yesNo growing))

def reportClosed (a : Analysis) : IO Unit := do
 line "=== CLOSED SET (Axis 2) — enumerated, marked corpus vs unclaimed ==="
 line (join ["  closed-set size: ",n a.closed.length,"   corpus-named: ",n a.claimed.length,"   unclaimed: ",n a.unclaimed.length])
 line (join ["\n  CORPUS-CORRESPONDING members (",n a.claimed.length,"):"])
 line (append "   " (fractionList a.claimed))
 line (join ["\n  UNCLAIMED members (",n a.unclaimed.length,") — real fold structure not yet named:"])
 let current ← foldIO a.unclaimed "   " fun current x => do
  let word := append (fractionText x) " "
  if (chars current).length+(chars word).length > 100 then
   line current
   pure (append "   " word)
  else pure (append current word)
 if !(chars current).all whitespace then line current

def reportProvenance (a : Analysis) : IO Unit := do
 line (join ["=== PROVENANCE + RELATION-TO-CLAIMED for ",n a.unclaimed.length," unclaimed members ===\n"])
 each a.unclaimed fun x => do
  let info := provenance x
  let rels := if Explorer.contains a.named info.antipode then [append "antipode of claimed " (fractionText info.antipode)] else []
  let rels := if Explorer.contains a.named info.foldImage2 then rels++[append "folds (m2) to claimed " (fractionText info.foldImage2)] else rels
  let rels := if Explorer.contains a.named info.foldImage3 then rels++[append "folds (m3) to claimed " (fractionText info.foldImage3)] else rels
  let orbit := orbitOf x 2
  let shared := a.claimed.filter (fun c => Explorer.contains orbit c && !(equal c x))
  let rels := if shared.isEmpty then rels else rels++[append "same binary-orbit as claimed " (intercalate "," (shared.map fractionText))]
  let relation := if rels.isEmpty then "no direct relation to a claimed member" else intercalate "; " rels
  let sectors := if info.sectors.isEmpty then "—" else integerList info.sectors
  line (join ["  ",fractionText x,": sectors=",sectors," antipode=",fractionText info.antipode," m2->",fractionText info.foldImage2," orbit_len(m2)=",n info.orbitLength2])
  line (append "        relation: " relation)

def reportGroups (a : Analysis) : IO Unit := do
 line (join ["=== GROUPS (2) — ",n a.unclaimed.length," unclaimed members in ",n a.groups.length," fold-orbit groups ===\n"])
 each (a.groups.take 40).zipIdx fun (g,i) => do
  let anchors := a.claimed.filter (fun x => Explorer.contains g.key x)
  let suffix := if anchors.isEmpty then " (no claimed anchor)" else append " anchored-to-claimed: " (intercalate "," (anchors.map fractionText))
  let members := g.members.map (fun x => join [fractionText x,"[count=",((foldCount x).map number).getD "None","]"])
  line (join ["  group ",n (i+1)," (size ",n g.members.length,")",suffix])
  line (append "    " (intercalate ", " members))

def reportUnaccounted (a : Analysis) : IO Unit := do
 line (join ["=== UNACCOUNTED — ",n a.unanchored.length," fold-groups with NO claimed anchor ===\n"])
 each a.unanchored.zipIdx fun (g,i) => do
  let confines := g.members.all (fun x => if x.numerator < x.denominator then equal (add x (subtract (fraction 1 1) x)) (fraction 1 1) else true)
  let pairs := g.members.foldl (fun count x => if 2*x.numerator < x.denominator ∧ Explorer.contains g.members (subtract (fraction 1 1) x) then count+1 else count) 0
  let counts := g.members.filterMap foldCount
  let unique := counts.foldl (fun out x => if out.any (fun y => decide (x = y)) then out else out++[x]) []
  line (join ["  unaccounted group ",n (i+1),": size ",n g.members.length,"  fold-count(sector)=",integerList (sortInts unique),"  confines=",yesNo confines,"  antipodal-pairs-in-group=",n pairs])
  line (append "    members: " (fractionList g.members))

def reportProve (a : Analysis) : IO Unit := do
 line (join ["=== AUTO-PROOF — ",n a.unanchored.length," unaccounted groups run through the corpus's tests ==="])
 line "  grp size sector  T1  T2  T3  T4  T5 pairs  PROVES"
 let proven ← foldIO a.unanchored.zipIdx 0 fun proven (g,i) => do
  let result := runGroupProof g.members
  line (join ["  ",padLeft 3 (n (i+1))," ",padLeft 4 (n g.members.length)," ",padLeft 6 ((result.sector.map number).getD "None")," ",padLeft 3 (checkText (some result.t1Confines))," ",padLeft 3 (checkText (some result.t2Closed))," ",padLeft 3 (checkText (some result.t3Resolves))," ",padLeft 3 (checkText (some result.t4SingleSector))," ",padLeft 3 (checkText result.t5PairLaw)," ",padLeft 5 (n result.pairs)," ",padLeft 7 (checkText (some result.proves))])
  pure (if result.proves then proven+1 else proven)
 line (join ["\n  groups passing T1-T4 (prove as confining sector structures): ",n proven," of ",n a.unanchored.length])
end SFT.Applications.Discovery.Reports
