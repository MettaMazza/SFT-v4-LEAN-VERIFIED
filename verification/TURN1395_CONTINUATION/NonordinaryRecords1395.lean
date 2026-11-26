import SFT.Consciousness.NonordinaryLaws
import SFT.Host.Canonical
open SFT.Consciousness.NonordinaryLaws SFT.Host.Canonical
private def fraction (p : SFT.Foundation.ExactPartCarrier.Part) : Value :=
 .object [("numerator",.integer (.ofNat p.numerator)),("denominator",.integer (.ofNat p.denominator))]
private def routes (xs : List (String × String)) : Value := .array (xs.map fun (a,b) => .array [.text a,.text b])
def main : IO Unit := do
 let s := directionalSynaesthesiaRecord
 let t := threeQualityOrbit
 let d := sleepDreamOrbit
 let c := cessationLockAnchor
 IO.println (render (.array [
 .object [("trigger",fraction s.trigger),("concurrent",fraction s.concurrent),("trigger_image",fraction s.triggerImage),
  ("concurrent_image",fraction s.concurrentImage),("joint",fraction s.joint),("directed_routes",routes s.directedRoutes),
  ("reverse_route_present",.boolean s.reverseRoutePresent),("stable_repeat",.array (s.stableRepeat.map routes))],
 .object [("trace",.array (t.trace.map fraction)),("next",fraction t.next),("partition",fraction t.partition),
  ("distinct",.integer (.ofNat t.distinct)),("generated_support",.array (t.generatedSupport.map fraction)),
  ("external_information_created",.boolean t.externalInformationCreated)],
 .object [("deep",fraction d.deep),("rem",fraction d.rem),("deep_image",fraction d.deepImage),
  ("rem_image",fraction d.remImage),("partition",fraction d.partition),("balance",fraction d.balance),
  ("waking_completion",fraction d.wakingCompletion),("physiological_labels_are_correspondence",.boolean d.physiologicalLabelsAreCorrespondence)],
 .object [("occupied_lock",fraction c.occupiedLock),("released_lock_label",.text c.releasedLockLabel),
  ("components",.array (c.components.map fraction)),("components_complete",fraction c.componentsComplete),
  ("anchor",fraction c.anchor),("lock_completes_to_anchor",fraction c.lockCompletesToAnchor),
  ("anchor_image",fraction c.anchorImage),("personal_organization_persists",.boolean c.personalOrganizationPersists),
  ("structural_absence_is_numeric_zero",.boolean c.structuralAbsenceIsNumericZero)]]))
