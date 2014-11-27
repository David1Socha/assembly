module Assembly
  OPCODES = {"ADD" => "C"}
  CONDS = {"AL" => "0"}
  DEFAULT_COND = "0"
  TYPES = {"0" => :J, "1" => :J, "2" => :J, "3" => :J, "4" => :B, "5" => :B, "6" => :B, "7" => :B, "8" => :D, "9" => :D, "A" => :D, "B" => :D,"C" => :R, "D" => :R, "E" => :R, "F" => :R}
end