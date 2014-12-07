module Assembly
  OPCODES = {"ADD" => "1100", "SUB" => "1100", "AND" => "1100", "XOR" => "1100", "OR" => "1100", "SLL" => "1111", "CMP" => "1110", "JR" => "1101", "J" => "0000", "JAL" => "0001", "LI" => "0010"}
  CONDS = {"AL" => "0000"}
  DEFAULT_COND = "0000"
  OPX = {"ADD" => "011", "SUB" => "100", "AND" => "000", "OR" => "001", "XOR" => "010", "SLL" => "000", "CMP" => "000", "JR" => "000"}
  TYPES = {"ADD" => :R, "SUB" => :R, "AND" => :R, "OR" => :R, "XOR" => :R, "SLL" => :R, "CMP" => :R, "JR" => :R, "J" => :J, "JAL" => :J, "LI" => :J}
  S_SET_COMMANDS = ["CMP"]
end