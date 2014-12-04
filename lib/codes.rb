module Assembly
  OPCODES = {"ADD" => "1100"}
  CONDS = {"AL" => "0"}
  DEFAULT_COND = "0"
  OPX = {"ADD" => "011"}
  TYPES = {"ADD" => :R, "SUB" => :R, "AND" => :R, "OR" => :R, "XOR" => :R, "SLL" => :R, "CMP" => :R, "JR" => :R}
  S_SET_COMMANDS = ["CMP"]
end