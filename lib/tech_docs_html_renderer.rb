require 'middleman-core/renderers/redcarpet'

class TechDocsHTMLRenderer < Middleman::Renderers::MiddlemanRedcarpetHTML
  include Redcarpet::Render::SmartyPants

  def header(text, level)
    anchor = UniqueIdentifierGenerator.instance.create(text, level)
    %(<h#{level} id="#{anchor}">#{text}</h#{level}>)
  end

  def image(link, *args)
    href = link 
    if args.length == 2 then
      image_tag_value = super(link, args[0], args[1])
      href = /src="([^"]+)/.match(image_tag_value)[1]
    end 
    
    %(<a href="#{href}" target="_blank" rel="noopener noreferrer">#{super}</a>)
  end

  def table(header, body)
    "<div class=\"table-container\">" \
      "<table>" \
        "#{header}#{body}" \
      "</table>" \
    "</div>"
  end
end
