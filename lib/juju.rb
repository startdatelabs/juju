require 'active_support/all'
require 'rest-client'

class Juju
  URL = "http://api.juju.com/jobs"
  
  def self.instance
    @instance ||= Juju.new
  end

  def self.search(params)
    self.instance.search(params)
  end    
  
  def search(params)
    check_required params
    begin
      response = RestClient.get URL, {:params => params}
    rescue RestClient::BadRequest
      raise JujuError, 'Request failed: invalid parameters'
    end
    parse_xml response
  end
   
protected
  def parse_xml(xml)
    begin
      data = Hash.from_xml(xml)['rss']['channel']
    rescue REXML::ParseException
      raise JujuError, 'Did not get a valid XML response from Juju'
    end
    jobs = data['item'].each {|item| item['link'].squish!}
    JujuResult.new(jobs, data['totalresults'], data['startindex'], data['itemsperpage'])
  end
  
  def check_required(params)
    raise JujuError.new('Partner ID was not provided') unless params[:partnerid]
    raise JujuError.new('IP Address was not provided') unless params[:ipaddress] 
    raise JujuError.new('User-Agent was not provided') unless params[:useragent]
    raise JujuError.new('Required parameters were not provided') unless params[:k] || params[:l] || params[:c]
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

