require "date"
require "optparse"

NUMBER_OF_DAYS_IN_WEEK = 7

class Calendar
    def initialize(month = Date.today.month)
        month = parse_inputted_month || month
        @date = Date.new(2022, month, 1)
        @last_day_of_month = Date.new(2022, month, -1).day
        @weeks = []
    end

    def print_calendar
        set_weeks
        puts "      #{@date.mon}月 #{@date.year}"
        puts "日 月 火 水 木 金 土"
        @weeks.each do |week|
            puts week.join("")
        end
    end
    
    private

    def set_weeks
        set_first_week
        index_week = 1
        next_day = @weeks[0][-1].to_i + 1
        while next_day <= @last_day_of_month do
            @weeks << []
            NUMBER_OF_DAYS_IN_WEEK.times.each do |count|
                # 2桁か1桁かによって見た目を調整
                next_day < 10 ? @weeks[index_week] << " #{next_day} " : @weeks[index_week] << "#{next_day} "
                next_day += 1
            end
            index_week += 1
        end
    end

    # 第一周には日付がない曜日がある月もあるので他の週とは別に処理
    def set_first_week
        @weeks << []
        number_of_first_blank = @date.wday
        number_of_first_blank.times.each { @weeks[0] << "   "}
        (NUMBER_OF_DAYS_IN_WEEK - number_of_first_blank).times.each do |day|
            @weeks[0] << " #{day + 1} "
        end
    end

    def parse_inputted_month
        opt = OptionParser.new
        opt.on('-m')
        opt.parse!(ARGV)
        if ARGV[0].to_i.between?(1, 12)
            ARGV[0].to_i
        elsif ARGV[0]
            fail "１から１２の数字を入れてください"
        end
    end
end

calendar = Calendar.new()
calendar.print_calendar

