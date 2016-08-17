class UploadXMLFile
    
  def upload(xml_file)
    xml = Nokogiri::XML(xml_file)    
    upload_result = {}
    upload_result[:validation_errors] = validate_xml(xml)
    if !upload_result[:validation_errors].any?
      upload_result[:data_errors] = validate_data(xml)
      if !upload_result[:data_errors].any?
        upload_result[:data_updates] = handle_data(xml)
      end
    end
    upload_result
  end
  
  private
    def validate_xml(xml)
      xsd_file_name = self.class.name.tableize.singularize
      xsd = Nokogiri::XML::Schema(File.read("app/services/#{xsd_file_name}.xsd"))    
      xsd.validate(xml)    
    end
  
end
