puts("Fixing transfer days...")

TransferDay.all.each do |transfer_day|
  transfer_day.transfer_window = TransferWindow.find(transfer_day.id)
  transfer_day.save
end
