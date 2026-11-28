import SFT.Applications.Discovery.MaxCensus
import SFT.Applications.Discovery.Extended
namespace SFT.Applications.Discovery.MaxArtifacts
open SFT.Applications.Discovery
open SFT.Applications.Discovery.Explorer
open SFT.Applications.Discovery.Display
open SFT.Applications.Discovery.Reports
open SFT.Applications.Discovery.MaxCore
open SFT.Applications.Discovery.MaxCensus
open SFT.Applications.Discovery.Extended
open SFT.Host.Text

def censusMarkdown (a : Analysis) : String :=
 let rows := censusRows a.unclaimed
 let heading := ["# Unclaimed Structure Census\n",join ["Total closed set: ",n a.closed.length," | Named: ",n a.claimed.length," | Unclaimed: ",n a.unclaimed.length,"\n"],"| Denominator | Count | Sector(s) | Sample Members | Orbit Type |","|-------------|-------|-----------|----------------|------------|\n"]
 let body := rows.map fun row =>
  let sectors := if row.sectors.isEmpty then "?" else intercalate "," (row.sectors.map number)
  let orbit := row.orbitLength.map (fun k => join ["orbit(len=",n k,")"])
  let sample := fractionList (row.members.take 6)
  let sample := if row.members.length > 6 then join [sample," ... (+",n (row.members.length-6),")"] else sample
  join ["| ",number row.denominator," | ",n row.members.length," | ",sectors," | ",sample," | ",orbit.getD "standing"," |"]
 intercalate "\n" (heading++body++["\n## Summary\n",append "- Denominators represented: " (n rows.length),append "- Sectors found: " (n (sectorSummary rows).length)])

def sectorMarkdown : String :=
 let heading := ["# Sector Scan — Prime Fold Exploration\n","| Prime | Standing Modes | Coupling | Shortfall | Cumulative Shortfall | Span |","|-------|---------------|----------|-----------|---------------------|------|"]
 let body := sectorScan.map fun row =>
  let modes := fractionList (row.modes.take 8)
  let modes := if row.modes.length > 8 then join [modes," ... (",n row.modes.length," total)"] else modes
  join ["| ",number row.prime," | ",n row.modes.length," (",modes,") | ",fractionText row.coupling," | 1/",number row.prime," | ",fractionText row.cumulative," | ",fractionText row.span," |"]
 intercalate "\n" (heading++body++["\n## B-6N Bound Verification",append "- Ladder primes: " (integerList ladder),join ["- Total shortfall: ",fractionText ladderShortfall," (= 247/210: ",yesNo (Discovery.equal ladderShortfall (fraction 247 210)),")"],join ["- Span: ",fractionText ladderSpan," (= 210: ",yesNo (Discovery.equal ladderSpan (fraction 210 1)),")"]])

def crossMarkdown : String :=
 let body := crossIdentities.map fun row => join ["- **p=",number row.first," ∩ p=",number row.second,"**: ",n row.shared.length," shared — ",fractionList row.shared]
 intercalate "\n" (["# Cross-Sector Identity Mining\n"]++body++(if universalModes.isEmpty then [] else ["\n## Universal Modes (all odd primes)",append "- " (fractionList universalModes)]))

def extendedMarkdown (a : Analysis) : String :=
 let header := "  grp size sector  T1  T2  T3  T4  T5  T6  T7  T8  T9 T10 T11 T12 pairs  PROVES"
 let rows := a.unanchored.zipIdx.map fun (g,i) =>
  let r := runExtendedProof g.members a.claimed
  let flags := [some r.base.t1Confines,some r.base.t2Closed,some r.base.t3Resolves,some r.base.t4SingleSector,r.base.t5PairLaw,r.t6,r.t7,some r.t8,r.t9,r.t10,r.t11,r.t12]
  join ["  ",padLeft 3 (n (i+1))," ",padLeft 4 (n g.members.length)," ",padLeft 6 ((r.base.sector.map number).getD "None")," ",intercalate " " (flags.map (fun b => padLeft 3 (checkText b)))," ",padLeft 5 (n r.base.pairs)," ",padLeft 7 (checkText (some r.base.proves))]
 intercalate "\n" (["# Auto-Extend Report — T1-T12 Proof System\n",header]++rows)

def censusKind : Resolution → String
 | .returnsOne => "REACHES_ONE"
 | .fixed => "FIXED_POINT"
 | .cycle => "PERIODIC"
 | .unresolved => "UNRESOLVED"
def orbitCSV (limit : Nat := 120) : String :=
 let rows := (MaxCore.orbitCensus limit).map fun row => intercalate "," [fractionText row.value,n row.denominator,censusKind row.result.kind,n row.result.period,n row.result.transient]
 append (intercalate "\r\n" ("rational,denominator,classification,period,transient"::rows)) "\r\n"
def runningCSV (limit : Int := 56) : String :=
 let header := ["depth","tower_2d"]++ladder.flatMap (fun m => [append "coupling_m" (number m),append "gap_to_one_m" (number m)])++["EM_coupling"]
 let rows := (runningCurves limit).map fun row =>
  intercalate "," ([n row.depth,fractionText row.tower]++(row.couplings.zip row.gaps).flatMap (fun (c,g) => [fractionText c,fractionText g])++[fractionText row.em])
 append (intercalate "\r\n" (intercalate "," header::rows)) "\r\n"
end SFT.Applications.Discovery.MaxArtifacts
