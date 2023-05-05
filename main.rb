require 'nokogiri'

def parse_page(file_path)
  doc = Nokogiri::XML(File.open(file_path))

  {
    body: doc.at_xpath('//vanillafuse/body').to_s,
    styling: doc.at_xpath('//vanillafuse/styling').to_s
  }
end

# Lee el archivo brain.vfuse
doc = Nokogiri::XML(File.read('brain.vfuse'))

# Extrae los valores de los metadatos
metadata = {
  client: doc.at_xpath('//vanillafuse/@client').value,
  title: doc.at_xpath('//vanillafuse/data/data[@type="title"]/@value').value,
  favicon: doc.at_xpath('//vanillafuse/data/data[@type="favicon"]/@value')&.value,
  desc: doc.at_xpath('//vanillafuse/data/data[@type="desc"]/@value')&.value,
  version: doc.at_xpath('//vanillafuse/data/data[@type="ver"]/@value')&.value,
  author: doc.at_xpath('//vanillafuse/data/data[@type="author"]/@value')&.value,
  filename: doc.at_xpath('//vanillafuse/data/data[@type="filename"]/@value')&.value,
  minreqs: {
    ram: doc.at_xpath('//vanillafuse/data/data[@type="minreqs"]/ram')&.text,
    storage: doc.at_xpath('//vanillafuse/data/data[@type="minreqs"]/storage')&.text
  },
  release_date: doc.at_xpath('//vanillafuse/data/data[@type="release-date"]/@value')&.value,
  contact_mail: doc.at_xpath('//vanillafuse/data/data[@type="contact"]/mail')&.content,
  contact_phone: doc.at_xpath('//vanillafuse/data/data[@type="contact"]/phone')&.content
}

# Imprime los metadatos
puts 'Metadatos:'
metadata.each do |key, value|
  if key == :minreqs
    puts 'Requisitos mínimos:'
    value.each do |minreq_key, minreq_value|
      puts "- #{minreq_key.capitalize}: #{minreq_value}"
    end
  else
    puts "#{key.capitalize}: #{value}"
  end
end

# Obtiene las variables globales
variables = {}
doc.xpath('//vanillafuse/vars/var').each do |node|
  variables[node.attributes['type'].value.to_sym] = node.attributes['value'].value
end

# Imprime las variables globales
puts 'Variables globales:'
variables.each do |key, value|
  puts "- #{key.capitalize}: #{value}"
end

# Obtiene el manejador de errores
error_handler = {}
doc.xpath('//vanillafuse/handler/case').each do |node|
  case_id = node.attributes['id'].value
  modal = node.at_xpath('.//modal')
  error_handler[case_id.to_sym] = modal.children.map(&:to_s).join("\n")
end

# Imprime el manejador de errores
puts 'Manejador de errores:'
error_handler.each do |key, value|
  puts "- #{key.capitalize}: #{value}"
end

index = parse_page('pages/index.vfuse')

puts 'Contenido de index.vfuse:'
puts
puts index[:body]

puts 'Styling de index.vfuse:'
puts
puts index[:styling]