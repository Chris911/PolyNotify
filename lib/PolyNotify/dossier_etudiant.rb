module PolyNotify
  module Dossier_Etudiant

    def log_in
      body = {code: @config['CODE'], nip: @config['PASSWORD'], naissance: @config['DDN']}
      data = post('/servlet/ValidationServlet', :body => body, :headers => {'Content-Type' => 'application/x-www-form-urlencoded'})
      doc = Nokogiri.parse(data)
      save_data doc
    end

    def get_resultats_finaux
      body = @inputs
      data = post('/servlet/PresentationResultatsTrimServlet', :body => body, :headers => {'Content-Type' => 'application/x-www-form-urlencoded'})
      doc = Nokogiri.parse(data)
      extract_notes doc
    end

    def get_horaire(session)
      @inputs['trimestre'] = session
      body = @inputs
      data = post('/servlet/PresentationHorairePersServlet', :body => body, :headers => {'Content-Type' => 'application/x-www-form-urlencoded'})
      doc = Nokogiri.parse(data)
      extract_horaire doc
    end

    def save_data (doc)
      doc.css('input').each do |input|
        @inputs[input['name']] = input['value'] unless input['name'].include? 'btn'
      end
    end

    def extract_notes(doc)
      tables = doc.css('table').select {|table| table['width'] == '75%'}
      @checksum = Digest::MD5.hexdigest(tables[0])
    end

    def extract_horaire(doc)
      horaire = doc.css('table').select {|table| table['cellspacing'] == '5'}
    end
  end
end
