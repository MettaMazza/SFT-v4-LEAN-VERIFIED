import SFT.Physics.LeptonInvariants
open SFT.Physics.LeptonTake SFT.Physics.LeptonInvariants
set_option maxRecDepth 20000

def input : Nat → Rat
 | 0 => (⟨.negSucc 1,1,by decide,by decide⟩ : Rat)
 | 1 => (⟨.negSucc 0,1,by decide,by decide⟩ : Rat)
 | 2 => (⟨.negSucc 1,3,by decide,by decide⟩ : Rat)
 | 3 => (⟨.negSucc 0,1,by decide,by decide⟩ : Rat)
 | 4 => (⟨.negSucc 0,2,by decide,by decide⟩ : Rat)
 | 5 => (⟨.negSucc 0,3,by decide,by decide⟩ : Rat)
 | 6 => (⟨.ofNat 0,1,by decide,by decide⟩ : Rat)
 | 7 => (⟨.ofNat 0,1,by decide,by decide⟩ : Rat)
 | 8 => (⟨.ofNat 0,1,by decide,by decide⟩ : Rat)
 | 9 => (⟨.ofNat 1,1,by decide,by decide⟩ : Rat)
 | 10 => (⟨.ofNat 1,2,by decide,by decide⟩ : Rat)
 | 11 => (⟨.ofNat 1,3,by decide,by decide⟩ : Rat)
 | 12 => (⟨.ofNat 2,1,by decide,by decide⟩ : Rat)
 | 13 => (⟨.ofNat 1,1,by decide,by decide⟩ : Rat)
 | 14 => (⟨.ofNat 2,3,by decide,by decide⟩ : Rat)
 | 15 => (⟨.ofNat 3,1,by decide,by decide⟩ : Rat)
 | 16 => (⟨.ofNat 3,2,by decide,by decide⟩ : Rat)
 | 17 => (⟨.ofNat 1,1,by decide,by decide⟩ : Rat)
 | 18 => (⟨.ofNat 4,1,by decide,by decide⟩ : Rat)
 | 19 => (⟨.ofNat 2,1,by decide,by decide⟩ : Rat)
 | 20 => (⟨.ofNat 4,3,by decide,by decide⟩ : Rat)
 | 21 => (⟨.ofNat 5,1,by decide,by decide⟩ : Rat)
 | 22 => (⟨.ofNat 5,2,by decide,by decide⟩ : Rat)
 | 23 => (⟨.ofNat 5,3,by decide,by decide⟩ : Rat)
 | 24 => (⟨.ofNat 6,1,by decide,by decide⟩ : Rat)
 | 25 => (⟨.ofNat 3,1,by decide,by decide⟩ : Rat)
 | 26 => (⟨.ofNat 2,1,by decide,by decide⟩ : Rat)
 | _ => ⟨.ofNat 0,1,by decide,by decide⟩
