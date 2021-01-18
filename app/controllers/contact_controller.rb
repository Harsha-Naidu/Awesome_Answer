class ContactController < ApplicationController
    def index

    end
    def create
        @full_name=params[:full_name]
    end
end
