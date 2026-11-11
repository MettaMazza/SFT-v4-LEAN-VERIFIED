import SFT.Chemistry.SourceExtraction
namespace SFT.Chemistry.ExtendedExtraction
open SFT.Host SFT.Host.Canonical SourceExtraction
def nonprintingRanges : List (Nat × Nat) := [(0,31),(127,160),(173,173),(888,889),(896,899),(907,907),(909,909),(930,930),(1328,1328),(1367,1368),(1419,1420),(1424,1424),(1480,1487),(1515,1518),(1525,1541),(1564,1565),(1757,1757),(1806,1807),(1867,1868),(1970,1983),(2043,2044),(2094,2095),(2111,2111),(2140,2141),(2143,2143),(2155,2207),(2229,2229),(2248,2258),(2274,2274),(2436,2436),(2445,2446),(2449,2450),(2473,2473),(2481,2481),(2483,2485),(2490,2491),(2501,2502),(2505,2506),(2511,2518),(2520,2523),(2526,2526),(2532,2533),(2559,2560),(2564,2564),(2571,2574),(2577,2578),(2601,2601),(2609,2609),(2612,2612),(2615,2615),(2618,2619),(2621,2621),(2627,2630),(2633,2634),(2638,2640),(2642,2648),(2653,2653),(2655,2661),(2679,2688),(2692,2692),(2702,2702),(2706,2706),(2729,2729),(2737,2737),(2740,2740),(2746,2747),(2758,2758),(2762,2762),(2766,2767),(2769,2783),(2788,2789),(2802,2808),(2816,2816),(2820,2820),(2829,2830),(2833,2834),(2857,2857),(2865,2865),(2868,2868),(2874,2875),(2885,2886),(2889,2890),(2894,2900),(2904,2907),(2910,2910),(2916,2917),(2936,2945),(2948,2948),(2955,2957),(2961,2961),(2966,2968),(2971,2971),(2973,2973),(2976,2978),(2981,2983),(2987,2989),(3002,3005),(3011,3013),(3017,3017),(3022,3023),(3025,3030),(3032,3045),(3067,3071),(3085,3085),(3089,3089),(3113,3113),(3130,3132),(3141,3141),(3145,3145),(3150,3156),(3159,3159),(3163,3167),(3172,3173),(3184,3190),(3213,3213),(3217,3217),(3241,3241),(3252,3252),(3258,3259),(3269,3269),(3273,3273),(3278,3284),(3287,3293),(3295,3295),(3300,3301),(3312,3312),(3315,3327),(3341,3341),(3345,3345),(3397,3397),(3401,3401),(3408,3411),(3428,3429),(3456,3456),(3460,3460),(3479,3481),(3506,3506),(3516,3516),(3518,3519),(3527,3529),(3531,3534),(3541,3541),(3543,3543),(3552,3557),(3568,3569),(3573,3584),(3643,3646),(3676,3712),(3715,3715),(3717,3717),(3723,3723),(3748,3748),(3750,3750),(3774,3775),(3781,3781),(3783,3783),(3790,3791),(3802,3803),(3808,3839),(3912,3912),(3949,3952),(3992,3992),(4029,4029),(4045,4045),(4059,4095),(4294,4294),(4296,4300),(4302,4303),(4681,4681),(4686,4687),(4695,4695),(4697,4697),(4702,4703),(4745,4745),(4750,4751),(4785,4785),(4790,4791),(4799,4799),(4801,4801),(4806,4807),(4823,4823),(4881,4881),(4886,4887),(4955,4956),(4989,4991),(5018,5023),(5110,5111),(5118,5119),(5760,5760),(5789,5791),(5881,5887),(5901,5901),(5909,5919),(5943,5951),(5972,5983),(5997,5997),(6001,6001),(6004,6015),(6110,6111),(6122,6127),(6138,6143),(6158,6159),(6170,6175),(6265,6271),(6315,6319),(6390,6399),(6431,6431),(6444,6447),(6460,6463),(6465,6467),(6510,6511),(6517,6527),(6572,6575),(6602,6607),(6619,6621),(6684,6685),(6751,6751),(6781,6782),(6794,6799),(6810,6815),(6830,6831),(6849,6911),(6988,6991),(7037,7039),(7156,7163),(7224,7226),(7242,7244),(7305,7311),(7355,7356),(7368,7375),(7419,7423),(7674,7674),(7958,7959),(7966,7967),(8006,8007),(8014,8015),(8024,8024),(8026,8026),(8028,8028),(8030,8030),(8062,8063),(8117,8117),(8133,8133),(8148,8149),(8156,8156),(8176,8177),(8181,8181),(8191,8207),(8232,8239),(8287,8303),(8306,8307),(8335,8335),(8349,8351),(8384,8399),(8433,8447),(8588,8591),(9255,9279),(9291,9311),(11124,11125),(11158,11158),(11311,11311),(11359,11359),(11508,11512),(11558,11558),(11560,11564),(11566,11567),(11624,11630),(11633,11646),(11671,11679),(11687,11687),(11695,11695),(11703,11703),(11711,11711),(11719,11719),(11727,11727),(11735,11735),(11743,11743),(11859,11903),(11930,11930),(12020,12031),(12246,12271),(12284,12288),(12352,12352),(12439,12440),(12544,12548),(12592,12592),(12687,12687),(12772,12783),(12831,12831),(40957,40959),(42125,42127),(42183,42191),(42540,42559),(42744,42751),(42944,42945),(42955,42996),(43053,43055),(43066,43071),(43128,43135),(43206,43213),(43226,43231),(43348,43358),(43389,43391),(43470,43470),(43482,43485),(43519,43519),(43575,43583),(43598,43599),(43610,43611),(43715,43738),(43767,43776),(43783,43784),(43791,43792),(43799,43807),(43815,43815),(43823,43823),(43884,43887),(44014,44015),(44026,44031),(55204,55215),(55239,55242),(55292,63743),(64110,64111),(64218,64255),(64263,64274),(64280,64284),(64311,64311),(64317,64317),(64319,64319),(64322,64322),(64325,64325),(64450,64466),(64832,64847),(64912,64913),(64968,65007),(65022,65023),(65050,65055),(65107,65107),(65127,65127),(65132,65135),(65141,65141),(65277,65280),(65471,65473),(65480,65481),(65488,65489),(65496,65497),(65501,65503),(65511,65511),(65519,65531),(65534,65535),(65548,65548),(65575,65575),(65595,65595),(65598,65598),(65614,65615),(65630,65663),(65787,65791),(65795,65798),(65844,65846),(65935,65935),(65949,65951),(65953,65999),(66046,66175),(66205,66207),(66257,66271),(66300,66303),(66340,66348),(66379,66383),(66427,66431),(66462,66462),(66500,66503),(66518,66559),(66718,66719),(66730,66735),(66772,66775),(66812,66815),(66856,66863),(66916,66926),(66928,67071),(67383,67391),(67414,67423),(67432,67583),(67590,67591),(67593,67593),(67638,67638),(67641,67643),(67645,67646),(67670,67670),(67743,67750),(67760,67807),(67827,67827),(67830,67834),(67868,67870),(67898,67902),(67904,67967),(68024,68027),(68048,68049),(68100,68100),(68103,68107),(68116,68116),(68120,68120),(68150,68151),(68155,68158),(68169,68175),(68185,68191),(68256,68287),(68327,68330),(68343,68351),(68406,68408),(68438,68439),(68467,68471),(68498,68504),(68509,68520),(68528,68607),(68681,68735),(68787,68799),(68851,68857),(68904,68911),(68922,69215),(69247,69247),(69290,69290),(69294,69295),(69298,69375),(69416,69423),(69466,69551),(69580,69599),(69623,69631),(69710,69713),(69744,69758),(69821,69821),(69826,69839),(69865,69871),(69882,69887),(69941,69941),(69960,69967),(70007,70015),(70112,70112),(70133,70143),(70162,70162),(70207,70271),(70279,70279),(70281,70281),(70286,70286),(70302,70302),(70314,70319),(70379,70383),(70394,70399),(70404,70404),(70413,70414),(70417,70418),(70441,70441),(70449,70449),(70452,70452),(70458,70458),(70469,70470),(70473,70474),(70478,70479),(70481,70486),(70488,70492),(70500,70501),(70509,70511),(70517,70655),(70748,70748),(70754,70783),(70856,70863),(70874,71039),(71094,71095),(71134,71167),(71237,71247),(71258,71263),(71277,71295),(71353,71359),(71370,71423),(71451,71452),(71468,71471),(71488,71679),(71740,71839),(71923,71934),(71943,71944),(71946,71947),(71956,71956),(71959,71959),(71990,71990),(71993,71994),(72007,72015),(72026,72095),(72104,72105),(72152,72153),(72165,72191),(72264,72271),(72355,72383),(72441,72703),(72713,72713),(72759,72759),(72774,72783),(72813,72815),(72848,72849),(72872,72872),(72887,72959),(72967,72967),(72970,72970),(73015,73017),(73019,73019),(73022,73022),(73032,73039),(73050,73055),(73062,73062),(73065,73065),(73103,73103),(73106,73106),(73113,73119),(73130,73439),(73465,73647),(73649,73663),(73714,73726),(74650,74751),(74863,74863),(74869,74879),(75076,77823),(78895,82943),(83527,92159),(92729,92735),(92767,92767),(92778,92781),(92784,92879),(92910,92911),(92918,92927),(92998,93007),(93018,93018),(93026,93026),(93048,93052),(93072,93759),(93851,93951),(94027,94030),(94088,94094),(94112,94175),(94181,94191),(94194,94207),(100344,100351),(101590,101631),(101641,110591),(110879,110927),(110931,110947),(110952,110959),(111356,113663),(113771,113775),(113789,113791),(113801,113807),(113818,113819),(113824,118783),(119030,119039),(119079,119080),(119155,119162),(119273,119295),(119366,119519),(119540,119551),(119639,119647),(119673,119807),(119893,119893),(119965,119965),(119968,119969),(119971,119972),(119975,119976),(119981,119981),(119994,119994),(119996,119996),(120004,120004),(120070,120070),(120075,120076),(120085,120085),(120093,120093),(120122,120122),(120127,120127),(120133,120133),(120135,120137),(120145,120145),(120486,120487),(120780,120781),(121484,121498),(121504,121504),(121520,122879),(122887,122887),(122905,122906),(122914,122914),(122917,122917),(122923,123135),(123181,123183),(123198,123199),(123210,123213),(123216,123583),(123642,123646),(123648,124927),(125125,125126),(125143,125183),(125260,125263),(125274,125277),(125280,126064),(126133,126208),(126270,126463),(126468,126468),(126496,126496),(126499,126499),(126501,126502),(126504,126504),(126515,126515),(126520,126520),(126522,126522),(126524,126529),(126531,126534),(126536,126536),(126538,126538),(126540,126540),(126544,126544),(126547,126547),(126549,126550),(126552,126552),(126554,126554),(126556,126556),(126558,126558),(126560,126560),(126563,126563),(126565,126566),(126571,126571),(126579,126579),(126584,126584),(126589,126589),(126591,126591),(126602,126602),(126620,126624),(126628,126628),(126634,126634),(126652,126703),(126706,126975),(127020,127023),(127124,127135),(127151,127152),(127168,127168),(127184,127184),(127222,127231),(127406,127461),(127491,127503),(127548,127551),(127561,127567),(127570,127583),(127590,127743),(128728,128735),(128749,128751),(128765,128767),(128884,128895),(128985,128991),(129004,129023),(129036,129039),(129096,129103),(129114,129119),(129160,129167),(129198,129199),(129202,129279),(129401,129401),(129484,129484),(129620,129631),(129646,129647),(129653,129655),(129659,129663),(129671,129679),(129705,129711),(129719,129727),(129731,129743),(129751,129791),(129939,129939),(129995,130031),(130042,131071),(173790,173823),(177973,177983),(178206,178207),(183970,183983),(191457,194559),(195102,196607),(201547,917759),(918000,1114111)]
def printable (c : Char) : Bool := !(nonprintingRanges.any (fun r => r.1 ≤ c.toNat && c.toNat ≤ r.2))
def oneChar (c : Char) : String := String.ofList [c]
def hex (width n : Nat) : String := match width with
 | 0 => ""
 | width+1 => Text.append (hex width (n/16)) (oneChar (Char.ofNat (if n%16<10 then 48+n%16 else 87+n%16)))

