require 'active_support/all'
require 'rest-client'

class JuJu
  URL = "http://api.juju.com/jobs"
  
  def self.instance
    @instance ||= JuJu.new
  end

  def self.search(params)
    self.instance.search(params)
  end    
  
  def search(params)
    check_required params
    begin
      response = RestClient.get URL, {:params => params}
    rescue RestClient::BadRequest
      raise JuJuError, 'Request failed: invalid parameters'
    end
    parse_xml response
  end
   
protected
  def parse_xml(xml)
    begin
      data = Hash.from_xml(xml)['rss']['channel']
    rescue REXML::ParseException
      raise JuJuError, 'Did not get a valid XML response from JuJu'
    end
    jobs = data['item'].each {|item| item['link'].squish!}
    JuJuResult.new(jobs, data['totalresults'], data['startindex'], data['itemsperpage'])
  end
  
  def check_required(params)
    raise JuJuError.new('Partner ID was not provided') unless params[:partnerid]
    raise JuJuError.new('IP Address was not provided') unless params[:ipaddress] 
    raise JuJuError.new('User-Agent was not provided') unless params[:useragent]
    raise JuJuError.new('Required parameters were not provided') unless params[:k] || params[:l] || params[:c]
  end

end

class JuJuError < StandardError; end

class JuJuResult < Array
  attr_accessor :total, :start_index, :per_page
    
  def initialize(jobs_array, total, start_index, per_page)
    super(jobs_array)
    self.total = total.to_i
    self.start_index = start_index.to_i
    self.per_page = per_page.to_i
  end
end

