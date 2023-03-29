# pgライブラリを使用する
require 'pg'
# PG::connect(dbname: "goya")により、rubyからgoyaDBに接続し
# 接続したという情報をconnectionという名前の変数に格納する
connection = PG::connect(dbname: "goya")
connection.internal_encoding = "UTF-8"
begin
  # connection変数を使いPostgreSQLを操作する
  # .execで、goyaDBに"select weight, give_for from crops;"
  # のSQLの命令文を直接実行し、その結果をresult変数に格納する
  result = connection.exec("select weight, give_for from crops;")
  # 取り出した各行を処理する
  result.each do |record|
    # 各行を取り出し、putsでターミナル上に出力する
    puts "ゴーヤの大きさ：#{record["weight"]}　売った相手：#{record["give_for"]}"
  end

  result1 = connection.exec("select weight, give_for from crops where give_for != '自家消費';")

  result1.each do |record1|
    puts "ゴーヤの大きさ：#{record1["weight"]} 売った相手：#{record1["give_for"]}"
  end

  result2 = connection.exec("select weight, give_for, quality from crops where quality = 'false';")

  result2.each do |record2|
    puts "ゴーヤの大きさ：#{record2["weight"]}　売った相手：#{record2["give_for"]} 品質：#{record2["quality"]}"
  end
ensure
  # 最後に.finishでデータベースへのコネクションを切断する
  connection.finish
end

# #<% result_false.each do |record_false| %>
#       <% date_false << "ゴーヤの大きさ：#{record_false["weight"]}　売った相手：#{record_false["give_for"]}" %>
#     <% end %>
#
#     <%= date_false %>  ## これを追記