def reprChar (quote : Char) (c : Char) : String :=
 if c=quote then Text.append "\\" (oneChar c)
 else if c='\\' then "\\\\"
 else if c='\n' then "\\n" else if c='\r' then "\\r" else if c='\t' then "\\t"
 else if printable c then oneChar c
 else if c.toNat<256 then Text.append "\\x" (hex 2 c.toNat)
 else if c.toNat<65536 then Text.append "\\u" (hex 4 c.toNat)
 else Text.append "\\U" (hex 8 c.toNat)
def reprString (s : String) : String :=
 let quote := if Text.contains s "'" && !Text.contains s "\"" then '"' else '\''
 Text.join [oneChar quote,Text.join ((Text.chars s).map (reprChar quote)),oneChar quote]
mutual
 def reprValue : Value → String
 | .text s => reprString s
 | .integer n => render (.integer n)
 | .boolean b => if b then "True" else "False"
 | .null => "None"
 | .array xs => Text.join ["[",Text.intercalate ", " (reprValues xs),"]"]
 | .object xs => Text.join ["{",Text.intercalate ", " (reprFields xs),"}"]
 def reprValues : List Value → List String
 | [] => []
 | x::xs => reprValue x :: reprValues xs
 def reprFields : List (String × Value) → List String
 | [] => []
 | (k,v)::xs => Text.join [reprString k,": ",reprValue v] :: reprFields xs
