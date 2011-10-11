require 'helper'
class TestMimiweb < Test::Unit::TestCase
	def test_free_text_search
		term = "pwp1"
		results = Mimiweb.search(term)
		assert_equal 'Array', results.class.to_s
	end

	def test_entrez_compounds_search
		term = 7389
		results = Mimiweb.entrez(term, :compounds)
		assert_equal 'Array', results.class.to_s
	end

	def test_entrez_reactions_search
		term = 1436
		results = Mimiweb.entrez(term, :reactions)
		assert_equal 'Hashie::Mash', results.class.to_s
	end

	def test_entrez_nlp_search
		term = 4005
		results = Mimiweb.entrez(term, :nlp)
		assert_equal 'Array', results.class.to_s
	end

	def test_entrez_interactions_search
		term = 1436
		results = Mimiweb.entrez(term)
		assert_equal 'Array', results.class.to_s
	end

	def test_kegg_compound_search
		term = "C00061"
		results = Mimiweb.kegg_compound(term)
		assert_equal 'Hashie::Mash', results.class.to_s
	end

	def test_kegg_reactions_search
		term = "R00548"
		results = Mimiweb.kegg_reaction(term)
		assert_equal 'Hashie::Mash', results.class.to_s
	end
end
