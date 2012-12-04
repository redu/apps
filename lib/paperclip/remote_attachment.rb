module Paperclip
  module RemoteAttachment
    extend ActiveSupport::Concern

    module ClassMethods
      def has_remote_file(name, opts={})
        @_ra_config = { :name => name || 'attachment' }

        attr_reader "#{@_ra_config[:name]}_remote_url"

        # Setter
        define_method "#{name}_remote_url=" do |url|
          fill_remote_url(name, url)
        end
      end
    end

    # Adiciona thumbnail a partir de URL. Atribui thumbnail default quando a URL
    # é inválida ou quanto está inalcançável.
    #
    # name: nome do attachment
    # url : url a ser atribuida
    def fill_remote_url(name, url)
      return unless url

      begin
        send("#{name}=", URI.parse(url))
        instance_variable_set(:"@#{name}_remote_url", url)
      rescue OpenURI::HTTPError, TypeError => e
        Rails.logger.error "Error: #{e.message}"
        Rails.logger.error "Entity: #{self.inspect}"
      end
    end
  end
end
