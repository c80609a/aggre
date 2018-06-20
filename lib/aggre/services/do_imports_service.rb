module Aggre
  module Services

    #
    # Прослойка между контроллером и, собственно, асинхронной работой.
    #
    # Здесь можно добавить предварительную проверку,
    # чтобы не запрашивать файл, который не менялся с последнего момента импорта.
    # Например: curl -s -v -X HEAD http://...xml 2>&1 | grep '^< Last-Modified:'
    #

    class DoImportsService

      # @param [Array of Strings] urls Урлы yml-файлов сторонних магазинов.
      def initialize(urls)
        @urls = urls
      end


      def call
        @urls.each { |url| Aggre::Jobs::DoImportsJob.async.exe url }
      end

    end
  end
end
