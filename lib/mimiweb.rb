require 'httparty'
require 'hashie'

BASE_URL = "http://mimi.ncibi.org/MimiWeb/fetch.jsp?"

module Mimiweb
  class << self
    include HTTParty 
    def search(term)
      get_results(:search, term)
    end
    def entrez(id, *type)
      result_type = type || "interactions"
      get_results(:geneid, id, result_type)
    end
    def kegg_compound(id)
      results = get_results(:cid, id)
    end
    def kegg_reaction(id)
      get_results(:rid, id)
    end

    private
    def get_results(search_type, term, *type)
      type = type || "interactions"
      if search_type == :gene
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