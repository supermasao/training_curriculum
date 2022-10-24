class CalendarsController < ApplicationController

  # １週間のカレンダーと予定が表示されるページ
  def index
    getWeek
    @plan = Plan.new
    #paramsの中のplanは、ここで指定された！！学習用メモ
  end

  # 予定の保存
  def create
    Plan.create(plan_params)
    redirect_to action: :index
  end

  private

  def plan_params
    params.require(:plan).permit(:date, :plan)
    #params.require(:calendars).permit(:date, :plan) 学習用メモ
    #カレンダーの中のdateとplanが入っている 学習用メモ
    #カレンダーズなんて元々存在しないモデル名 学習用メモ
  end

  def getWeek
    #この定義内で曜日と日付と予定の３つを一括でまとめてる　学習メモ
    wdays = ['(日)','(月)','(火)','(水)','(木)','(金)','(土)']
    


    # Dateオブジェクトは、日付を保持しています。下記のように`.today.day`とすると、今日の日付を取得できます。
    @todays_date = Date.today
    # 例)　今日が2月1日の場合・・・ Date.today.day => 1日

    @week_days = []

    plans = Plan.where(date: @todays_date..@todays_date + 6)

    7.times do |x|
      today_plans = []
      plans.each do |plan|
        today_plans.push(plan.plan) if plan.date == @todays_date + x
        #.dateはカラムです。学習メモ
        #plan（一行）の中のplan。pulan（一行）の中のdate。学習メモ
      end
      y = Date.today.wday + x
      #現在、番号が返ってきてる

      wday_num = Date.today.wday + x
      if wday_num >= 7
        wday_num = wday_num - 7
        y = wday_num 
      end

      days = { :month => (@todays_date + x).month, :date => (@todays_date + x).day, :plans => today_plans, :wday => wdays[y] }
      @week_days.push(days)
      #42行目のdaysを43行目のdaysに代入　学習メモ
      #37〜43行目までは予定に関すること学習メモ
    end

  end
end
