import SFT.Mathematics.CategoryPaths
namespace SFT.Mathematics.CategoryIdentity
open CategoryPaths SFT.Host.Text

theorem appendNil {α : Type} (xs : List α) : xs ++ [] = xs := by
  induction xs with
  | nil => rfl
  | cons x xs ih => exact congrArg (List.cons x) ih

theorem concatAppend {α : Type} (xs : List α) (x : α) : xs.concat x = xs ++ [x] := by
  induction xs with
  | nil => rfl
  | cons a xs ih => exact congrArg (List.cons a) ih

theorem byteLoop (bytes : List UInt8) (acc : ByteArray) :
    (List.toByteArray.loop bytes acc).data.toList = acc.data.toList ++ bytes := by
  induction bytes generalizing acc with
  | nil => exact (appendNil _).symm
  | cons b rest ih =>
    change (List.toByteArray.loop rest (acc.push b)).data.toList = _
    rw [ih]
    change acc.data.toList.concat b ++ rest = acc.data.toList ++ b :: rest
    rw [concatAppend]
    exact ExactTraceArithmetic.appendAssociative _ _ _

theorem encodedBytes (chars : List Char) :
    (String.ofList chars).toUTF8.data.toList = chars.flatMap String.utf8EncodeChar :=
  byteLoop _ ByteArray.empty

theorem returnPrefix (object : String) :
    isPrefix "empty-One-return".toUTF8.data.toList
      (append "empty-One-return:" object).toUTF8.data.toList = true := by
  change isPrefix _ (String.ofList (_ ++ chars object)).toUTF8.data.toList = true
  rw [encodedBytes (chars "empty-One-return:" ++ chars object)]
  rfl

theorem identityCanonical (object : String) (arrow : Arrow) (h : identity object = .ok arrow) :
    canonicalPath arrow = [] := by
  change canonicalTrace arrow.trace = []
  rw [(identityFields _ _ h).2.2]
  unfold canonicalTrace
  rw [List.filter_cons_of_neg (by rw [returnPrefix]; intro h; cases h)]
  rfl

theorem leftIdentity (object : String) (idArrow arrow result : Arrow)
    (hid : identity object = .ok idArrow) (h : compose idArrow arrow = .ok result) :
    result.source = arrow.source ∧ result.target = arrow.target ∧ canonicalPath result = canonicalPath arrow := by
  have fields := identityFields _ _ hid
  have joinedFields := composeRetains _ _ _ h
  have matchInterface := (composeResult _ _ _ h).1
  refine ⟨?_,joinedFields.2.1,?_⟩
  · rw [joinedFields.1,fields.1,← fields.2.1]; exact matchInterface
  · rw [composeCanonical _ _ _ h,identityCanonical _ _ hid]; rfl

theorem rightIdentity (object : String) (idArrow arrow result : Arrow)
    (hid : identity object = .ok idArrow) (h : compose arrow idArrow = .ok result) :
    result.source = arrow.source ∧ result.target = arrow.target ∧ canonicalPath result = canonicalPath arrow := by
  have fields := identityFields _ _ hid
  have joinedFields := composeRetains _ _ _ h
  have matchInterface := (composeResult _ _ _ h).1
  refine ⟨joinedFields.1,?_,?_⟩
  · rw [joinedFields.2.1,fields.2.1,← fields.1]; exact matchInterface.symm
  · rw [composeCanonical _ _ _ h,identityCanonical _ _ hid]
    exact appendNil _


theorem flatMapAppend {α β : Type} (f : α → List β) (xs ys : List α) :
    (xs ++ ys).flatMap f = xs.flatMap f ++ ys.flatMap f := by
  induction xs with
  | nil => rfl
  | cons x xs ih =>
    change f x ++ (xs ++ ys).flatMap f = (f x ++ xs.flatMap f) ++ ys.flatMap f
    rw [ih,ExactTraceArithmetic.appendAssociative]

theorem appendHasBytes (xs : List UInt8) (b : UInt8) (ys : List UInt8) :
    ((xs ++ b :: ys).length == 0) = false := by
  cases xs <;> rfl

theorem joinedNameNonempty (first second : Arrow) : (joined first second).name.isEmpty = false := by
  change ((String.ofList (chars second.name ++ (chars "∘" ++ (chars first.name ++ [])))).toUTF8.data.toList.length == 0) = false
  rw [encodedBytes,flatMapAppend,flatMapAppend,flatMapAppend]
  change (((chars second.name).flatMap String.utf8EncodeChar ++
    (([226,136,152] : List UInt8) ++ ((chars first.name).flatMap String.utf8EncodeChar ++ []))).length == 0) = false
  rw [appendNil]
  change (((chars second.name).flatMap String.utf8EncodeChar ++
    (([226,136,152] : List UInt8) ++ (chars first.name).flatMap String.utf8EncodeChar)).length == 0) = false
  exact appendHasBytes _ _ _

theorem admittedFields (a : Arrow) (h : invalid a = false) :
    a.name.isEmpty = false ∧ a.source.isEmpty = false ∧ a.target.isEmpty = false ∧ a.trace.isEmpty = false := by
  cases hn : a.name.isEmpty <;> cases hs : a.source.isEmpty <;>
    cases ht : a.target.isEmpty <;> cases hp : a.trace.isEmpty <;>
    first | exact ⟨rfl,rfl,rfl,rfl⟩ | (unfold invalid at h; rw [hn,hs,ht,hp] at h; cases h)

theorem joinedAdmitted (first second : Arrow) (hf : invalid first = false) (hs : invalid second = false) :
    invalid (joined first second) = false := by
  have f := admittedFields _ hf
  have s := admittedFields _ hs
  have trace : (first.trace ++ second.trace).isEmpty = false := by
    cases hp : first.trace with
    | nil => rw [hp] at f; cases f.2.2.2
    | cons a rest => rfl
  change ((joined first second).name.isEmpty || first.source.isEmpty || second.target.isEmpty ||
    (first.trace ++ second.trace).isEmpty) = false
  rw [joinedNameNonempty,f.2.1,s.2.2.1,trace]; rfl

theorem compositionExists (first second : Arrow) (hf : invalid first = false) (hs : invalid second = false) :
    (∃ result, compose first second = .ok result) ↔ first.target = second.source := by
  constructor
  · intro ⟨result,h⟩; exact (composeResult _ _ _ h).1
  · intro interfaces
    exact ⟨joined first second,composeAccepted _ _ interfaces (joinedAdmitted _ _ hf hs)⟩


theorem identityNameNonempty (object : String) : (append "id:" object).isEmpty = false := by
  change ((String.ofList (chars "id:" ++ chars object)).toUTF8.data.toList.length == 0) = false
  rw [encodedBytes]
  rfl

theorem identityExists (object : String) (h : object.isEmpty = false) :
    identity object = .ok ⟨append "id:" object,object,object,[append "empty-One-return:" object]⟩ := by
  apply constructorAccepted
  change ((append "id:" object).isEmpty || object.isEmpty || object.isEmpty || false) = false
  rw [identityNameNonempty,h]; rfl

end SFT.Mathematics.CategoryIdentity
