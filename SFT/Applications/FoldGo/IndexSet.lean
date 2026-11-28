namespace SFT.Applications.FoldGo

-- Source-runtime representation used only to preserve list(set(...)) order
-- for the original non-negative board indices. CPython 3.9 setobject.c:
-- LINEAR_PROBES=9, PERTURB_SHIFT=5, initial table8, growth at fill*5>=mask*3.
structure IndexSet where
 table : Array (Option Nat) := (List.replicate 8 none).toArray
 used : Nat := 0

def indexHash (key : Nat) : Nat := key%2305843009213693951

def indexSlot (table : Array (Option Nat)) (key : Nat) : Nat → Nat → Nat → Option Nat
 | 0, _, _ => none
 | fuel+1, i, perturb =>
  let width := if i+9 ≤ table.size-1 then 10 else 1
  let found := (List.range width).find? fun j =>
   match table.getD (i+j) none with
   | none => true
   | some old => decide (old = key)
  match found with
  | some j => some (i+j)
  | none =>
   let perturb := perturb/32
   indexSlot table key fuel ((i*5+1+perturb)%table.size) perturb

def indexPlace (table : Array (Option Nat)) (key : Nat) : Array (Option Nat) :=
 let hash := indexHash key
 match indexSlot table key (hash+table.size+1) (hash%table.size) hash with
 | some slot => table.setIfInBounds slot (some key)
 | none => table

def indexTableSize : Nat → Nat → Nat → Nat
 | 0, _, size => size
 | fuel+1, minimum, size =>
  if size ≤ minimum then indexTableSize fuel minimum (size*2) else size

def indexAdd (set : IndexSet) (key : Nat) : IndexSet :=
 let hash := indexHash key
 match indexSlot set.table key (hash+set.table.size+1) (hash%set.table.size) hash with
 | none => set
 | some slot =>
  match set.table.getD slot none with
  | some _ => set
  | none =>
   let table := set.table.setIfInBounds slot (some key)
   let used := set.used+1
   if used*5 < (table.size-1)*3 then {table,used}
   else
    let minimum := if used > 50000 then used*2 else used*4
    let size := indexTableSize (minimum+1) minimum 8
    let resized := table.toList.foldl (fun t entry => match entry with
      | none => t
      | some k => indexPlace t k) ((List.replicate size none).toArray)
    {table := resized,used}

def indexValues (set : IndexSet) : List Nat := set.table.toList.filterMap id

def indexFromList (xs : List Nat) : IndexSet := xs.foldl indexAdd {}
end SFT.Applications.FoldGo
