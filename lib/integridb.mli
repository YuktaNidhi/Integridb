(** 
  IntegriDB: Authenticated Interval Tree (AIT)
  
  This module provides a simple authenticated data structure using 
  interval trees for range queries over ordered data.
*)

(** The type representing a hash value. *)
type 'a hash = string

(** A generic range type, represented as a tuple of two values. *)
type 'a range = 'a * 'a

(** AIT node structure — either a leaf or an internal node. 
    Each node contains hash values for authentication. *)
type ('a, 'b) ait_node =
  | Leaf of 'a * 'b * 'b hash
  | Node of 'a range * 'b hash * ('a, 'b) ait_node * ('a, 'b) ait_node

(** [build_ait lst] builds an authenticated interval tree from a sorted 
    list of (key, value) pairs.

    @param lst A sorted list of (key, string) pairs
    @raise Failure if the list is empty
    @return an authenticated interval tree of type (key, string) ait_node
*)
val build_ait : ('a * string) list -> ('a, string) ait_node

(** [search_range_with_proof tree (lo, hi)] returns the list of 
    (key, value, hash) tuples from the authenticated interval tree 
    that lie in the inclusive range [lo, hi], along with the 
    recomputed root hash based on the queried data.

    @param tree An authenticated interval tree
    @param (lo, hi) The lower and upper bounds of the query range
    @return A tuple of (optional results, recomputed hash)
*)
val search_range_with_proof :
  ('a, string) ait_node ->
  ('a * 'a) ->
  (('a * string * string) list option * string)
