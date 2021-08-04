require "bowling"

describe "ボウリングのスコア計算" do
    
    #インスタンスの生成を共通化
    before do
        @game = Bowling.new
    end 
    
    describe "全体の合計" do
        context "すべての投球がガターだった場合" do
            it "0になること" do
                add_many_score(20,0)
                
                #合計を計算
                @game.calc_score
                
                expect(@game.total_score).to eq 0
            end 
        end 
        
        context "すべての投球で1ピンずつ倒した場合" do
            it "20になること" do
                add_many_score(20,1)
                
                #合計を計算
                @game.calc_score
                
                expect(@game.total_score).to eq 20
            end 
        end
        
        context "スペアをとった場合" do
            it "スペアボーナスが加算されること" do
                #第一プレームで3点、7点のスペア
                @game.add_score(3)
                @game.add_score(7)
                #第二プレームの一投目で4点
                @game.add_score(4)
                #以降はすべてガター
                add_many_score(17,0)
                #合計を計算
                @game.calc_score
                
            end 
        end 
        
    end
    
private
#複数回のスコア追加をまとめて実行する
    def add_many_score(count, pins)
        count.times do
            @game.add_many_score(pins)
        end 
    end
    
end