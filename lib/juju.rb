require 'active_support/all'
require 'rest-client'
require 'action_view'
require 'htmlentities'

class Juju
  include ActionView::Helpers::SanitizeHelper

  URL = "http://api.juju.com/jobs"
  
  def self.instance
    @instance ||= Juju.new
  end

  def self.search(params)
    self.instance.search(params)
  end    
  
  def search(params)
    check_required params
    response = RestClient.get URL, {:params => params}
    parse_xml response
  rescue RestClient::BadRequest
    raise JujuError, 'Request failed: invalid parameters'
  end
   
protected
  def parse_xml(xml)
    data = Hash.from_xml(xml)['rss']['channel']
    jobs = remove_spaces_and_tags data['item']
    JujuResult.new(jobs, data['totalresults'], data['startindex'], data['itemsperpage'])
  rescue REXML::ParseException
    raise JujuError, 'Did not get a valid XML response from Juju'
  end

  def remove_spaces_and_tags(jobs)
    jobs.each do |item|
      item['link'].squish!
      item['title'] = HTMLEntities.new.decode(strip_tags(item['title']).squish!)
      item['description'] = HTMLEntities.new.decode(strip_tags(item['description']).squish!)
    end
  end
  
  def check_required(params)
    raise ArgumentError.new('Partner ID was not provided') unless params[:partnerid]
    raise ArgumentError.new('IP Address was not provided') unless params[:ipaddress] 
    raise ArgumentError.new('User-Agent was not provided') unless params[:useragent]
    raise ArgumentError.new('Required parameters were not provided') unless params[:k] || params[:l] || params[:c]
  end

end

class JujuError < StandardError; end

class JujuResult < Array
  attr_accessor :total, :start_index, :per_page
    
  def initialize(jobs_array, total, start_index, per_page)
    super(jobs_array)
    self.total = total.to_i
    self.start_index = start_index.to_i
    self.per_page = per_page.to_i
  end
end

