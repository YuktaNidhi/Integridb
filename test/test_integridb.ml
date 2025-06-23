(* test/test_integridb.ml *)
[@@@warning "-21"]

open Integridb

(* Sample employee data *)
let employee_data = [
  (50000, "Alice");
  (80000, "Bob");
  (120000, "Charlie");
  (150000, "Daisy");
  (200000, "Ethan");
  (250000, "Fiona");
]

let () =
  let tree = build_ait employee_data in
  let root_hash = match tree with
    | Leaf (_, _, h) -> h
    | Node (_, h, _, _) -> h
  in

  (* Test case 1: Query range includes Charlie and Daisy *)
  let (results_opt, recomputed_hash) = search_range_with_proof tree (110000, 160000) in
  assert (recomputed_hash = root_hash);
  match results_opt with
  | Some lst ->
    assert (List.length lst = 2);
    assert (List.exists (fun (_, name, _) -> name = "Charlie") lst);
    assert (List.exists (fun (_, name, _) -> name = "Daisy") lst)
  | None -> failwith "Test failed: expected Charlie and Daisy";



  (* Test case 2: Query range with no employees *)
  let (results_opt2, recomputed_hash2) = search_range_with_proof tree (1000, 2000) in
  assert (recomputed_hash2 = root_hash);
  assert (results_opt2 = None);

  (* Test case 3: Full range query *)
  let (results_opt3, recomputed_hash3) = search_range_with_proof tree (0, 300000) in
  assert (recomputed_hash3 = root_hash);
  match results_opt3 with
  | Some lst -> assert (List.length lst = List.length employee_data)
  | None -> failwith "Test failed: expected all employees";

Printf.printf "All tests ran and passed successfully!\n";
flush stdout;
