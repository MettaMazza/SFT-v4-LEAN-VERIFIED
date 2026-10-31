import SFT.Host.Text
-- Shared source-identical custody declarations. No scientific definitions changed.
namespace SFT.Physics.LeptonDecimal
open SFT.Host
def spaceCodes : List Nat := [9, 10, 11, 12, 13, 28, 29, 30, 31, 32, 133, 160, 5760, 8192, 8193, 8194, 8195, 8196, 8197, 8198, 8199, 8200, 8201, 8202, 8232, 8233, 8239, 8287, 12288]

def trimCodes (codes : List Nat) (cs : List Char) : List Char :=
 ((cs.dropWhile (fun c => codes.contains c.toNat)).reverse.dropWhile (fun c => codes.contains c.toNat)).reverse

def strip (cs : List Char) : List Char := trimCodes spaceCodes cs
end SFT.Physics.LeptonDecimal
namespace SFT.Physics.LeptonPrediction
open SFT.Host
def nonblank (text : String) : Bool := !(LeptonDecimal.strip (Text.chars text)).isEmpty
end SFT.Physics.LeptonPrediction
namespace SFT.Physics.LeptonCustody
open SFT.Host
structure PredictionSeal where
 experiment : String
 predictionHash : String
 traceHash : String
 envelopeHash : String
 sealHash : String
end SFT.Physics.LeptonCustody
