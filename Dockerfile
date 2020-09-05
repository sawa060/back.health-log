FROM ruby:2.5

ENV LANG=C.UTF-8 \
  TZ=Asia/Tokyo

ENV APP_ROOT /app
WORKDIR /app

RUN apt-get update -qq && \
  apt-get install -y nodejs default-mysql-client

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# ホスト側（ローカル）のGemfileを追加する（ローカルのGemfileは【３】で作成）
ADD ./Gemfile $APP_ROOT/Gemfile
ADD ./Gemfile.lock $APP_ROOT/Gemfile.lock
RUN bundle install
ADD . $APP_ROOT

CMD ["rails", "server", "-b", "0.0.0.0"]
