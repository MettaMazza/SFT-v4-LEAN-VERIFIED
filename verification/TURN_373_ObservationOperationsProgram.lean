import SFT.Physics.ObservationComparison
open SFT.Physics SFT.Host.Canonical
def resultValue (prediction : String) (released : List (String × Value)) : Value :=
 match ObservationComparison.compareRows prediction released ObservationExperiment.targetRows with
 | .error e => .object [("error",.text e)]
 | .ok rows => .object [("comparisons",.array (rows.map ObservationComparison.comparisonValue)),("tampered_control",ObservationComparison.controlValue prediction),("passed",.boolean (ObservationComparison.accepted prediction rows))]
def main : IO Unit := do
 IO.println (render ObservationExperiment.registration)
 IO.println (render (resultValue "distinction-reference-comparison-record" [("observation-carrier-1",.object [("family",.text "external-observation"),("label",.text "distinction-reference-comparison-record")]),("observation-carrier-2",.object [("family",.text "external-observation"),("label",.text "distinction-reference-comparison-record")])]))
 IO.println (render (resultValue "distinction-reference-comparison-record" [("observation-carrier-1",.object [("family",.text "external-observation"),("label",.text "distinction-reference-comparison-record")]),("observation-carrier-2",.object [("family",.text "external-observation"),("label",.text "changed-external-observation")])]))
 IO.println (render (resultValue "distinction-reference-comparison-record" [("observation-carrier-1",.object [("family",.text "external-observation"),("label",.text "distinction-reference-comparison-record")])]))
 IO.println (render (resultValue "changed-external-observation" [("observation-carrier-1",.object [("family",.text "external-observation"),("label",.text "distinction-reference-comparison-record")]),("observation-carrier-2",.object [("family",.text "external-observation"),("label",.text "distinction-reference-comparison-record")])]))
 IO.println (render (resultValue "changed-external-observation" [("observation-carrier-1",.object [("family",.text "external-observation"),("label",.text "distinction-reference-comparison-record")]),("observation-carrier-2",.object [("family",.text "external-observation"),("label",.text "changed-external-observation")])]))
 IO.println (render (resultValue "changed-external-observation" [("observation-carrier-1",.object [("family",.text "external-observation"),("label",.text "distinction-reference-comparison-record")])]))
 IO.println (render (resultValue "different" [("observation-carrier-1",.object [("family",.text "external-observation"),("label",.text "distinction-reference-comparison-record")]),("observation-carrier-2",.object [("family",.text "external-observation"),("label",.text "distinction-reference-comparison-record")])]))
 IO.println (render (resultValue "different" [("observation-carrier-1",.object [("family",.text "external-observation"),("label",.text "distinction-reference-comparison-record")]),("observation-carrier-2",.object [("family",.text "external-observation"),("label",.text "changed-external-observation")])]))
 IO.println (render (resultValue "different" [("observation-carrier-1",.object [("family",.text "external-observation"),("label",.text "distinction-reference-comparison-record")])]))
 IO.println (render (resultValue "λ" [("observation-carrier-1",.object [("family",.text "external-observation"),("label",.text "distinction-reference-comparison-record")]),("observation-carrier-2",.object [("family",.text "external-observation"),("label",.text "distinction-reference-comparison-record")])]))
 IO.println (render (resultValue "λ" [("observation-carrier-1",.object [("family",.text "external-observation"),("label",.text "distinction-reference-comparison-record")]),("observation-carrier-2",.object [("family",.text "external-observation"),("label",.text "changed-external-observation")])]))
 IO.println (render (resultValue "λ" [("observation-carrier-1",.object [("family",.text "external-observation"),("label",.text "distinction-reference-comparison-record")])]))
