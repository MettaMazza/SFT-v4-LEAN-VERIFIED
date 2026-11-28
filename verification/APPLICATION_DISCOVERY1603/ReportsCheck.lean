import SFT.Applications.Discovery.Reports
open SFT.Applications.Discovery
open SFT.Applications.Discovery.Carry
open SFT.Applications.Discovery.Source
open SFT.Applications.Discovery.Display
open SFT.Applications.Discovery.Reports
open SFT.Host.Text

def require (name : String) (ok : Bool) : IO Unit :=
 bif ok then line (append "PASS " name) else throw (IO.userError (append "FAIL " name))
def main (args : List String) : IO Unit := do
 let corpus ← load (args.headD "work/turn1064_recovery/reference/applications/discovery-SFT-v2")
 let named := sortFractions (corpusNamedParts corpus)
 line (append "NAMED " (fractionList named))
 require "all 334 registered entries examined" (decide ((carryRows corpus).length = 334))
 require "standing family pin three carries 57 structures" (decide ((carryVerdict "fixed point three").distinctBeyond = 57))
 require "coupling pin five carries 55 structures" (decide ((carryVerdict "take(m, ONE) five").distinctBeyond = 55))
 require "family absent" (match (carryVerdict "three").verdict with | .noSweep => true | .carriesFurther => false | .resolvesAtPin => false)
 require "family without pin" (decide ((carryVerdict "coupling").distinctBeyond = 0))
 require "maximum word and chain pin" (decide (pinnedParam "three ONE + ONE + ONE + ONE" = some 4))
 require "word boundaries" (decide (pinnedParam "threesome two" = some 2))
 require "named ratios boundaries and zero denominator" (let cs := chars "x1/2 1/2x 3/0 2 / 4 5/6"; let xs := namedRatios cs.length cs false; decide (xs.length = 2) && Explorer.contains xs (fraction 1 2) && Explorer.contains xs (fraction 5 6))
