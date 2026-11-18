import SFT.Chemistry.BondDissociationEnergy
import SFT.Host.Canonical
open SFT.Host.Canonical SFT.Chemistry.BondDissociationEnergy SFT.Physics.LeptonIntervals SFT.Foundation.ExactOperations
def encode : Except String PositiveFraction → Value
 | .error error => .array [.text "error",.text error]
 | .ok value => .array [.text "ok",.integer (Int.ofNat value.numerator),.integer (Int.ofNat value.denominator)]
def main : IO Unit := IO.println (render (.array [
encode (groundDissociationFromTransition (.fraction (normalize (9) 8 (by decide))) (.fraction (normalize (3) 4 (by decide)))),
encode (groundDissociationFromTransition (.fraction (normalize (17) 16 (by decide))) (.fraction (normalize (3) 4 (by decide)))),
encode (groundDissociationFromTransition (.fraction (normalize (3) 4 (by decide))) (.fraction (normalize (9) 8 (by decide)))),
encode (groundDissociationFromTransition (.fraction (normalize (3) 4 (by decide))) (.fraction (normalize (3) 4 (by decide)))),
encode (groundDissociationFromTransition (.fraction (normalize (0) 1 (by decide))) (.fraction (normalize (1) 1 (by decide)))),
encode (groundDissociationFromTransition (.fraction (normalize (-1) 1 (by decide))) (.fraction (normalize (1) 1 (by decide)))),
encode (groundDissociationFromTransition (.fraction (normalize (1) 1 (by decide))) (.fraction (normalize (0) 1 (by decide)))),
encode (groundDissociationFromTransition (.fraction (normalize (1) 1 (by decide))) (.fraction (normalize (-1) 1 (by decide)))),
encode (groundDissociationFromTransition .nonFraction (.fraction (normalize (1) 2 (by decide)))),
encode (groundDissociationFromTransition (.fraction (normalize (2) 1 (by decide))) .nonFraction),
encode (groundDissociationFromTransition .nonFraction (.fraction (normalize (1) 2 (by decide)))),
encode (groundDissociationFromTransition .nonFraction (.fraction (normalize (1) 2 (by decide)))),
encode (groundDissociationFromTransition (.fraction (normalize (2) 1 (by decide))) .nonFraction),
encode (groundDissociationFromTransition (.fraction (normalize (2) 1 (by decide))) (.fraction (normalize (1) 3 (by decide)))),
encode (groundDissociationFromTransition (.fraction (normalize (5) 3 (by decide))) (.fraction (normalize (1) 4 (by decide)))),
encode (groundDissociationFromTransition (.fraction (normalize (3) 2 (by decide))) (.fraction (normalize (1) 5 (by decide)))),
encode (groundDissociationFromTransition (.fraction (normalize (7) 5 (by decide))) (.fraction (normalize (1) 6 (by decide)))),
encode (groundDissociationFromTransition (.fraction (normalize (4) 3 (by decide))) (.fraction (normalize (1) 7 (by decide)))),
encode (groundDissociationFromTransition (.fraction (normalize (9) 7 (by decide))) (.fraction (normalize (1) 8 (by decide)))),
encode (groundDissociationFromTransition (.fraction (normalize (5) 4 (by decide))) (.fraction (normalize (1) 9 (by decide)))),
encode (groundDissociationFromTransition (.fraction (normalize (11) 9 (by decide))) (.fraction (normalize (1) 10 (by decide)))),
encode (groundDissociationFromTransition (.fraction (normalize (6) 5 (by decide))) (.fraction (normalize (1) 11 (by decide)))),
encode (groundDissociationFromTransition (.fraction (normalize (13) 11 (by decide))) (.fraction (normalize (1) 12 (by decide)))),
encode (groundDissociationFromTransition (.fraction (normalize (7) 6 (by decide))) (.fraction (normalize (1) 13 (by decide)))),
encode (groundDissociationFromTransition (.fraction (normalize (15) 13 (by decide))) (.fraction (normalize (1) 14 (by decide))))]))
