def calculate_parking_fee(entry_time, exit_time):
    if entry_time is None:
        return 0
    parked_time = exit_time - entry_time
    parked_minutes = int(parked_time.total_seconds() / 60)
    rate_per_minute = 0.10
    return parked_minutes * rate_per_minute
