puts("Fixing transfer days again...")

TransferDay.all.each do |transfer_day|
  transfer_day.datetime = transfer_day.transfer_window.datetime + 1.day
  transfer_day.save
end
