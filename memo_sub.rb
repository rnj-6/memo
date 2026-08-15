require "csv"  # CSVライブラリを読み込み

puts "1 → 新規でメモを作成する  /  2 → 既存のメモを編集する"
memo_type = nil

loop do   # 1 か 2 を入力するまでループ
    memo_type = gets.to_i  # ユーザーの入力値を整数に変換
    break if memo_type == 1 || memo_type == 2
    puts "★ 1 か 2 を入力してください。"
end


if memo_type == 1   # 新規作成
    puts "★ 拡張子を除いたファイル名を入力してください。"
    file_name = gets.chomp   # 新規のファイル名を受け取る

    puts "★ 本文を入力してください。"
    puts "★ 入力が終わったら Ctrl + Z の後に Enter を押してください。"
    memo = readlines(chomp: true)   # メモの内容を受け取る

    CSV.open("#{file_name}.csv", "w") do |csv|   # メモの内容を1行ずつ保存
      memo.each do |memo|
        csv << [memo]                
      end
    end

    puts "★ ファイル名:#{file_name} を保存しました。"


elsif memo_type == 2   # 既存編集
    puts "★ 編集したいメモのファイル名を、拡張子を除いて入力してください。"
    files = Dir.glob("*.csv")      # lesson_ruby内のcsvファイル一覧を表示
    files.each_with_index do |file, index|
        puts "#{ index + 1 }: #{file}"
    end

    file_name = gets.chomp   # ファイル名を受け取る
    data = CSV.read("#{file_name}.csv")   # 指定されたファイルを読み込む
    puts "-----------------"
    puts data
    puts "-----------------"

    puts "★ 本文を入力してください。"
    puts "★ 入力が終わったら Ctrl + Z の後に Enter を押してください。"
    memo = readlines(chomp: true)   # メモの内容を受け取る

    CSV.open("#{file_name}.csv", "a") do |csv|
      memo.each do |memo|
        csv << [memo]
      end
    end
    puts "★ 編集が完了しました。"
end

