require 'curb'

module Aggre
  module Jobs

    # Скачает файл, распарсит и поместит содержимое в базу.

    class DoImportsJob

      include Backburner::Performable
      queue 'imports'


      def initialize(logger = nil)
        @logger = logger || Logger.new(STDOUT)
      end


      # @param [String] url  Урл стороннего yml-файла, который надо импортировать в базу.
      # Метод класса для использования с Backburner.
      #
      def self.exe(url, logger = nil)
        instance = self.new logger
        instance.exe url
      end


      # @param [String] url  Урл стороннего yml-файла, который надо импортировать в базу.
      # Можно тестировать в консоли отдельно от всей системы.
      #
      def exe(url)
        @logger.info '<DoImportsJob#exe> [ASYNC] %s' % url
        xml = _download url
        return unless xml
        _process xml
      end


      private


      # Скачает файл и вернёт XML.
      #
      # @param  [String] url
      # @return [Nokogiri::XML || nil]
      #
      def _download(url)
        @logger.info '<DoImportsJob#_download> [ASYNC] %s' % url

        curl                 = ::Curl::Easy.new
        curl.url             = url
        curl.follow_location = true
        curl.perform

        case code = curl.response_code.to_i
          when 200
            @logger.info '<DoImportsJob#_download> [complete].'
            return Nokogiri::XML(curl.body)
          else
            @logger.warn '<DoImportsJob#_download> [error] response_code = %s.' % [url, code]
            return nil
        end

      end


      # Распарсит XML и положит в базу.
      # @param [Nokogiri::XML] xml
      #
      def _process(xml)
        shop_name  = xml.xpath('//shop/name').text
        categories = xml.xpath('//categories/category')

        # запишем магазин в базу
        shop_id    = ::Aggre::Services::RegisterShopByName.new.call shop_name

        # обработаем категории
        ::Aggre::Services::UpsertCategoriesService.new.call categories, shop_id

      end

    end
  end
end
