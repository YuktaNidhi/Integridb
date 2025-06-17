open Types
open Utils

let rec build_ait lst =
  match lst with
  | [] -> failwith "Empty employee list"
  | [ (sal, name) ] ->
      let h = hash_str name in
      Leaf (sal, name, h)
  | _ ->
      let len = List.length lst / 2 in
      let left = build_ait (list_take len lst) in
      let right = build_ait (list_drop len lst) in
      let range =
        let min_sal = match left with Leaf (s, _, _) | Node ((s, _), _, _, _) -> s in
        let max_sal = match right with Leaf (s, _, _) | Node ((_, s), _, _, _) -> s in
        (min_sal, max_sal)
      in
      let h1 = match left with Leaf (_, _, h) | Node (_, h, _, _) -> h in
      let h2 = match right with Leaf (_, _, h) | Node (_, h, _, _) -> h in
      let h = hash_pair h1 h2 in
      Node (range, h, left, right)