import SFT.Mathematics.ProbabilityEvents
open SFT.Mathematics.ProbabilityEvents

def weightText : Except String Weight → String
  | .error message => message
  | .ok value => match value with
    | .inl _ => "empty-One"
    | .inr f => s!"{f.numerator}/{f.denominator}"

#eval do
  let support := ["aa","ab","ba","bb"]
  let cases : List (Except String Weight × String) := [
    (exactWeight support ["aa","ab"], "1/2"),
    (exactWeight support [], "empty-One"),
    (exactWeight ["a"] ["a"], "1/1"),
    (exactWeight ["a","b","c"] ["c","a"], "2/3"),
    (exactWeight ["empty-One","a"] ["empty-One"], "empty-One"),
    (exactWeight ["a","a"] [], "support must be a complete nonempty canonical trace"),
    (exactWeight ["a"] ["a","a"], "event must be a duplicate-free held support selection"),
    (exactWeight ["a"] ["outside"], "event must be a duplicate-free held support selection"),
    (conditionalWeight support ["aa","ba"] ["aa","ab"], "1/2"),
    (conditionalWeight support ["aa"] [], "empty-One"),
    (conditionalWeight support ["aa"] ["bb"], "empty-One"),
    (conditionalWeight ["empty-One","a"] ["empty-One"] ["empty-One","a"], "1/2"),
    (conditionalWeight ["empty-One","a"] ["empty-One","a"] ["empty-One"], "empty-One"),
    (conditionalWeight ["a"] ["outside"] [], "event must be a duplicate-free held support selection")]
  for (actual, expected) in cases do
    if weightText actual != expected then throw (IO.userError "exact probability source case failed")
  match exactEvent ["a","b","c"] ["c","a"] with
    | .error _ => throw (IO.userError "event order test rejected")
    | .ok held => if held != ["c","a"] then throw (IO.userError "event order changed")
  IO.println s!"PASS: {cases.length + 1} exact event/weight/conditioning cases"
