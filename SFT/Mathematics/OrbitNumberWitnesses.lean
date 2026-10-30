import SFT.Mathematics.OrbitWitness3
import SFT.Mathematics.OrbitWitness5
import SFT.Mathematics.OrbitWitness7
import SFT.Mathematics.OrbitWitness9
import SFT.Mathematics.OrbitWitness11
import SFT.Mathematics.OrbitWitness13
import SFT.Mathematics.OrbitWitness15
import SFT.Mathematics.OrbitWitness17
import SFT.Mathematics.OrbitWitness19
import SFT.Mathematics.OrbitWitness21
import SFT.Mathematics.OrbitWitness23
import SFT.Mathematics.OrbitWitness25
import SFT.Mathematics.OrbitWitness27
import SFT.Mathematics.OrbitWitness29
import SFT.Mathematics.OrbitWitness31
import SFT.Mathematics.OrbitWitness33
import SFT.Mathematics.OrbitWitness35
import SFT.Mathematics.OrbitWitness37
import SFT.Mathematics.OrbitWitness39
import SFT.Mathematics.OrbitWitness41
import SFT.Mathematics.OrbitWitness43
import SFT.Mathematics.OrbitWitness45
import SFT.Mathematics.OrbitWitness47
import SFT.Mathematics.OrbitWitness49
import SFT.Mathematics.OrbitWitness51
import SFT.Mathematics.OrbitWitness53
import SFT.Mathematics.OrbitWitness55
import SFT.Mathematics.OrbitWitness57
import SFT.Mathematics.OrbitWitness59
import SFT.Mathematics.OrbitWitness61
import SFT.Mathematics.OrbitWitness63
import SFT.Mathematics.OrbitWitness65
import SFT.Mathematics.OrbitWitness67
import SFT.Mathematics.OrbitWitness69
import SFT.Mathematics.OrbitWitness71
import SFT.Mathematics.OrbitWitness73
import SFT.Mathematics.OrbitWitness75
import SFT.Mathematics.OrbitWitness77
import SFT.Mathematics.OrbitWitness79
import SFT.Mathematics.OrbitWitness81
import SFT.Mathematics.OrbitWitness83
import SFT.Mathematics.OrbitWitness85
import SFT.Mathematics.OrbitWitness87
import SFT.Mathematics.OrbitWitness89
import SFT.Mathematics.OrbitWitness91
import SFT.Mathematics.OrbitWitness93
import SFT.Mathematics.OrbitWitness95
import SFT.Mathematics.OrbitWitness97
import SFT.Mathematics.OrbitWitness99
namespace SFT.Mathematics.OrbitNumberWitnesses
set_option maxRecDepth 100000
set_option maxHeartbeats 20000000
theorem originalOrders : orderExamples = true := rfl
theorem allFromMembers {α : Type} (xs : List α) (p : α → Bool)
 (each : ∀ x, x ∈ xs → p x = true) : xs.all p = true := by
 induction xs with
 | nil => rfl
 | cons head tail ih =>
   have first := each head (List.Mem.head _)
   have rest := ih (fun x hx => each x (List.Mem.tail head hx))
   change (p head && tail.all p) = true
   rw [first,rest]
   rfl