end
def strValue (v : Value) : String := match v with | .text s => s | .integer n => reprValue (.integer n) | .boolean b => reprValue (.boolean b) | .null => "None" | .array xs => reprValue (.array xs) | .object xs => reprValue (.object xs)
def truth : Value → Bool
 | .null => false
 | .boolean b => b
 | .integer n => match n with | .ofNat k => !(k==0) | .negSucc _ => true
 | .text s => !s.isEmpty
 | .array xs => !xs.isEmpty
 | .object xs => !xs.isEmpty
def isObject : Value → Bool | .object _ => true | .text _ | .integer _ | .boolean _ | .null | .array _ => false
def get (v : Value) (key : String) (fallback : Value) : Value := match v with
 | .object fields => match fields.find? (fun p => Text.equal p.1 key) with | some p => p.2 | none => fallback
 | .text _ | .integer _ | .boolean _ | .null | .array _ => fallback

def notes : Value → Except String (List String)
 | .object rows => .ok ((sortFields (rows.map fun p => (p.1,strValue p.2))).map Prod.snd)
 | .array rows => .ok (rows.map strValue)
 | .text v => if truth (.text v) then .error "IUPAC definition notes are invalid" else .ok []
 | .integer v => if truth (.integer v) then .error "IUPAC definition notes are invalid" else .ok []
 | .boolean v => if v then .error "IUPAC definition notes are invalid" else .ok []
 | .null => .ok []
