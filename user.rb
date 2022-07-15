# frozen_string_literal: true
require 'net/http'
require 'uri'
require 'json'

class User
  attr_reader :vars

  QUERY_STRING = <<-GRAPHQL
    query StorefrontUsers($distinct_on: [StorefrontUser_select_column!], $limit: Int, $offset: Int, $order_by: [StorefrontUser_order_by!], $where: StorefrontUser_bool_exp) {
      StorefrontUsers(distinct_on: $distinct_on, limit: $limit, offset: $offset, order_by: $order_by, where: $where) {
        createdAt
        email
        firstName
        id
        lastName
        phoneNumber
        platformId
        siteId
        updatedAt
      }
    }
  GRAPHQL

  TOKEN = "API a13c52c3-c3bc-41cc-956d-84350a4ce411"

  HTTP = URI('https://graphql.skio.com/v1/graphql')

  def initialize(email)
    @vars = { "where": { "email": { "_ilike": email } } }
  end

  def call

    response = Net::HTTP.post(
      HTTP,
      { query: QUERY_STRING, variables: vars }.to_json,
      'authorization': TOKEN
    )

    puts response.body
  end
end
