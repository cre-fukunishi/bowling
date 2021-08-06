require "bowling"

describe "ボウリングのスコア計算" do
    describe "全体の合計" do
        before do
            @game = Bowling.new
        end
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
                #期待する合計 *()内はボーナス点
                #3 + 7+ 4 + (4) = 18
                expect(@game.total_score).to eq 18
            end
        end
        context "フレーム違いでスペアになるようなスコアだった場合" do
            it "スペアボーナスが加算されないこと" do
                #第一プレームで3点、5点
                @game.add_score(3)
                @game.add_score(5)

                #第二プレームで5点、4点
                @game.add_score(5)
                @game.add_score(4)
                #以降はすべてガター
                add_many_score(16,0)
                #合計を計算
                @game.calc_score
                #期待する合計
                # 3 + 5 + 5 + 4 = 17
                expect(@game.total_score).to eq 17
            end
        end
        context "最終フレームでスペアを取った場合" do
            it "スペアボーナスが加算されないこと" do
                #第一プレームで3点、7点
                @game.add_score(3)
                @game.add_score(7)
                #第二プレームの一投目で4点
                @game.add_score(4)
                #15投はすべてガター
                add_many_score(15,0)
                #最終フレームで3点、7点のスペア
                @game.add_score(3)
                @game.add_score(7)
                 #合計を計算
                @game.calc_score
                #期待する合計
                # 3 + 7 + 4 + (4) + 3 + 7 = 28
                expect(@game.total_score).to eq 28
            end
        end
    end
end
private
#Run multiple times at once with same score
def add_many_score(count, pins)
    count.times do
        @game.add_score(pins)
    end
end