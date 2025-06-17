open Types

let rec search_range tree (lo, hi) =
  match tree with
  | Leaf (salary, name, hash) ->
      if salary >= lo && salary <= hi then Some [(salary, name, hash)]
      else None
  | Node ((min_s, max_s), _, left, right) ->
      if hi < min_s then search_range left (lo, hi)
      else if lo > max_s then search_range right (lo, hi)
      else (
        let lres = search_range left (lo, hi) in
        let rres = search_range right (lo, hi) in
        match (lres, rres) with
        | (Some l, Some r) -> Some (l @ r)
        | (Some l, None) -> Some l
        | (None, Some r) -> Some r
        | _ -> None
      )
