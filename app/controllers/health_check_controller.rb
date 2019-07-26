class HealthCheckController < ApplicationController
    def index
        #ヘルスチェック 用にjsonを返す
        render json: '{ "status": "ok"}'
    end
end
