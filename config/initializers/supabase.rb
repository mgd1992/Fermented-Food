require 'faraday'
require 'json'

class SupabaseStorage
  SUPABASE_URL = 'https://zelfpyrkxsabybuknfkr.supabase.co'
  SUPABASE_API_KEY = ENV['SUPABASE_SERVICE_ROLE_KEY']

  BUCKET_ID = 'ferments-images'

  def self.upload_file(file_path, destination_path)
    conn = Faraday.new(url: SUPABASE_URL) do |faraday|
      faraday.request :multipart
      faraday.request :url_encoded
      faraday.adapter Faraday.default_adapter
      faraday.headers['apikey'] = SUPABASE_API_KEY
      faraday.headers['Authorization'] = "Bearer #{SUPABASE_API_KEY}"
    end

    file = Faraday::Multipart::FilePart.new(file_path, 'application/octet-stream')

    payload = { file: file }

    response = conn.post("/storage/v1/object/#{BUCKET_ID}/#{destination_path}") do |req|
      req.body = payload
    end

    if response.status == 200
      puts "Archivo subido con éxito!"
      JSON.parse(response.body)
    else
      puts "Error subiendo archivo: #{response.status} - #{response.body}"
      nil
    end
  end

  def self.download_file(path)
    conn = Faraday.new(url: SUPABASE_URL) do |faraday|
      faraday.adapter Faraday.default_adapter
      faraday.headers['apikey'] = SUPABASE_API_KEY
      faraday.headers['Authorization'] = "Bearer #{SUPABASE_API_KEY}"
    end

    response = conn.get("/storage/v1/object/#{BUCKET_ID}/#{path}")

    if response.status == 200
      response.body
    else
      puts "Error descargando archivo: #{response.status} - #{response.body}"
      nil
    end
  end

  def self.delete_file(path)
    conn = Faraday.new(url: SUPABASE_URL) do |faraday|
      faraday.adapter Faraday.default_adapter
      faraday.headers['apikey'] = SUPABASE_API_KEY
      faraday.headers['Authorization'] = "Bearer #{SUPABASE_API_KEY}"
    end

    response = conn.delete("/storage/v1/object/#{BUCKET_ID}/#{path}")

    if response.status == 200
      puts "Archivo eliminado con éxito."
      true
    else
      puts "Error eliminando archivo: #{response.status} - #{response.body}"
      false
    end
  end
end
