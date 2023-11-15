# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

require 'rest-client'
require 'nokogiri'

def digital_ocean_secret_key
    ENV["DIGITAL_OCEAN_SECRET_KEY"]
end

def digital_ocean_access_key
    ENV["DIGITAL_OCEAN_ACCESS_KEY"]
end

# def create_signature

#     # Create the canonical request
#     amzdate = Time.now.utc.strftime('%Y%m%dT%H%M%SZ')
#     host = 'chrome-extension-images.nyc3.digitaloceanspaces.com'
#     method = 'GET'
#     canonical_uri = '/'
#     signed_headers = 'host;x-amz-content-sha256;x-amz-date'
#     payload_hash = OpenSSL::Digest::Digest.new("sha256").hexdigest("")
#     canonical_headers = [
#         'host:' + host, "x-amz-content-sha256:#{payload_hash}",
#         'x-amz-date:' + amzdate
#     ].join("\n") + "\n"

#     canonical_request = [
#         method, canonical_uri, '', canonical_headers, signed_headers, payload_hash
#     ].join("\n")

#     # Create the string to sign
#     algorithm = 'AWS4-HMAC-SHA256'
#     datestamp = Time.now.utc.strftime('%Y%m%d')
#     region = 'nyc3'
#     credential_scope = [datestamp, region, 's3/aws4_request'].join("/")
#     string_to_sign = [
#         algorithm, amzdate, credential_scope,
#         OpenSSL::Digest::Digest.new("sha256").hexdigest(canonical_request)
#     ].join("\n")

#     # Calculate the signing_key
#     kDate    = OpenSSL::HMAC.digest('sha256', "AWS4" + digital_ocean_secret_key, datestamp)
#     kRegion  = OpenSSL::HMAC.digest('sha256', kDate, region)
#     kService = OpenSSL::HMAC.digest('sha256', kRegion, 's3')
#     kSigning = OpenSSL::HMAC.digest('sha256', kService, "aws4_request")

#     # Sign and return the signature
#     signature = OpenSSL::HMAC.hexdigest('sha256', kSigning, string_to_sign)
#     {
#         "x-amz-content-sha256" => payload_hash,
#         "x-amz-date" => amzdate, 
#         "signature" => signature,
#         "datestamp" => datestamp
#     }
# end

def get_images
    # headers = create_signature()
    # puts headers
    # puts '--------------------'
    # credential = "#{digital_ocean_access_key}/#{headers['datestamp']}/nyc3/s3/aws4_request"
    # signed_headers = "host;x-amz-content-sha256;x-amz-date"

    # puts "AWS4-HMAC-SHA256 Credential=#{credential},SignedHeaders=#{signed_headers},Signature=#{headers['signature']}"

    raw_images = RestClient.get(
        "https://chrome-extension-images.nyc3.digitaloceanspaces.com"
    )

    images = Nokogiri::XML(raw_images)
    urls = images.css("ListBucketResult Contents").map { |node| node.at('Key').text }
    urls.shift()
    urls.each do |url|
        JaniceImage.create!(
            url: "https://chrome-extension-images.nyc3.cdn.digitaloceanspaces.com/#{url}"
        )
    end
end

get_images()
