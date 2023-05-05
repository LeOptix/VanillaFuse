require 'nokogiri'

# hacemos que el archivo .vfuse exista :]
doc = Nokogiri::XML(File.open("brain.vfuse"))

# extraemos cosas del S E R E B E L O (o brain.vfuse)
app_type = doc.xpath("//vanillafuse/@type").text
app_arch = doc.xpath("//vanillafuse/@arch").text
imports = doc.xpath("//vanillafuse/imports/import").map(&:text)
title = doc.xpath("//vanillafuse/data/data[@type='title']/@value").text
favicon = doc.xpath("//vanillafuse/data/data[@type='favicon']/@value").text
text_var = doc.xpath("//vanillafuse/vars/var[@type='text']/@value").text
error_handler = doc.xpath("//vanillafuse/handler/case[@name='crash']/act").text

# la imprimimos. pa q? pos pa verificar que funciona
puts app_type
puts app_arch
puts imports.inspect
puts title
puts favicon
puts text_var
puts error_handler

def parse_page(file_path)
    # esto está duplicado. pq?
    doc = Nokogiri::XML(File.open(file_path))
  
    # extraer info
    body = doc.xpath("//vanillafuse/body").to_s
    styling = doc.xpath("//vanillafuse/styling").to_s
  
    # ehhhhh no entiendo ni mi propio codigo wtf
    {
      body: body,
      styling: styling
    }
  end  