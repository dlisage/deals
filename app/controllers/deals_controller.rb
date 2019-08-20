# frozen_string_literal: true

# Deals Controller
class DealsController < ApplicationController
  layout 'react'

  def index
    json = RestClient.get(t('api_url'), params: { api_key: Rails.application.credentials.api_key } )
    @chart_data = { data: chart_data(json).unshift([t('stage'), t('value')]) }
  end

  private

  def chart_data(json)
    deals = JSON.parse(json)['entries']
    data = deals.map{ |deal| { value: deal['value'], percent: deal['deal_stage']['percent'], name: deal['name'] } }
    data.sort_by! { |deal| deal[:percent] }
    data.map { |deal| ["#{deal[:percent]}%-#{deal[:name]}", deal[:value].to_f] }
  end
end
