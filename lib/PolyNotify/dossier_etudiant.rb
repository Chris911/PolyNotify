module PolyNotify
  module Dossier_Etudiant

    def log_in
      body = {code: @config['CODE'], nip: @config['PASSWORD'], naissance: @config['DDN']}
      data = post('/servlet/ValidationServlet', :body => body, :headers => {'Content-Type' => 'application/x-www-form-urlencoded'})
      save_data data
    end

    def get_resultats_finaux
      body = @inputs
      data = post('/servlet/PresentationResultatsTrimServlet', :body => body, :headers => {'Content-Type' => 'application/x-www-form-urlencoded'})
      extract_notes data
    end

    def save_data (data)
      doc = Nokogiri.parse(data)
      doc.css('input').each do |input|
        @inputs[input['name']] = input['value'] unless input['name'].include? 'btn'
      end
    end

    def extract_notes(data)
      doc = Nokogiri.parse(data)
      tables = doc.css('table').select {|table| table['width'] == '75%'}
      @checksum = Digest::MD5.hexdigest(tables[0])
    end

  end
end