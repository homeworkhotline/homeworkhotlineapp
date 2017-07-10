json.extract! time_clock, :id, :clock_in, :clock_out, :date, :hours, :user_id, :created_at, :updated_at
json.url time_clock_url(time_clock, format: :json)
