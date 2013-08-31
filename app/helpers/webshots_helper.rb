module WebshotsHelper


	def get_host_without_www(url)
	  uri = URI.parse(url)
	  uri = URI.parse("http://#{url}") if uri.scheme.nil?
	  host = uri.host.downcase
	  host.start_with?('www.') ? host[4..-1] : host
	end
end