def definitions : List Value → Except String (List String)
 | [] => .ok []
 | row::rest => do
   if !isObject row then .error "IUPAC definition row is invalid" else do
    let held ← notes (get row "notes" (.object []))
    let later ← definitions rest
    .ok (strValue (get row "text" (.text "")) :: held ++ later)
def definitionAndNotes (term : Value) : Except String String := do
 match get term "definitions" .null with
 | .array rows => let fragments ← definitions rows; .ok (Text.intercalate " " fragments)
 | .text _ | .integer _ | .boolean _ | .null | .object _ => .error "IUPAC definition support is invalid"

def resolve (reference : Reference) (observation sourceDocument : Value) (snapshotBytes : ByteArray) : Except String Resolved := do
 if !Text.equal (textField observation "source_id") reference.sourceId then .error "extended Chemistry source differs from registration"
 else if !Text.equal (Text.append "sha256:" (SHA256Window.digest snapshotBytes)) reference.snapshotHash then
  .error "official extended Chemistry snapshot differs from registration"
 else do
  let term := get sourceDocument "term" (.object [])
  if !isObject term then .error "IUPAC term record is invalid"
  else if !Text.equal (render (field term "code")) (render (field observation "term_code")) || !Text.equal (textField term "status") "current" then
   .error "IUPAC term identity or status differs from registration"
  else do
   let corpus ← definitionAndNotes term
   let features ← match field observation "ordered_feature_extractions" with
    | .array [] => .error "extended Chemistry feature extraction is absent"
    | .array (row::rows) => .ok (row::rows)
    | .text _ | .integer _ | .boolean _ | .null | .object _ => .error "extended Chemistry feature extraction is absent"
   features.forM fun feature => do
    if !validFeature feature then .error "extended Chemistry feature extraction is invalid"
    else if !Text.contains (SourceText.casefold corpus) (SourceText.casefold (textField feature "required_fragment")) then
     .error "extended Chemistry target is not reproduced by official text"
    else .ok ()
   let label := Text.intercalate "__" (features.map (fun feature => textField feature "normalized_feature"))
   .ok ⟨reference,label,identity (.array [.text reference.targetId,observation,.text label,.text reference.snapshotHash])⟩

