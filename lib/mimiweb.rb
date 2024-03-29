require 'httparty'
require 'hashie'

module Mimiweb
  class << self
    include HTTParty 
    BASE_URL =  'http://mimi.ncibi.org/MimiWeb/fetch.jsp?'
    def search(term)
      get_results(:search, term, type="")
    end
    def entrez(id, type="interactions")
      get_results(:geneid, id, type)
    end
    def kegg_compound(id)
      get_results(:cid, id, type="")
    end
    def kegg_reaction(id)
      get_results(:rid, id, type="")
    end

    private
    def get_results(search_type, term, type)
      if search_type == :geneid
        response = HTTParty.get(BASE_URL, {:query => {search_type => term, :type => type}}).parsed_response rescue "server error"
      else
        response = HTTParty.get(BASE_URL, {:query => {search_type => term}}).parsed_response rescue "server error"
      end

      results = Hashie::Mash.new(response)
      if results.NCIBI.MiMI.Response.Result.nil? && results.NCIBI.MiMI.Response.ResultSet.nil?
        raise "No results found for #{term}"
      else
        return results.NCIBI.MiMI.Response.Result || results.NCIBI.MiMI.Response.ResultSet.Result
      end
    end
  end
end