def fill_in_form(selects, fill_ins, checks)
  selects.keys.each do |key|
    select selects[key], from: key
  end
  fill_ins.keys.each do |key|
    fill_in key, with: fill_ins[key]
  end
  checks.keys.each do |key|
    if checks[key]
      check key
    else
      uncheck key
    end
  end
end
