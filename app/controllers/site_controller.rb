class SiteController < ApplicationController

  def index

  end

  def imports
    # один и тот же action используется в двух режимах:
    #   1) юзер get-пришёл на страницу с формой.
    #   2) post запрос с той же формы на той же странице.

    if request.xhr?
      service = Aggre::Services::DoImportsService.new CONFIG[:xmls]
      if service.call
        render json: { :foo => :bar }           # TODO-my:: слать сообщение + реализовать JS, который его покажет юзеру
      else
        render json: { :message => :error }     # TODO-my:: реализовать JS, который покажет ошибку юзеру; ошибку слать русским текстом
      end
    else
      render :imports
    end
  end

end