theorem originalAllReducedRanks : allReducedRanks = true := by
 exact allFromMembers (List.range 49) (fun i => reducedRanksAt (2*i+3)) (by
  intro i held
  change i ∈ [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48] at held
  cases held with
  | head => exact ranks3
  | tail _ held =>
    cases held with
    | head => exact ranks5
    | tail _ held =>
      cases held with
      | head => exact ranks7
      | tail _ held =>
        cases held with
        | head => exact ranks9
        | tail _ held =>
          cases held with
          | head => exact ranks11
          | tail _ held =>
            cases held with
            | head => exact ranks13
            | tail _ held =>
              cases held with
              | head => exact ranks15
              | tail _ held =>
                cases held with
                | head => exact ranks17
                | tail _ held =>
                  cases held with
                  | head => exact ranks19
                  | tail _ held =>
                    cases held with
                    | head => exact ranks21
                    | tail _ held =>
                      cases held with
                      | head => exact ranks23
                      | tail _ held =>
                        cases held with
                        | head => exact ranks25
                        | tail _ held =>
                          cases held with
                          | head => exact ranks27
                          | tail _ held =>
                            cases held with
                            | head => exact ranks29
                            | tail _ held =>
                              cases held with
                              | head => exact ranks31
                              | tail _ held =>
                                cases held with
                                | head => exact ranks33
                                | tail _ held =>
                                  cases held with
                                  | head => exact ranks35
                                  | tail _ held =>
                                    cases held with
                                    | head => exact ranks37
                                    | tail _ held =>
                                      cases held with
                                      | head => exact ranks39
                                      | tail _ held =>
                                        cases held with
                                        | head => exact ranks41
                                        | tail _ held =>
                                          cases held with
                                          | head => exact ranks43
                                          | tail _ held =>
                                            cases held with
                                            | head => exact ranks45
                                            | tail _ held =>
                                              cases held with
                                              | head => exact ranks47
                                              | tail _ held =>
                                                cases held with
                                                | head => exact ranks49
                                                | tail _ held =>
                                                  cases held with
                                                  | head => exact ranks51
                                                  | tail _ held =>
                                                    cases held with
                                                    | head => exact ranks53
                                                    | tail _ held =>
                                                      cases held with
                                                      | head => exact ranks55
                                                      | tail _ held =>
                                                        cases held with
                                                        | head => exact ranks57
                                                        | tail _ held =>
                                                          cases held with
                                                          | head => exact ranks59
                                                          | tail _ held =>
                                                            cases held with
                                                            | head => exact ranks61
                                                            | tail _ held =>
                                                              cases held with
                                                              | head => exact ranks63
                                                              | tail _ held =>
                                                                cases held with
                                                                | head => exact ranks65
                                                                | tail _ held =>
                                                                  cases held with
                                                                  | head => exact ranks67
                                                                  | tail _ held =>
                                                                    cases held with
                                                                    | head => exact ranks69
                                                                    | tail _ held =>
                                                                      cases held with
                                                                      | head => exact ranks71
                                                                      | tail _ held =>
                                                                        cases held with
                                                                        | head => exact ranks73
                                                                        | tail _ held =>
                                                                          cases held with
                                                                          | head => exact ranks75
                                                                          | tail _ held =>
                                                                            cases held with
                                                                            | head => exact ranks77
                                                                            | tail _ held =>
                                                                              cases held with
                                                                              | head => exact ranks79
                                                                              | tail _ held =>
                                                                                cases held with
                                                                                | head => exact ranks81
                                                                                | tail _ held =>
                                                                                  cases held with
                                                                                  | head => exact ranks83
                                                                                  | tail _ held =>
                                                                                    cases held with
                                                                                    | head => exact ranks85
                                                                                    | tail _ held =>
                                                                                      cases held with
                                                                                      | head => exact ranks87
                                                                                      | tail _ held =>
                                                                                        cases held with
                                                                                        | head => exact ranks89
                                                                                        | tail _ held =>
                                                                                          cases held with
                                                                                          | head => exact ranks91
                                                                                          | tail _ held =>
                                                                                            cases held with
                                                                                            | head => exact ranks93
                                                                                            | tail _ held =>
                                                                                              cases held with
                                                                                              | head => exact ranks95
                                                                                              | tail _ held =>
                                                                                                cases held with
                                                                                                | head => exact ranks97
                                                                                                | tail _ held =>
                                                                                                  cases held with
                                                                                                  | head => exact ranks99
                                                                                                  | tail _ held =>
                                                                                                    cases held)

theorem originalPrimeDivision : primeDivision = true := rfl
theorem originalOrbitTiling : orbitTiling = true := rfl

end SFT.Mathematics.OrbitNumberWitnesses
