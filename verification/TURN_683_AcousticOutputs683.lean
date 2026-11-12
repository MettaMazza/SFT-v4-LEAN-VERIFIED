import SFT.Materials.AcousticModes
open SFT.Materials.AcousticModes
#eval do
 match acousticBranchCensus with
 | .error message => IO.println message
 | .ok rows => for row in rows do
   IO.println (row.orientation ++ "\t" ++ row.generator)
