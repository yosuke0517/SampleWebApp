FROM ruby:2.6.1

# RAILS_ENV と RAILS_MASTER_KEY あと挿できるようにする
ARG RAILS_ENV
ARG RAILS_MASTER_KEY

ENV LANG C.UTF-8

ENV APP_ROOT /app
#あと挿ししたRAILS_ENV と RAILS_MASTER_KEY を環境変数に設定する
ENV RAILS_ENV ${RAILS_ENV}
ENV RAILS_MASTER_KEY ${RAILS_MASTER_KEY}

RUN curl -sL https://deb.nodesource.com/setup_10.x | bash - \
        && apt-get install -y nodejs
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs vim

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

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000
CMD ["rails", "server", "-b", "0.0.0.0"]
