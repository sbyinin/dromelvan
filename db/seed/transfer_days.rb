puts("Seeding transfer day...")

TransferWindow.all.each do |transfer_window|
  TransferDay.create(transfer_window: transfer_window, transfer_day_number: 1, status: 2, datetime: transfer_window.datetime + 1.day)
end
