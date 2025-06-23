(** Type alias for cryptographic hash *)
type 'a hash = string

(** Authenticated Interval Tree Node type *)
type ('a, 'b) ait_node =
  | Leaf of 'a * 'b * 'a hash
  | Node of 'a * 'a hash * ('a, 'b) ait_node * ('a, 'b) ait_node

(** [hash_str s] returns the BLAKE2b hash of string [s] in hex *)
val hash_str : string -> string

(** [hash_pair h1 h2] returns the hash of the concatenation of [h1] and [h2] *)
val hash_pair : string -> string -> string

(** [list_take n lst] takes the first [n] elements of [lst] *)
val list_take : int -> 'a list -> 'a list

(** [list_drop n lst] drops the first [n] elements of [lst] *)
val list_drop : int -> 'a list -> 'a list

(** [build_ait lst] builds an authenticated interval tree from sorted key-value list [lst] *)
val build_ait : (int * string) list -> (int, string) ait_node

(** [search_range_with_proof tree (lo, hi)] searches for keys in range [(lo, hi)] and
    returns the matching results (if any) and a recomputed root hash *)
val search_range_with_proof :
  (int, string) ait_node -> int * int -> ((int * string * string) list option * string)