def takeCases : List (Nat × List (Nat × Option (Nat × Nat))) := [
(0,[(0,none),(1,none),(2,none),(3,none),(4,none),(5,none),(6,none),(7,none),(8,none),(9,none),(10,none),(11,none),(12,none),(13,none),(14,none),(15,none),(16,none),(17,none),(18,none),(19,none),(20,none),(21,none),(22,none),(23,none),(24,none),(25,none),(26,none)]),
(1,[(0,none),(1,none),(2,none),(3,none),(4,none),(5,none),(6,none),(7,none),(8,none),(9,none),(10,none),(11,none),(12,none),(13,none),(14,none),(15,none),(16,none),(17,none),(18,none),(19,none),(20,none),(21,none),(22,none),(23,none),(24,none),(25,none),(26,none)]),
(2,[(0,none),(1,none),(2,none),(3,none),(4,none),(5,none),(6,none),(7,none),(8,none),(9,none),(10,none),(11,none),(12,none),(13,none),(14,none),(15,none),(16,none),(17,none),(18,none),(19,none),(20,none),(21,none),(22,none),(23,none),(24,none),(25,none),(26,none)]),
(3,[(0,none),(1,none),(2,none),(3,none),(4,none),(5,none),(6,none),(7,none),(8,none),(9,none),(10,none),(11,none),(12,none),(13,none),(14,none),(15,none),(16,none),(17,none),(18,none),(19,none),(20,none),(21,none),(22,none),(23,none),(24,none),(25,none),(26,none)]),
(4,[(0,none),(1,none),(2,none),(3,none),(4,none),(5,none),(6,none),(7,none),(8,none),(9,none),(10,none),(11,none),(12,none),(13,none),(14,none),(15,none),(16,none),(17,none),(18,none),(19,none),(20,none),(21,none),(22,none),(23,none),(24,none),(25,none),(26,none)]),
(5,[(0,none),(1,none),(2,none),(3,none),(4,none),(5,none),(6,none),(7,none),(8,none),(9,none),(10,none),(11,none),(12,none),(13,none),(14,none),(15,none),(16,none),(17,none),(18,none),(19,none),(20,none),(21,none),(22,none),(23,none),(24,none),(25,none),(26,none)]),
(6,[(0,none),(1,none),(2,none),(3,none),(4,none),(5,none),(6,none),(7,none),(8,none),(9,none),(10,none),(11,none),(12,none),(13,none),(14,none),(15,none),(16,none),(17,none),(18,none),(19,none),(20,none),(21,none),(22,none),(23,none),(24,none),(25,none),(26,none)]),
(7,[(0,none),(1,none),(2,none),(3,none),(4,none),(5,none),(6,none),(7,none),(8,none),(9,none),(10,none),(11,none),(12,none),(13,none),(14,none),(15,none),(16,none),(17,none),(18,none),(19,none),(20,none),(21,none),(22,none),(23,none),(24,none),(25,none),(26,none)]),
(8,[(0,none),(1,none),(2,none),(3,none),(4,none),(5,none),(6,none),(7,none),(8,none),(9,none),(10,none),(11,none),(12,none),(13,none),(14,none),(15,none),(16,none),(17,none),(18,none),(19,none),(20,none),(21,none),(22,none),(23,none),(24,none),(25,none),(26,none)]),
(9,[(0,none),(1,none),(2,none),(3,none),(4,none),(5,none),(6,none),(7,none),(8,none),(9,none),(10,some (1,2)),(11,some (2,3)),(12,none),(13,none),(14,some (1,3)),(15,none),(16,none),(17,none),(18,none),(19,none),(20,none),(21,none),(22,none),(23,none),(24,none),(25,none),(26,none)]),
(10,[(0,none),(1,none),(2,none),(3,none),(4,none),(5,none),(6,none),(7,none),(8,none),(9,none),(10,none),(11,some (1,6)),(12,none),(13,none),(14,none),(15,none),(16,none),(17,none),(18,none),(19,none),(20,none),(21,none),(22,none),(23,none),(24,none),(25,none),(26,none)]),
(11,[(0,none),(1,none),(2,none),(3,none),(4,none),(5,none),(6,none),(7,none),(8,none),(9,none),(10,none),(11,none),(12,none),(13,none),(14,none),(15,none),(16,none),(17,none),(18,none),(19,none),(20,none),(21,none),(22,none),(23,none),(24,none),(25,none),(26,none)]),
(12,[(0,none),(1,none),(2,none),(3,none),(4,none),(5,none),(6,none),(7,none),(8,none),(9,some (1,1)),(10,some (3,2)),(11,some (5,3)),(12,none),(13,some (1,1)),(14,some (4,3)),(15,none),(16,some (1,2)),(17,some (1,1)),(18,none),(19,none),(20,some (2,3)),(21,none),(22,none),(23,some (1,3)),(24,none),(25,none),(26,none)]),
(13,[(0,none),(1,none),(2,none),(3,none),(4,none),(5,none),(6,none),(7,none),(8,none),(9,none),(10,some (1,2)),(11,some (2,3)),(12,none),(13,none),(14,some (1,3)),(15,none),(16,none),(17,none),(18,none),(19,none),(20,none),(21,none),(22,none),(23,none),(24,none),(25,none),(26,none)]),
(14,[(0,none),(1,none),(2,none),(3,none),(4,none),(5,none),(6,none),(7,none),(8,none),(9,none),(10,some (1,6)),(11,some (1,3)),(12,none),(13,none),(14,none),(15,none),(16,none),(17,none),(18,none),(19,none),(20,none),(21,none),(22,none),(23,none),(24,none),(25,none),(26,none)]),
(15,[(0,none),(1,none),(2,none),(3,none),(4,none),(5,none),(6,none),(7,none),(8,none),(9,some (2,1)),(10,some (5,2)),(11,some (8,3)),(12,some (1,1)),(13,some (2,1)),(14,some (7,3)),(15,none),(16,some (3,2)),(17,some (2,1)),(18,none),(19,some (1,1)),(20,some (5,3)),(21,none),(22,some (1,2)),(23,some (4,3)),(24,none),(25,none),(26,some (1,1))]),
(16,[(0,none),(1,none),(2,none),(3,none),(4,none),(5,none),(6,none),(7,none),(8,none),(9,some (1,2)),(10,some (1,1)),(11,some (7,6)),(12,none),(13,some (1,2)),(14,some (5,6)),(15,none),(16,none),(17,some (1,2)),(18,none),(19,none),(20,some (1,6)),(21,none),(22,none),(23,none),(24,none),(25,none),(26,none)]),
(17,[(0,none),(1,none),(2,none),(3,none),(4,none),(5,none),(6,none),(7,none),(8,none),(9,none),(10,some (1,2)),(11,some (2,3)),(12,none),(13,none),(14,some (1,3)),(15,none),(16,none),(17,none),(18,none),(19,none),(20,none),(21,none),(22,none),(23,none),(24,none),(25,none),(26,none)]),
(18,[(0,none),(1,none),(2,none),(3,none),(4,none),(5,none),(6,none),(7,none),(8,none),(9,some (3,1)),(10,some (7,2)),(11,some (11,3)),(12,some (2,1)),(13,some (3,1)),(14,some (10,3)),(15,some (1,1)),(16,some (5,2)),(17,some (3,1)),(18,none),(19,some (2,1)),(20,some (8,3)),(21,none),(22,some (3,2)),(23,some (7,3)),(24,none),(25,some (1,1)),(26,some (2,1))]),
(19,[(0,none),(1,none),(2,none),(3,none),(4,none),(5,none),(6,none),(7,none),(8,none),(9,some (1,1)),(10,some (3,2)),(11,some (5,3)),(12,none),(13,some (1,1)),(14,some (4,3)),(15,none),(16,some (1,2)),(17,some (1,1)),(18,none),(19,none),(20,some (2,3)),(21,none),(22,none),(23,some (1,3)),(24,none),(25,none),(26,none)]),
(20,[(0,none),(1,none),(2,none),(3,none),(4,none),(5,none),(6,none),(7,none),(8,none),(9,some (1,3)),(10,some (5,6)),(11,some (1,1)),(12,none),(13,some (1,3)),(14,some (2,3)),(15,none),(16,none),(17,some (1,3)),(18,none),(19,none),(20,none),(21,none),(22,none),(23,none),(24,none),(25,none),(26,none)]),
(21,[(0,none),(1,none),(2,none),(3,none),(4,none),(5,none),(6,none),(7,none),(8,none),(9,some (4,1)),(10,some (9,2)),(11,some (14,3)),(12,some (3,1)),(13,some (4,1)),(14,some (13,3)),(15,some (2,1)),(16,some (7,2)),(17,some (4,1)),(18,some (1,1)),(19,some (3,1)),(20,some (11,3)),(21,none),(22,some (5,2)),(23,some (10,3)),(24,none),(25,some (2,1)),(26,some (3,1))]),
(22,[(0,none),(1,none),(2,none),(3,none),(4,none),(5,none),(6,none),(7,none),(8,none),(9,some (3,2)),(10,some (2,1)),(11,some (13,6)),(12,some (1,2)),(13,some (3,2)),(14,some (11,6)),(15,none),(16,some (1,1)),(17,some (3,2)),(18,none),(19,some (1,2)),(20,some (7,6)),(21,none),(22,none),(23,some (5,6)),(24,none),(25,none),(26,some (1,2))]),
(23,[(0,none),(1,none),(2,none),(3,none),(4,none),(5,none),(6,none),(7,none),(8,none),(9,some (2,3)),(10,some (7,6)),(11,some (4,3)),(12,none),(13,some (2,3)),(14,some (1,1)),(15,none),(16,some (1,6)),(17,some (2,3)),(18,none),(19,none),(20,some (1,3)),(21,none),(22,none),(23,none),(24,none),(25,none),(26,none)]),
(24,[(0,none),(1,none),(2,none),(3,none),(4,none),(5,none),(6,none),(7,none),(8,none),(9,some (5,1)),(10,some (11,2)),(11,some (17,3)),(12,some (4,1)),(13,some (5,1)),(14,some (16,3)),(15,some (3,1)),(16,some (9,2)),(17,some (5,1)),(18,some (2,1)),(19,some (4,1)),(20,some (14,3)),(21,some (1,1)),(22,some (7,2)),(23,some (13,3)),(24,none),(25,some (3,1)),(26,some (4,1))]),
(25,[(0,none),(1,none),(2,none),(3,none),(4,none),(5,none),(6,none),(7,none),(8,none),(9,some (2,1)),(10,some (5,2)),(11,some (8,3)),(12,some (1,1)),(13,some (2,1)),(14,some (7,3)),(15,none),(16,some (3,2)),(17,some (2,1)),(18,none),(19,some (1,1)),(20,some (5,3)),(21,none),(22,some (1,2)),(23,some (4,3)),(24,none),(25,none),(26,some (1,1))]),
(26,[(0,none),(1,none),(2,none),(3,none),(4,none),(5,none),(6,none),(7,none),(8,none),(9,some (1,1)),(10,some (3,2)),(11,some (5,3)),(12,none),(13,some (1,1)),(14,some (4,3)),(15,none),(16,some (1,2)),(17,some (1,1)),(18,none),(19,none),(20,some (2,3)),(21,none),(22,none),(23,some (1,3)),(24,none),(25,none),(26,none)])]
def main : IO Unit := do
 let mut count := 0
 for (i,row) in takeCases do
  for (j,expected) in row do
   let actual := (positiveTake (input i) (input j)).map pair
   let passed := match expected with
    | none => match actual with
      | .error e => e == "ValueError: positive take requires a smaller positive part"
      | .ok _ => false
    | some value => match actual with
      | .error _ => false
      | .ok result => result == value
   if !passed then throw (IO.userError s!"take {i} {j}")
   count := count + 1
 match sharpenedPair (.integer (-4)) with
 | .error e => if e != "ValueError: channel must be in the complete neighbouring generator census" then throw (IO.userError "channel error")
 | .ok _ => throw (IO.userError "channel -4")
 count := count + 1
 match sharpenedPair (.integer (-3)) with
 | .error e => if e != "ValueError: channel must be in the complete neighbouring generator census" then throw (IO.userError "channel error")
 | .ok _ => throw (IO.userError "channel -3")
 count := count + 1
 match sharpenedPair (.integer (-2)) with
 | .error e => if e != "ValueError: channel must be in the complete neighbouring generator census" then throw (IO.userError "channel error")
 | .ok _ => throw (IO.userError "channel -2")
 count := count + 1
 match sharpenedPair (.integer (-1)) with
 | .error e => if e != "ValueError: channel must be in the complete neighbouring generator census" then throw (IO.userError "channel error")
 | .ok _ => throw (IO.userError "channel -1")
 count := count + 1
 match sharpenedPair (.integer (0)) with
 | .error e => if e != "ValueError: channel must be in the complete neighbouring generator census" then throw (IO.userError "channel error")
 | .ok _ => throw (IO.userError "channel 0")
 count := count + 1
 match sharpenedPair (.integer (1)) with
 | .error e => if e != "ValueError: channel must be in the complete neighbouring generator census" then throw (IO.userError "channel error")
 | .ok _ => throw (IO.userError "channel 1")
 count := count + 1
 if (sharpenedPair (.integer (2))).toOption != some (2,969) then throw (IO.userError "channel 2")
 count := count + 1
 if (sharpenedPair (.integer (3))).toOption != some (3,1454) then throw (IO.userError "channel 3")
 count := count + 1
 if (sharpenedPair (.integer (4))).toOption != some (4,1939) then throw (IO.userError "channel 4")
 count := count + 1
 match sharpenedPair (.integer (5)) with
 | .error e => if e != "ValueError: channel must be in the complete neighbouring generator census" then throw (IO.userError "channel error")
 | .ok _ => throw (IO.userError "channel 5")
 count := count + 1
 match sharpenedPair (.integer (6)) with
 | .error e => if e != "ValueError: channel must be in the complete neighbouring generator census" then throw (IO.userError "channel error")
 | .ok _ => throw (IO.userError "channel 6")
 count := count + 1
 match sharpenedPair (.integer (7)) with
 | .error e => if e != "ValueError: channel must be in the complete neighbouring generator census" then throw (IO.userError "channel error")
 | .ok _ => throw (IO.userError "channel 7")
 count := count + 1
 match sharpenedPair (.integer (8)) with
 | .error e => if e != "ValueError: channel must be in the complete neighbouring generator census" then throw (IO.userError "channel error")
 | .ok _ => throw (IO.userError "channel 8")
 count := count + 1
 match sharpenedPair (.boolean false) with
 | .error e => if e != "ValueError: channel must be in the complete neighbouring generator census" then throw (IO.userError "boolean error")
 | .ok _ => throw (IO.userError "boolean")
 count := count + 1
 match sharpenedPair (.boolean true) with
 | .error e => if e != "ValueError: channel must be in the complete neighbouring generator census" then throw (IO.userError "boolean error")
 | .ok _ => throw (IO.userError "boolean")
 count := count + 1
 if count != 744 then throw (IO.userError "case count")
 IO.println "PASS 744 exact positive-take/channel outputs and original guards"
