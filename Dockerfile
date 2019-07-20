FROM ruby:2.6.1
# RAILS_ENV と RAILS_MASTER_KEY あと挿できるようにする
ARG RAILS_ENV
ARG RAILS_MASTER_KEY
ENV APP_ROOT /app
#あと挿ししたRAILS_ENV と RAILS_MASTER_KEY を環境変数に設定する
ENV RAILS_ENV ${RAILS_ENV}
ENV RAILS_MASTER_KEY ${RAILS_MASTER_KEY}

WORKDIR $APP_ROOT
# まずは Gemfileのみを ADDしbundle install Λߦ͢·͍
ADD Gemfile $APP_ROOT
ADD Gemfile.lock $APP_ROOT
RUN \
bundle install && \
rm -rf ~/.gem
ADD . $APP_ROOT
# RAILS_ENV がproduction の時 assets:precompile を実行するようにしている
RUN if [ "${RAILS_ENV}" = "production" ]; then bundle exec rails assets:precompile; else export RAILS_ENV=development; fi
EXPOSE 3000
CMD ["rails", "server", "-b", "0.0.0.0"]