def targetKey (row : Value) : Value := match field row "target_id" with
 | .boolean b => .integer (if b then 1 else 0)
 | .text s => .text s
 | .integer n => .integer n
 | .null => .null
 | .array xs => .array xs
 | .object xs => .object xs

def checkTargetKey (row : Value) : Except String Unit := match row with
 | .object fields =>
   if !(fields.any (fun p => Text.equal p.1 "target_id")) then .error "'target_id'"
   else match field row "target_id" with
    | .array _ => .error "unhashable type: 'list'"
    | .object _ => .error "unhashable type: 'dict'"
    | .text _ | .integer _ | .boolean _ | .null => .ok ()
 | .text _ | .integer _ | .boolean _ | .null | .array _ => .ok ()

def resolveAll (registry : Value) (references : List Reference) (snapshots : List Snapshot) : Except String (List Resolved) := do
 if !Text.equal (textField registry "schema") "sft-v3-chemistry-extended-source-derived-observations/1" then
  .error "extended Chemistry observation registry schema is invalid"
 else do
  let observations ← match field registry "observations" with
   | .array rows => .ok rows
   | .text _ | .integer _ | .boolean _ | .null | .object _ => .error "extended Chemistry observation rows are invalid"
  observations.forM checkTargetKey
  if !(observations.all isObject) || !uniqueValues (observations.map targetKey) then
   .error "extended Chemistry registry contains duplicate or invalid rows"
  else references.mapM fun reference => do
   match observations.find? (fun row => Text.equal (textField row "target_id") reference.targetId) with
   | none => .error "registered extended Chemistry target is absent"
   | some observation => match snapshots.find? (fun source => Text.equal source.path reference.snapshotPath) with
     | none => .error "registered Chemistry snapshot file is absent"
     | some source => resolve reference observation source.document source.bytes
end SFT.Chemistry.ExtendedExtraction

#print axioms SFT.Chemistry.ExtendedExtraction.nonprintingRanges
#print axioms SFT.Chemistry.ExtendedExtraction.printable
#print axioms SFT.Chemistry.ExtendedExtraction.oneChar
#print axioms SFT.Chemistry.ExtendedExtraction.hex
#print axioms SFT.Chemistry.ExtendedExtraction.reprChar
#print axioms SFT.Chemistry.ExtendedExtraction.reprString
#print axioms SFT.Chemistry.ExtendedExtraction.reprValue
#print axioms SFT.Chemistry.ExtendedExtraction.reprValues
#print axioms SFT.Chemistry.ExtendedExtraction.reprFields
#print axioms SFT.Chemistry.ExtendedExtraction.strValue
#print axioms SFT.Chemistry.ExtendedExtraction.truth
#print axioms SFT.Chemistry.ExtendedExtraction.isObject
#print axioms SFT.Chemistry.ExtendedExtraction.get
#print axioms SFT.Chemistry.ExtendedExtraction.notes
#print axioms SFT.Chemistry.ExtendedExtraction.definitions
#print axioms SFT.Chemistry.ExtendedExtraction.definitionAndNotes
#print axioms SFT.Chemistry.ExtendedExtraction.resolve
#print axioms SFT.Chemistry.ExtendedExtraction.targetKey
#print axioms SFT.Chemistry.ExtendedExtraction.checkTargetKey
#print axioms SFT.Chemistry.ExtendedExtraction.resolveAll