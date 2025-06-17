type salary = int
type name = string
type hash = string
type salary_range = salary * salary

type ait_node =
  | Leaf of salary * name * hash
  | Node of salary_range * hash * ait_node * ait_node