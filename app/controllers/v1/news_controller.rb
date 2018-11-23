module V1
    class NewsController < ApplicationController
        before_action :set_news, only: %i[update destroy]

        # GET /news
        def index
            news = News.all.order('id')
            render json: { success: true, data: news }, status: :ok
        end

        # POST /news
        def create
            news = News.create!(news_params)

            if news.save
                render json: { success: true, data: news }, status: :created
            else
                render_errors(news)
            end
        end

        # PUT /news/:id
        def update
            if @news.update(news_params)
                render json: { success: true, data: @news }, status: 200
            else
                render_errors(@news)
            end
        end

        # DELETE /news/:id
        def destroy
            if @news.destroy
                render json: { success: true }, status: 200
            else
                render_errors(@news)
            end
        end

        private

        def news_params
            # whitelist params
            params.permit(:title, :description, :content)
        end

        def set_news
            @news = News.find(params[:id])
            rescue StandardError => error
                render json: { success: false, error: error }, status: 404
        end

        def render_errors(model)
            render json: { success: false, error: ErrorSerializer.serialize(model.errors) }, status: :unprocessable_entity
        end
    end
end
